import 'package:ws_app_flutter/models/enjoy/futc.dart';
import 'package:ws_app_flutter/models/enjoy/shop.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class EnjoyController extends RefreshListController {
  var futcModel = FUTCModel().obs;

  @override
  void onInit() {
    pageSize = 12;
    super.onInit();
  }

  @override
  Future<List> loadData({int pageNum}) async {
    if (pageNum == 1) {
      await _requestKVData();
    }

    return await _requestMallData(pageNum);
  }

  //服务套餐KV图片
  Future _requestKVData() async {
    futcModel.value = await DioManager().request<FUTCModel>(
        DioManager.POST, Api.enjoyFWTCKVImageUrl,
        params: {"type": "1"});
  }

  Future _requestMallData(int pageNum) async {
    ShopListModel _model = await DioManager().request<ShopListModel>(
        DioManager.GET, Api.enjoyMallListUrl,
        queryParamters: {"page": pageNum});
    return _model.dataList;
  }
}
