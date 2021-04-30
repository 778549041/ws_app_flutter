import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class EletricController extends BaseController {
  TimerUtil _timerUtil;
  var carDataModel = CarDataModel().obs;
  var charging = true.obs;
  var progressValue = 1.0.obs;
  var colors = [Color(0xFF2659FF), Color(0xFF01D4D7)].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    addTimer();
    super.onReady();
  }

  void cancelTimer() {
    if (_timerUtil != null) {
      _timerUtil.cancel();
      _timerUtil = null;
    }
  }

  void addTimer() {
    _timerUtil = TimerUtil(mInterval: 120 * 1000);
    _timerUtil.setOnTimerTickCallback((millisUntilFinished) async {
      await requestElectricityData();
    });
    _timerUtil.startTimer();
  }

  void requestElectricityData() async {
    carDataModel.value = await DioManager().request<CarDataModel>(
        DioManager.POST, Api.vechileEleDataUrl, queryParamters: {
      "member_id": Get.find<UserController>().userInfo.value.member.memberId
    });
    if (carDataModel.value.datas.rspBody.chargingStatus == 1 ||
        carDataModel.value.datas.rspBody.chargingStatus == 2) {
      charging.value = true;
      progressValue.value = 1.0;
      colors.assignAll([Color(0xFF2659FF), Color(0xFF01D4D7)]);
    } else {
      progressValue.value = carDataModel.value.datas.rspBody.soc / 100;
      charging.value = false;
      if (progressValue.value <= 0.25) {
        colors.assignAll([Color(0xFFE80016), Color(0xFFE80016)]);
      } else if (progressValue.value <= 0.50) {
        colors.assignAll([Color(0xFFF2AE2C), Color(0xFFF2AE2C)]);
      } else {
        colors.assignAll([Color(0xFF1EE623), Color(0xFF1EE623)]);
      }
    }
  }
}
