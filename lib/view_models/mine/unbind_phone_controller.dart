import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class UnbindPhoneController extends GetxController {
  String code;
  var tipMessage = ''.obs;

  @override
  void onInit() {
    code = '';
    super.onInit();
  }

  //发送验证码
  Future<bool> sendCode() async {
    CommonModel obj = await DioManager().request<CommonModel>(
        DioManager.POST, Api.changedBindPhoneSendCodeUrl, params: {
      'mobile': Get.find<UserController>().userInfo.value.member.mobile
    });
    if (obj.success != null) {
      EasyLoading.showToast(obj.success,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (obj.error != null) {
      EasyLoading.showToast(obj.error,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    return true;
  }

  Future nextStep() async {
    if (code.length == 0) {
      EasyLoading.showToast('请输入验证码',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    CommonModel _model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.unbindPhoneUrl, params: {
      'mobile': Get.find<UserController>().userInfo.value.member.mobile,
      'vcode': code
    });
    if (_model.success != null) {
      Get.toNamed(Routes.MINEBINDNEWPHONE);
    } else if (_model.error != null) {
      tipMessage.value = _model.error;
    }
  }
}
