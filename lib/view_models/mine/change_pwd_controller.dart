import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class ChangePwdController extends GetxController {
  String? phone, code, pwd, confirmPwd;
  final bool isForget = Get.arguments['isForget']; //区分是忘记密码还是修改密码，修改密码不能输入手机号

  @override
  void onInit() {
    String _mobile = Get.find<UserController>().userInfo.value.member!.mobile!;
    if (_mobile.length > 0) {
      phone = _mobile.replaceFirst(RegExp(r'\d{4}'), '****', 3);
    } else {
      phone = '';
    }

    code = '';
    pwd = '';
    confirmPwd = '';
    super.onInit();
  }

  //发送验证码
  Future<bool> sendCode() async {
    var _params = Map<String, dynamic>();
    if (phone?.length == 0) {
      EasyLoading.showToast('请输入手机号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    if (isForget) {
      _params['account'] = phone;
    } else {
      _params['account'] =
          Get.find<UserController>().userInfo.value.member!.mobile;
    }
    if (!RegexUtil.isMobileExact(_params['account'])) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    CommonModel obj = await DioManager().request<CommonModel>(
        DioManager.POST, Api.changedPwdSendCodeUrl,
        params: _params);
    if (obj.success != null) {
      EasyLoading.showToast(obj.success!,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (obj.error != null) {
      EasyLoading.showToast(obj.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    return true;
  }

  Future submitted() async {
    if (code?.length == 0) {
      EasyLoading.showToast('请输入验证码',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (pwd?.length == 0) {
      EasyLoading.showToast('请输入新密码',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (confirmPwd?.length == 0) {
      EasyLoading.showToast('请再次输入新密码',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (!CommonUtil.checkPwd(pwd) || !CommonUtil.checkPwd(confirmPwd)) {
      EasyLoading.showToast('密码格式不正确',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (pwd != confirmPwd) {
      EasyLoading.showToast('两次密码不一致',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    var _params = Map<String, dynamic>();
    if (isForget) {
      _params['account'] = phone;
    } else {
      _params['account'] =
          Get.find<UserController>().userInfo.value.member!.mobile;
    }
    _params['vcode'] = code;
    _params['new_password'] = pwd;
    _params['new_password1'] = confirmPwd;

    CommonModel obj = await DioManager().request<CommonModel>(
        DioManager.POST, Api.changedPwdSubmitUrl,
        params: _params);
    if (obj.success != null) {
      Get.back();
    } else if (obj.error != null) {
      EasyLoading.showToast(obj.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
