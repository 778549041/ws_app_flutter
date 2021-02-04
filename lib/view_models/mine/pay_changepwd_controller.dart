import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';

class PayChangePwdController extends GetxController {
  void nextStep(String input) {
    if (CommonUtil.checkPayPwd(input)) {
      EasyLoading.showToast('服务密码格式不正确',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    Get.toNamed(Routes.PAYCONFIRMPWD, arguments: {'lastInput': input});
  }
}
