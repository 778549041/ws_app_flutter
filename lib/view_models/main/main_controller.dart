import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_controller.dart';
import 'package:ws_app_flutter/view_models/enjoy/enjoy_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/activity_controller.dart';
import 'package:ws_app_flutter/view_models/wow/news_controller.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
import 'package:ws_app_flutter/view_models/wow/wow_controller.dart';

class MainController extends BaseController {
  var selectedIndex = 0.obs;
  DateTime _lastPressed;
  PageController pageController;

  @override
  void onInit() async {
    Get.lazyPut<WowController>(() => WowController());
    Get.lazyPut<RecommendController>(() => RecommendController());
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<ActivityController>(() => ActivityController());
    Get.lazyPut<CircleController>(() => CircleController());
    Get.lazyPut<CarController>(() => CarController());
    Get.lazyPut<EnjoyController>(() => EnjoyController());
    Get.lazyPut<MineController>(() => MineController());

    pageController = PageController(initialPage: selectedIndex.value);
    await Get.find<UserController>().requestNewMessage();
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
    if (index == 4) {
      await Get.find<MineController>().requestFavorData();
      await Get.find<UserController>().requestNewMessage();
    } else if (index == 1) {
      await Get.find<UserController>().requestNewMessage();
    }
    pageController.jumpToPage(index);
  }
}
