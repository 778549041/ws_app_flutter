import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_controller.dart';
import 'package:ws_app_flutter/view_models/enjoy/enjoy_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
import 'package:ws_app_flutter/view_models/wow/wow_controller.dart';

class MainController extends BaseController {
  DateTime? _lastPressed;
  TabController? tabController;

  @override
  void onInit() async {
    Get.lazyPut<WowController>(() => WowController());
    Get.lazyPut<CircleController>(() => CircleController());
    Get.lazyPut<CarController>(() => CarController());
    Get.lazyPut<EnjoyController>(() => EnjoyController());
    Get.lazyPut<MineController>(() => MineController());

    Get.find<UserController>().requestNewMessage();
    super.onInit();
  }

  //返回
  Future<bool> onWillPop() async {
    if (_lastPressed == null ||
        DateTime.now().difference(_lastPressed!) > Duration(seconds: 1)) {
      //两次点击间隔超过1秒则重新计时
      _lastPressed = DateTime.now();
      return false;
    }
    return true;
  }

  //tabbaritem点击
  void onItemTap(int index) async {
    tabController?.animateTo(index);
    Get.find<UserController>().getUserInfo().then((value) {
      if (!Get.find<UserController>().userInfo.value.isLogin!) {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
    if (index == 4) {
      Get.find<MineController>().initData();
      Get.find<UserController>().requestNewMessage();
    } else if (index == 1) {
      Get.find<UserController>().requestNewMessage();
    }
    Get.find<EletricController>().cancelAllTimer();
    if (index == 0 || index == 2) {
      Get.find<EletricController>().addAllTimer();
    }
  }
}
