import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/login_model.dart';
import 'package:ws_app_flutter/models/login/third_login_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

enum LoginType {
  AuthCodeType,
  PwdType,
}

class LoginController extends BaseController {
  var loginType = LoginType.AuthCodeType.obs; //登录方式
  var placeholder = '请输入验证码'.obs; //验证码placeholder
  var pwdSecure = false.obs; //密码是否安全模式
  var clickedSecBtn = false.obs; //是否手动切换过密码模式
  var showSecure = false.obs; //是否显示眼睛
  var secureImageName = 'assets/images/login/login_eye_close.png'.obs; //眼睛图片名称
  var pwdKBType = TextInputType.number.obs; //密码键盘类型
  var aggree = false.obs; //是否同意协议
  var aggreeImageName = 'assets/images/login/login_unselected.png'.obs; //协议图片名称

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

  //切换登录方式
  void switchLoginType(int index) {
    Get.focusScope?.unfocus();
    pwdController.clear();
    if (index == 0) {
      loginType.value = LoginType.AuthCodeType;
      placeholder.value = '请输入验证码';
      showSecure.value = false;
      pwdKBType.value = TextInputType.number;
    } else if (index == 1) {
      loginType.value = LoginType.PwdType;
      placeholder.value = '请输入登录密码';
      showSecure.value = true;
      pwdKBType.value = TextInputType.visiblePassword;
    }
  }

  //密码模式
  bool pwdState() {
    if (loginType.value == LoginType.AuthCodeType) {
      return false;
    } else if (loginType.value == LoginType.PwdType) {
      if (clickedSecBtn.value) {
        return pwdSecure.value;
      } else {
        return true;
      }
    }
    return false;
  }

  //切换是否密码模式
  void switchSecure() {
    clickedSecBtn.value = true;
    if (pwdSecure.value) {
      pwdSecure.value = false;
      secureImageName.value = 'assets/images/login/login_pwd_unsec.png';
    } else {
      pwdSecure.value = true;
      secureImageName.value = 'assets/images/login/login_eye_close.png';
    }
  }

  //发送验证码
  Future<bool> sendCode() async {
    String _phoneNumber = nameController.text;
    if (_phoneNumber.length == 0) {
      EasyLoading.showToast('请输入手机号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    if (!RegexUtil.isMobileExact(_phoneNumber)) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    CommonModel obj = await DioManager().request<CommonModel>(
        DioManager.POST, Api.loginSendCodeUrl,
        params: {'mobile': _phoneNumber});
    if (obj.success != null) {
      EasyLoading.showToast(obj.success!,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else if (obj.error != null) {
      EasyLoading.showToast(obj.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    return true;
  }

  //忘记密码
  void forgetPwdAction() {
    Get.toNamed(Routes.CHANGEPWD, arguments: {'isForget': true});
  }

  //登录
  void loginAction() async {
    String _phoneNumber = nameController.text;
    String _pwdStr = pwdController.text;
    var _params = Map<String, dynamic>();
    _params['uname'] = _phoneNumber;
    _params['password'] = _pwdStr;
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
    if (loginType.value == LoginType.AuthCodeType) {
      //验证码登录
      if (_pwdStr.length == 0) {
        EasyLoading.showToast('请输入验证码',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      _params['type'] = 'authcode';
    } else if (loginType.value == LoginType.PwdType) {
      //密码登录
      if (_pwdStr.length == 0) {
        EasyLoading.showToast('请输入密码',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      _params['type'] = 'password';
    }
    if (!aggree.value) {
      EasyLoading.showToast('请仔细阅读《WOW STATION App隐私政策》及《广汽本田平台服务协议》',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    LoginModel obj = await DioManager().request<LoginModel>(
        DioManager.POST, Api.loginUrl,
        shouldLoading: true, params: _params);
    if (obj.success != null) {
      await Get.find<UserController>().getUserInfo();
      if (obj.data!.firstLogin!) {
        //首次登录即注册,完善信息
        Get.toNamed(Routes.COMPLETEINFO);
      } else {
        Get.offAllNamed(Routes.HOME);
        Get.find<UserController>().requestIMInfoAndLogin();
      }
    } else if (obj.error != null || obj.redirect == '1002') {
      EasyLoading.showToast(obj.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //是否同意协议
  void changeAggreeState() {
    var status;
    if (aggree.value) {
      aggree.value = false;
      aggreeImageName.value = 'assets/images/login/login_unselected.png';
      status = 0;
    } else {
      aggree.value = true;
      aggreeImageName.value = 'assets/images/login/login_selected.png';
      status = 1;
    }
    SharesdkPlugin.uploadPrivacyPermissionStatus(status, (success) {});
  }

  //微信登录
  void wechatLogin() {
    LogUtil.d('微信登录');
    if (!aggree.value) {
      EasyLoading.showToast('请仔细阅读《WOW STATION App隐私政策》及《广汽本田平台服务协议》',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    SharesdkPlugin.isClientInstalled(ShareSDKPlatforms.wechatSession)
        .then((result) {
      if (result == true) {
        SharesdkPlugin.auth(ShareSDKPlatforms.wechatSession, Map(),
            (SSDKResponseState state, dynamic user, SSDKError error) async {
          if (state == SSDKResponseState.Success) {
            ThirdLoginModel obj = await DioManager().request<ThirdLoginModel>(
                DioManager.POST, Api.wechatAuthLoginOrCertifyUrl,
                shouldLoading: true,
                params: {
                  'access_token': user['credential']['token'],
                  'openid': user['rawData']['openid']
                });
            if (obj.data!.binding != 'true') {
              //未绑定
              if (obj.data!.wxUsed!) {
                //微信已被使用
                if (obj.data!.msg != null) {
                  EasyLoading.showToast(obj.data!.msg!,
                      toastPosition: EasyLoadingToastPosition.bottom);
                }
              } else {
                //微信未被使用,绑定手机号
                Get.toNamed(Routes.BINDPHONE, arguments: {
                  "appleLogin": false,
                  "openid": user['rawData']['openid'],
                  "memberId": obj.data!.memberId,
                  "unionid": user['rawData']['unionid']
                });
              }
            } else {
              //已绑定
              await Get.find<UserController>().getUserInfo();
              Get.offAllNamed(Routes.HOME);
              Get.find<UserController>().requestIMInfoAndLogin();
            }
          } else {
            LogUtil.d(error);
          }
        });
      } else {
        EasyLoading.showToast('请先安装微信客户端',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }

  //苹果登录
  void appleLogin() {
    LogUtil.d('苹果登录');
    if (!aggree.value) {
      EasyLoading.showToast('请仔细阅读《WOW STATION App隐私政策》及《广汽本田平台服务协议》',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    SharesdkPlugin.auth(ShareSDKPlatforms.apple, Map(),
        (SSDKResponseState state, dynamic user, SSDKError error) async {
      if (state == SSDKResponseState.Success) {
        CommonModel obj = await DioManager().request<CommonModel>(
            DioManager.POST, Api.appleLoginUrl,
            shouldLoading: true,
            params: {
              'clientUser': user['credential']['uid'],
              'identityToken': user['credential']['token']
            });
        if (obj.result!) {
          await Get.find<UserController>().getUserInfo();
          Get.offAllNamed(Routes.HOME);
          Get.find<UserController>().requestIMInfoAndLogin();
        } else {
          if (obj.code == 1001) {
            //绑定手机号
            Get.toNamed(Routes.BINDPHONE, arguments: {
              "appleLogin": true,
              "clientUser": user['credential']['uid'],
              "identityToken": user['credential']['token'],
            });
          } else {
            EasyLoading.showToast(obj.message!,
                toastPosition: EasyLoadingToastPosition.bottom);
          }
        }
      } else {
        LogUtil.d(error);
      }
    });
  }
}
