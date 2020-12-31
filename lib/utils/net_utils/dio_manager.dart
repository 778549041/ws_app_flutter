import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/utils/net_utils/base_entity.dart';
import 'package:ws_app_flutter/utils/net_utils/entity_factory.dart';
import 'package:ws_app_flutter/utils/net_utils/net_cache.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/retry_interceptor.dart';

class DioManager {
  //是否无网络重试
  static bool retryEnable = true;
  //请求方式
  static const String GET = 'get';
  static const String POST = 'post';
  static const String DELETE = 'delete';
  static const String PUT = 'put';

  static final DioManager _shared = DioManager._internal();
  factory DioManager() => _shared;

  Dio dio;
  CancelToken _cancelToken = new CancelToken();

  DioManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
          baseUrl: CacheKey.SERVICE_URL_HOST,
          connectTimeout: 30000,
          // 响应流上前后两次接受到数据的间隔，单位为毫秒。
          receiveTimeout: 30000,
          // Http请求头.
          headers: {
            'accept-language': 'zh-cn',
            'X-Requested-isWEBAPP': 'YES',
            'Cookie': '_SID=${CommonUtil.sid()}',
          },
          contentType: 'application/x-www-form-urlencoded');
      dio = Dio(options);

      // // 加内存缓存
      // dio.interceptors.add(NetCacheInterceptor());
      if (retryEnable) {
        dio.interceptors.add(
          RetryOnConnectionChangeInterceptor(
            requestRetrier: DioConnectivityRequestRetrier(
              dio: dio,
              connectivity: Connectivity(),
            ),
          ),
        );
      }
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          LogUtil.v('请求地址: ${options.baseUrl + options.path}');
          LogUtil.v('请求参数: ${options.data}');
        },
        onResponse: (Response response) {
          LogUtil.v('返回参数: ${response.data}');
        },
        onError: (DioError error) {
          LogUtil.v('错误信息: ${error.message}');
        },
      ));
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  // 请求，返回参数为 T
  /// [method]：请求方法，NWMethod.POST等
  /// [path]：请求地址
  /// [params]：请求参数
  /// [success]：请求成功回调
  /// [error]：请求失败回调
  /// [cancelToken] 请求统一标识，用于取消网络请求
  Future request<T>(String method, String path,
      {Map<String, dynamic> params,
      Function(T) success,
      Function(ErrorEntity) error,
      CancelToken cancelToken}) async {
    
    try {
      Response response = await dio.request(path,
          data: params,
          options: Options(method: method),
          cancelToken: cancelToken ?? _cancelToken);

      if (response != null) {
        Map respData;
        if (response.data is Map) {
          respData = response.data;
        } else {
          respData = _decodeData(response);
        }
        // BaseEntity entity = BaseEntity<T>.fromJson(respData);
        success(EntityFactory.generateOBJ<T>(respData));
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  // 请求，返回参数为 List<T>
  /// [method]：请求方法，NWMethod.POST等
  /// [path]：请求地址
  /// [params]：请求参数
  /// [success]：请求成功回调
  /// [error]：请求失败回调
  /// [cancelToken] 请求统一标识，用于取消网络请求
  Future requestList<T>(String method, String path,
      {Map<String, dynamic> params,
      Function(List<T>) success,
      Function(ErrorEntity) error,
      CancelToken cancelToken}) async {
    
    try {
      Response response = await dio.request(path,
          queryParameters: params,
          options: Options(method: method),
          cancelToken: cancelToken ?? _cancelToken);
      
      if (response != null) {
       Map respData;
        if (response.data is Map) {
          respData = response.data;
        } else {
          respData = _decodeData(response);
        }
        BaseEntity entity = BaseEntity<T>.fromJson(respData);
        success(entity.data);
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            String errMsg = error.response.statusMessage;
            return ErrorEntity(code: errCode, message: errMsg);
//          switch (errCode) {
//            case 400: {
//              return ErrorEntity(code: errCode, message: "请求语法错误");
//            }
//            break;
//            case 403: {
//              return ErrorEntity(code: errCode, message: "服务器拒绝执行");
//            }
//            break;
//            case 404: {
//              return ErrorEntity(code: errCode, message: "无法连接服务器");
//            }
//            break;
//            case 405: {
//              return ErrorEntity(code: errCode, message: "请求方法被禁止");
//            }
//            break;
//            case 500: {
//              return ErrorEntity(code: errCode, message: "服务器内部错误");
//            }
//            break;
//            case 502: {
//              return ErrorEntity(code: errCode, message: "无效的请求");
//            }
//            break;
//            case 503: {
//              return ErrorEntity(code: errCode, message: "服务器挂了");
//            }
//            break;
//            case 505: {
//              return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
//            }
//            break;
//            default: {
//              return ErrorEntity(code: errCode, message: "未知错误");
//            }
//          }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }
}
