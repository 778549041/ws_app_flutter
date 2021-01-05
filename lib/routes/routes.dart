import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/bind_controller.dart';
import 'package:ws_app_flutter/view_models/login/complete_info_controller.dart';
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
      page: () => MainTabBarPage(),
    ),
    GetPage(
        name: WEBVIEW,
        page: () => WebViewPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<NetConnectController>(() => NetConnectController());
        })),
    GetPage(
        name: LOGIN,
        page: () => LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginController>(() => LoginController());
        })),
    GetPage(
      name: CHANGEPWD,
      page: () => ChangePwdPage(),
    ),
    GetPage(
      name: BINDPHONE,
      page: () => BindPhonePage(),
      binding: BindingsBuilder((){
        Get.lazyPut<BindController>(() => BindController());
      })
    ),
    GetPage(
      name: COMPLETEINFO,
      page: () => CompleteInfoPage(),
      binding: BindingsBuilder((){
        Get.lazyPut<CompleteInfoController>(() => CompleteInfoController());
      })
    ),
    GetPage(
      name: CERTIFY,
      page: () => CertifyPage(),
    ),
    GetPage(
      name: COMPLAINT,
      page: () => ComplaintPage(),
    ),
  ];
}
