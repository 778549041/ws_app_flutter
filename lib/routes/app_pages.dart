import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/bind_controller.dart';
import 'package:ws_app_flutter/view_models/login/complete_info_controller.dart';
import 'package:ws_app_flutter/view_models/login/login_controller.dart';
import 'package:ws_app_flutter/view_models/login/select_intrest_controller.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';
import 'package:ws_app_flutter/view_models/mine/change_pwd_controller.dart';
import 'package:ws_app_flutter/view_models/mine/feedback_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_info_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pay_auth_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pay_changepwd_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pay_confirm_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pwd_manage_controller.dart';
import 'package:ws_app_flutter/view_models/mine/setting_controller.dart';
import 'package:ws_app_flutter/view_models/net/net_controller.dart';
import 'package:ws_app_flutter/views/login/bind_phone_page.dart';
import 'package:ws_app_flutter/views/login/certify_page.dart';
import 'package:ws_app_flutter/views/login/complaint_page.dart';
import 'package:ws_app_flutter/views/login/complete_info_page.dart';
import 'package:ws_app_flutter/views/login/login_page.dart';
import 'package:ws_app_flutter/views/login/select_intrest_page.dart';
import 'package:ws_app_flutter/views/main/tabbar_page.dart';
import 'package:ws_app_flutter/views/mine/add_shop_page.dart';
import 'package:ws_app_flutter/views/mine/change_area_page.dart';
import 'package:ws_app_flutter/views/mine/change_name_page.dart';
import 'package:ws_app_flutter/views/mine/change_phone_page.dart';
import 'package:ws_app_flutter/views/mine/change_pwd_page.dart';
import 'package:ws_app_flutter/views/mine/feed_back_page.dart';
import 'package:ws_app_flutter/views/mine/mine_info_page.dart';
import 'package:ws_app_flutter/views/mine/mine_qr_page.dart';
import 'package:ws_app_flutter/views/mine/pay_auth.dart';
import 'package:ws_app_flutter/views/mine/pay_change_pwd.dart';
import 'package:ws_app_flutter/views/mine/pay_confirm_pwd.dart';
import 'package:ws_app_flutter/views/mine/phone_page.dart';
import 'package:ws_app_flutter/views/mine/pwd_manage_page.dart';
import 'package:ws_app_flutter/views/mine/setting_page.dart';
import 'package:ws_app_flutter/views/mine/shop_address_list_page.dart';
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
        binding: BindingsBuilder(() {
          Get.lazyPut<ChangePwdController>(() => ChangePwdController());
        })),
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
    GetPage(
        name: Routes.PWDMANAGE,
        page: () => PwdManagePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PwdManageController>(() => PwdManageController());
        })),
    GetPage(
        name: Routes.PAYAUTH,
        page: () => PayAuthPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PayAuthController>(() => PayAuthController());
        })),
    GetPage(
        name: Routes.PAYCHANGEPWD,
        page: () => PayChangePwdPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PayChangePwdController>(() => PayChangePwdController());
        })),
    GetPage(
        name: Routes.PAYCONFIRMPWD,
        page: () => PayPwdConfirmPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PayConfirmController>(() => PayConfirmController());
        })),
    GetPage(
        name: Routes.FEEDBACK,
        page: () => FeedBackPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<FeedBackController>(() => FeedBackController());
        })),
    GetPage(
        name: Routes.MINEINFO,
        page: () => MineInfoPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<MineInfoController>(() => MineInfoController());
        })),
    GetPage(name: Routes.MINEQR, page: () => MineQRPage()),
    GetPage(name: Routes.MINECHANGENAME, page: () => ChangeNamePage()),
    GetPage(name: Routes.MINECHANGEAREA, page: () => ChangeAreaPage()),
    GetPage(name: Routes.MINEPHONE, page: () => PhonePage()),
    GetPage(name: Routes.MINECHANGEPHONE, page: () => ChangePhonePage()),
    GetPage(name: Routes.MINESHOPADDRLIST, page: () => ShopAddressListPage()),
    GetPage(name: Routes.MINEADDSHOP, page: () => AddShopPage()),
  ];
}
