import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class PayConfirmController extends GetxController {
  String input;
  final String lastInput = Get.arguments['lastInput'];

  @override
  void onInit() {
    super.onInit();
  }
  
  Future submitted() async {
    if (lastInput != input) {
      EasyLoading.showToast('两次设置密码不一致',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    if (CommonUtil.checkPayPwd(input)) {
      EasyLoading.showToast('服务密码格式不正确',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel _model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.changedServicePwdUrl,
        params: {'pay_pwd': lastInput, 'reppay_pwd': input});
    if (_model.success != null) {
      Get.until((route) => Get.currentRoute == Routes.PWDMANAGE);
    }
  }
}
