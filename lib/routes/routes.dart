import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/login_controller.dart';
import 'package:ws_app_flutter/view_models/net/net_controller.dart';
import 'package:ws_app_flutter/views/login/bind_phone_page.dart';
import 'package:ws_app_flutter/views/login/certify_page.dart';
import 'package:ws_app_flutter/views/login/complaint_page.dart';
import 'package:ws_app_flutter/views/login/complete_info_page.dart';
import 'package:ws_app_flutter/views/login/login_page.dart';
import 'package:ws_app_flutter/views/main/tabbar_page.dart';
import 'package:ws_app_flutter/views/mine/change_pwd_page.dart';
import 'package:ws_app_flutter/views/webview_page.dart';

class AppPages {
  static const INITIAL = '/';
  static const HOME = '/home';
  static const WEBVIEW = '/web-view';
  static const LOGIN = '/login';
  static const CHANGEPWD = '/change-pwd';
  static const BINDPHONE = '/bind-phone';
  static const COMPLAINT = '/complaint';
  static const COMPLETEINFO = '/complete-info';
  static const CERTIFY = '/certify';

  static final pages = [
    GetPage(
      name: HOME,
      transition: Transition.rightToLeft,
      page: () => MainTabBarPage(),
    ),
    GetPage(
        name: WEBVIEW,
        transition: Transition.rightToLeft,
        page: () => WebViewPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<NetConnectController>(() => NetConnectController());
        })),
    GetPage(
        name: LOGIN,
        transition: Transition.rightToLeft,
        page: () => LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginController>(() => LoginController());
        })),
    GetPage(
      name: CHANGEPWD,
      transition: Transition.rightToLeft,
      page: () => ChangePwdPage(),
    ),
    GetPage(
      name: BINDPHONE,
      transition: Transition.rightToLeft,
      page: () => BindPhonePage(),
    ),
    GetPage(
      name: COMPLETEINFO,
      transition: Transition.rightToLeft,
      page: () => CompleteInfoPage(),
    ),
    GetPage(
      name: CERTIFY,
      transition: Transition.rightToLeft,
      page: () => CertifyPage(),
    ),
    GetPage(
      name: COMPLAINT,
      transition: Transition.rightToLeft,
      page: () => ComplaintPage(),
    ),
  ];
}
