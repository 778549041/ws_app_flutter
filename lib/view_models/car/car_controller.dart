import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class CarController extends BaseController {
  var userInfo = UserInfo().obs;

  @override
  void onInit() {
    userInfo.value = Get.find<UserController>().userInfo.value;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}