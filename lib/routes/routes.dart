import 'package:get/get.dart';
import 'package:ws_app_flutter/views/login/login_page.dart';
import 'package:ws_app_flutter/views/main/tabbar_page.dart';
import 'package:ws_app_flutter/views/webview_page.dart';

class AppPages {
  static const INITIAL = '/';
  static const HOME = '/home';
  static const WEBVIEW = '/web-view';
  static const LOGIN = '/login';

  static final pages = [
    GetPage(
      name: HOME,
      page: () => MainTabBarPage(),
    ),
    GetPage(
      name: WEBVIEW,
      page: () => WebViewPage(),
    ),
    GetPage(
      name: LOGIN,
      page: () => LoginPage(),
    ),
  ];
}
