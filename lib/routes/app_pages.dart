import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_controller.dart';
import 'package:ws_app_flutter/view_models/enjoy/enjoy_controller.dart';
import 'package:ws_app_flutter/view_models/login/bind_controller.dart';
import 'package:ws_app_flutter/view_models/login/complete_info_controller.dart';
import 'package:ws_app_flutter/view_models/login/login_controller.dart';
import 'package:ws_app_flutter/view_models/login/select_intrest_controller.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_controller.dart';
import 'package:ws_app_flutter/view_models/net/net_controller.dart';
import 'package:ws_app_flutter/view_models/wow/activity_controller.dart';
import 'package:ws_app_flutter/view_models/wow/news_controller.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
import 'package:ws_app_flutter/view_models/wow/wow_controller.dart';
import 'package:ws_app_flutter/views/login/bind_phone_page.dart';
import 'package:ws_app_flutter/views/login/certify_page.dart';
import 'package:ws_app_flutter/views/login/complaint_page.dart';
import 'package:ws_app_flutter/views/login/complete_info_page.dart';
import 'package:ws_app_flutter/views/login/login_page.dart';
import 'package:ws_app_flutter/views/login/select_intrest_page.dart';
import 'package:ws_app_flutter/views/main/tabbar_page.dart';
import 'package:ws_app_flutter/views/mine/change_pwd_page.dart';
import 'package:ws_app_flutter/views/webview_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => MainTabBarPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<MainController>(() => MainController());
          Get.lazyPut<WowController>(() => WowController());
          Get.lazyPut<RecommendController>(() => RecommendController());
          Get.lazyPut<NewsController>(() => NewsController());
          Get.lazyPut<ActivityController>(() => ActivityController());
          Get.lazyPut<CircleController>(() => CircleController());
          Get.lazyPut<CarController>(() => CarController());
          Get.lazyPut<EnjoyController>(() => EnjoyController());
          Get.lazyPut<MineController>(() => MineController());
        })),
    GetPage(
        name: Routes.WEBVIEW,
        page: () => WebViewPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<NetConnectController>(() => NetConnectController());
        })),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginController>(() => LoginController());
        })),
    GetPage(
      name: Routes.CHANGEPWD,
      page: () => ChangePwdPage(),
    ),
    GetPage(
        name: Routes.BINDPHONE,
        page: () => BindPhonePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<BindController>(() => BindController());
        })),
    GetPage(
        name: Routes.COMPLETEINFO,
        page: () => CompleteInfoPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<CompleteInfoController>(() => CompleteInfoController());
        })),
    GetPage(
        name: Routes.SELECTINTREST,
        page: () => SelectIntrestPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SelectIntreController>(() => SelectIntreController());
        })),
    GetPage(
      name: Routes.CERTIFY,
      page: () => CertifyPage(),
    ),
    GetPage(
      name: Routes.COMPLAINT,
      page: () => ComplaintPage(),
    ),
  ];
}
