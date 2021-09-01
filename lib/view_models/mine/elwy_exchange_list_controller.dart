import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/exchange_package_list_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class ElwyExchangeListController
    extends RefreshListController<ExchangePackageModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<ExchangePackageModel>?> loadData({int pageNum = 1}) async {
    ExchangePackageListModel model = await DioManager()
        .request<ExchangePackageListModel>(
            DioManager.GET, Api.packagesExchangeListUrl,
            queryParamters: {'page': pageNum});
    return model.list;
  }

  void pushDetail(ExchangePackageModel model) {
    Get.toNamed(Routes.ELWYEXCHANGEDETAIL,
        arguments: {'goods_id': model.goods_id, 'bn': model.bn});
  }
}
