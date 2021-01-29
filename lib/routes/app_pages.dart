import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/bind_controller.dart';
import 'package:ws_app_flutter/view_models/login/complete_info_controller.dart';
import 'package:ws_app_flutter/view_models/login/login_controller.dart';
import 'package:ws_app_flutter/view_models/login/select_intrest_controller.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';
import 'package:ws_app_flutter/view_models/mine/setting_controller.dart';
import 'package:ws_app_flutter/view_models/net/net_controller.dart';
import 'package:ws_app_flutter/views/login/bind_phone_page.dart';
import 'package:ws_app_flutter/views/login/certify_page.dart';
import 'package:ws_app_flutter/views/login/complaint_page.dart';
import 'package:ws_app_flutter/views/login/complete_info_page.dart';
import 'package:ws_app_flutter/views/login/login_page.dart';
import 'package:ws_app_flutter/views/login/select_intrest_page.dart';
import 'package:ws_app_flutter/views/main/tabbar_page.dart';
import 'package:ws_app_flutter/views/mine/change_pwd_page.dart';
import 'package:ws_app_flutter/views/mine/setting_page.dart';
import 'package:ws_app_flutter/views/webview_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => MainTabBarPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<MainController>(() => MainController());
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
    GetPage(
        name: Routes.SETTING,
        page: () => SettingPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SettingController>(() => SettingController());
        })),
  ];
}
