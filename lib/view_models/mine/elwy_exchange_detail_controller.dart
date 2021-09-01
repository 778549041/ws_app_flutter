import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/exchange_package_detail_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class ElwyExchangeDetailController extends GetxController {
  final String goods_id = Get.arguments['goods_id'];
  final String bn = Get.arguments['bn'];
  var model = ExchangePackageDetailModel().obs;

  @override
  void onInit() async {
    super.onInit();
    model.value = await DioManager().request<ExchangePackageDetailModel>(
        DioManager.GET, Api.packagesExchangeDetailUrl,
        queryParamters: {'goods_id': goods_id, 'bn': bn});
  }

  void exchangePackage() {
    //TODO 兑换服务套餐
  }
}
