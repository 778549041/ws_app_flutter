import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/mine_info_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class BindNewPhoneController extends GetxController {
  String phone, code;
  var tipMessage = ''.obs;

  @override
  void onInit() {
    phone = '';
    code = '';
    super.onInit();
  }

  //发送验证码
  Future<bool> sendCode() async {
    if (phone.length == 0) {
      EasyLoading.showToast('请输入手机号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }

    if (!RegexUtil.isMobileExact(phone)) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    CommonModel obj = await DioManager().request<CommonModel>(
        DioManager.POST, Api.changedBindPhoneSendCodeUrl,
        params: {'mobile':phone});
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
    if (phone.length == 0) {
      EasyLoading.showToast('请输入手机号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }

    if (!RegexUtil.isMobileExact(phone)) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }

    if (code.length == 0) {
      EasyLoading.showToast('请输入验证码',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    CommonModel _model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.bindNewPhoneUrl, params: {
      'mobile': phone,
      'vcode': code
    });
    if (_model.success != null) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        Get.until((route) => Get.currentRoute == Routes.MINEINFO);
      });
      await Get.find<UserController>().getUserInfo();
      Get.find<MineInfoController>().initData();
    } else if (_model.error != null) {
      tipMessage.value = _model.error;
    }
  }
}