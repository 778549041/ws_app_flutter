import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class MainController extends BaseController {
  var selectedIndex = 0.obs;
  DateTime _lastPressed;
  PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: selectedIndex.value);
    super.onInit();
  }

  //返回
  Future<bool> onWillPop() async {
    if (_lastPressed == null ||
        DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
      //两次点击间隔超过1秒则重新计时
      _lastPressed = DateTime.now();
      return false;
    }
    return true;
  }

  //pageview页面切换
  void onChangeValue(int index) {
    selectedIndex.value = index;
  }

  //tabbaritem点击
  void onItemTap(int index) async {
    await Get.find<UserController>().getUserInfo();
    pageController.jumpToPage(index);
  }
}
