import 'package:get/get.dart';
import 'package:ws_app_flutter/models/car/battery_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class BatteryController extends GetxController {
  var model = BatteryModel().obs;

  @override
  void onInit() async {
    super.onInit();
    model.value = await DioManager().request<BatteryModel>(
        DioManager.POST, Api.batteryCheckUrl, queryParamters: {
      'vin': Get.find<UserController>().userInfo.value.member!.fVIN!
    });
  }
}
