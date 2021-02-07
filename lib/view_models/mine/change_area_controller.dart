import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/view_models/mine/mine_info_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class ChangeAreaController extends GetxController {
  TextEditingController controller;
  var area = ''.obs;
  var address = ''.obs;

  @override
  void onInit() {
    UserInfo _userInfo = Get.find<UserController>().userInfo.value;
    area.value = _userInfo.member.area;
    if (_userInfo.member.area.contains('mainland')) {
      area.value = _userInfo.member.area.split(':')[1];
    }

    address.value = _userInfo.member.addr;
    controller = TextEditingController(text: address.value);
    super.onInit();
  }

  void submitted() async {
    CommonModel _model = await Get.find<UserController>()
        .changeUserInfo(addr: address.value, area: area.value);
    if (_model.success != null) {
      Future.delayed(Duration(seconds: 1)).then((value) => Get.back());
      Get.find<MineInfoController>().initData();
    }
  }

  //选择地址
  void selectAddress() async {
    Result result =
        await CityPickers.showCityPicker(context: Get.context, height: 256);
    if (result != null) {
      area.value =
          result.provinceName + '/' + result.cityName + '/' + result.areaName;
    }
  }
}
