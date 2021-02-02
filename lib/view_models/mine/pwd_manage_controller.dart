import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';

class PwdManageController extends GetxController {
  List<String> data;

  @override
  void onInit() {
    data = [
      "设置账号密码",
      "找回账号密码",
      "管理积分支付密码",
    ];
    super.onInit();
  }

  void listItemClick(int index) {
    if (index == 0 || index == 1) {
      Get.toNamed(Routes.CHANGEPWD);
    } else if (index == 2) {
      Get.toNamed(Routes.PAYAUTH);
    }
  }
}
