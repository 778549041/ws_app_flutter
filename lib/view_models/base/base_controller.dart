import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/base/view_state.dart';

class BaseController extends GetxController {
  /// 当前的页面状态,默认为busy
  var viewState = ViewState.busy.obs;
  var viewStateError = ViewStateError(ViewStateErrorType.defaultError).obs;

  ///设置视图状态
  void setIdle() {
    viewState.value = ViewState.idle;
  }

  void setBusy() {
    viewState.value = ViewState.busy;
  }

  void setEmpty() {
    viewState.value = ViewState.empty;
  }

  void setError(e, stackTrace, {String message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;
    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else {
        message = e.error;
      }
    }
    viewState.value = ViewState.error;
    viewStateError.value =
        ViewStateError(errorType, message: message, errorMessage: e.toString());
  }

  ///获取视图状态，方便外部判断逻辑
  bool isBusy() {
    return viewState.value == ViewState.busy;
  }

  bool isIdle() {
    return viewState.value == ViewState.idle;
  }

  bool isEmpty() {
    return viewState.value == ViewState.empty;
  }

  bool isError() {
    return viewState.value == ViewState.error;
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  showErrorMessage({String message}) {
    if (viewStateError != null || message != null) {
      Future.microtask(() {
        Fluttertoast.showToast(msg: message);
      });
    }
  }

  //跳转前端页面
  void pushH5Page({Map<String, dynamic> args}) {
    Get.toNamed(Routes.WEBVIEW, arguments: args);
  }

  ///初始值设置可以放在这里
  @override
  void onInit() {
    super.onInit();
    debugPrint('ViewModel控制器---初始化--->$runtimeType');
  }

  ///路由操作、异步请求可以放在这里
  @override
  void onReady() {
    super.onReady();
    debugPrint('ViewModel控制器---准备完成--->$runtimeType');
  }

  ///关闭流用onClose方法，而不是dispose
  @override
  void onClose() {
    super.onClose();
    debugPrint('ViewModel控制器---关闭--->$runtimeType');
  }
}