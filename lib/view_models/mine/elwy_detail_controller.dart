import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/package_detail.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class ElwyDetailController extends GetxController {
  final String orderid = Get.arguments['orderid'];
  var model = PackageDetailModel().obs;

  @override
  void onInit() async {
    super.onInit();
    model.value = await DioManager().request<PackageDetailModel>(
        DioManager.GET, Api.packagesDetailUrl,
        queryParamters: {'order_id': orderid});
  }
}
