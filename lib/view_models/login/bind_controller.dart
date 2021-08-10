import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/bind_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class BindController extends BaseController {
  final bool appleLogin = Get.arguments['appleLogin'] ?? false;
  final String openid = Get.arguments['openid'] ?? '';
  final String memberId = Get.arguments['memberId'] ?? '';
  final String unionid = Get.arguments['unionid'] ?? '';
  final String clientUser = Get.arguments['clientUser'] ?? '';
  final String identityToken = Get.arguments['identityToken'] ?? '';

  var pwdBtnTitle = '获取验证码'.obs; //密码框按钮文本
  var enabled = true.obs; //验证码按钮是否能点击
  var errorMsg = ''.obs; //错误信息
  TimerUtil? _timerUtil; //验证码倒计时
  late TextEditingController nameController;
  late TextEditingController pwdController;
  late FocusNode pwdFocus;

  @override
  void onInit() {
    nameController = TextEditingController();
    pwdController = TextEditingController();
    pwdFocus = FocusNode();
    super.onInit();
  }

  //发送验证码
  void sendCode() async {
    if (!enabled.value) {
      return;
    }
    String _phoneNumber = nameController.text;
    if (_phoneNumber.length == 0) {
      EasyLoading.showToast('请输入手机号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (!RegexUtil.isMobileExact(_phoneNumber)) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel obj = await DioManager().request<CommonModel>(
        DioManager.POST, Api.bindPhoneSendCodeUrl,
        params: {'mobile': _phoneNumber});
    doCountDown();
    if (obj.success != null) {
      EasyLoading.showToast(obj.success!,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (obj.error != null) {
      EasyLoading.showToast(obj.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //绑定
  void bindAction() async {
    String _phoneNumber = nameController.text;
    String _pwdStr = pwdController.text;
    var _params = Map<String, dynamic>();
    _params['mobile'] = _phoneNumber;
    _params['vcode'] = _pwdStr;

    if (_phoneNumber.length == 0) {
      EasyLoading.showToast('请输入手机号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (!RegexUtil.isMobileExact(_phoneNumber)) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (_pwdStr.length == 0) {
      EasyLoading.showToast('请输入验证码',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (!appleLogin) {
      _params['openid'] = openid;
      _params['member_id'] = memberId;
      _params['unionid'] = unionid;
      BindModel obj = await DioManager().request<BindModel>(
          DioManager.POST, Api.bindPhoneUrl,
          params: _params);
      errorMsg.value = obj.data!.msg!;
      if (obj.result == 'success') {
        await Get.find<UserController>().getUserInfo();
        if (obj.data!.isMobile!) {
          //首页
          Get.toNamed(Routes.HOME);
        } else {
          //完善信息
          Get.toNamed(Routes.COMPLETEINFO);
        }
      }
    } else {
      _params['clientUser'] = clientUser;
      _params['identityToken'] = identityToken;
      AppleBindModel obj = await DioManager().request<AppleBindModel>(
          DioManager.POST, Api.appleBindPhoneUrl,
          params: _params);
      errorMsg.value = obj.message!;
      if (obj.result!) {
        await Get.find<UserController>().getUserInfo();
        if (!obj.firstLogin!) {
          //首页
          Get.toNamed(Routes.HOME);
        } else {
          //完善信息
          Get.toNamed(Routes.COMPLETEINFO);
        }
      }
    }
  }

  //倒计时
  void doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: 59 * 1000);
    _timerUtil!.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      int _count = _tick.toInt();
      pwdBtnTitle.value = '$_count重新获取';
      enabled.value = false;
      if (_tick == 0) {
        enabled.value = true;
        pwdBtnTitle.value = '获取验证码';
      }
    });
    _timerUtil!.startCountDown();
  }
}
