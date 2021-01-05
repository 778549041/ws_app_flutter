import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/login_model.dart';
import 'package:ws_app_flutter/models/login/third_login_model.dart';
import 'package:ws_app_flutter/routes/routes.dart';
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
  var pwdBtnTitle = '获取验证码'.obs; //密码框按钮文本
  var enabled = true.obs; //验证码按钮是否能点击
  var aggree = false.obs; //是否同意协议
  var aggreeImageName = 'assets/images/login/login_unselected.png'.obs; //协议图片名称

  TimerUtil _timerUtil; //验证码倒计时
  TextEditingController nameController;
  TextEditingController pwdController;
  FocusNode pwdFocus;

  @override
  void onInit() {
    nameController = TextEditingController();
    pwdController = TextEditingController();
    pwdFocus = FocusNode();
    super.onInit();
  }

  //切换登录方式
  void switchLoginType(int index) {
    Get.focusScope.unfocus();
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
  void sendCode() {
    if (!enabled.value) {
      return;
    }
    String _phoneNumber = nameController.text;
    if (_phoneNumber.length == 0) {
      Fluttertoast.showToast(msg: '请输入手机号');
      return;
    }
    if (!RegexUtil.isMobileExact(_phoneNumber)) {
      Fluttertoast.showToast(msg: '手机号格式错误');
      return;
    }
    DioManager().request<CommonModel>(
      DioManager.POST,
      Api.loginSendCodeUrl,
      params: {'mobile': _phoneNumber},
      success: (CommonModel obj) {
        doCountDown();
        if (obj.success != null) {
          Fluttertoast.showToast(msg: obj.success);
        } else if (obj.error != null) {
          Fluttertoast.showToast(msg: obj.error);
        }
      },
      error: (error) {
        LogUtil.v(error.message);
      },
    );
  }

  //忘记密码
  void forgetPwdAction() {
    Get.toNamed(AppPages.CHANGEPWD);
  }

  //登录
  void loginAction() {
    String _phoneNumber = nameController.text;
    String _pwdStr = pwdController.text;
    var _params = Map<String, dynamic>();
    _params['uname'] = _phoneNumber;
    _params['password'] = _pwdStr;
    if (_phoneNumber.length == 0) {
      Fluttertoast.showToast(msg: '请输入手机号');
      return;
    }
    if (!RegexUtil.isMobileExact(_phoneNumber)) {
      Fluttertoast.showToast(msg: '手机号格式错误');
      return;
    }
    if (loginType.value == LoginType.AuthCodeType) {
      //验证码登录
      if (_pwdStr.length == 0) {
        Fluttertoast.showToast(msg: '请输入验证码');
        return;
      }
      _params['type'] = 'authcode';
    } else if (loginType.value == LoginType.PwdType) {
      //密码登录
      if (_pwdStr.length == 0) {
        Fluttertoast.showToast(msg: '请输入密码');
        return;
      }
      _params['type'] = 'password';
    }
    if (!aggree.value) {
      Fluttertoast.showToast(msg: '请仔细阅读《WOW STATION App隐私政策》及《广汽本田平台服务协议》');
      return;
    }
    DioManager().request<LoginModel>(
      DioManager.POST,
      Api.loginUrl,
      params: _params,
      success: (LoginModel obj) {
        if (obj.success != null) {
          Get.find<UserController>().getUserInfo();
          if (obj.data.firstLogin) {
            //首次登录即注册,完善信息
            Get.toNamed(AppPages.COMPLETEINFO);
          } else {
            Get.offNamed(AppPages.HOME);
          }
        } else if (obj.error != null || obj.redirect == '1002') {
          Fluttertoast.showToast(msg: obj.error);
        }
      },
    );
  }

  //是否同意协议
  void changeAggreeState() {
    if (aggree.value) {
      aggree.value = false;
      aggreeImageName.value = 'assets/images/login/login_unselected.png';
    } else {
      aggree.value = true;
      aggreeImageName.value = 'assets/images/login/login_selected.png';
    }
  }

  //微信登录
  void wechatLogin() {
    LogUtil.v('微信登录');
    if (!aggree.value) {
      Fluttertoast.showToast(msg: '请仔细阅读《WOW STATION App隐私政策》及《广汽本田平台服务协议》');
      return;
    }
    SharesdkPlugin.isClientInstalled(ShareSDKPlatforms.wechatSession)
        .then((result) {
      if (result == true) {
        SharesdkPlugin.auth(ShareSDKPlatforms.wechatSession, null,
            (SSDKResponseState state, Map user, SSDKError error) {
          if (state == SSDKResponseState.Success) {
            DioManager().request<ThirdLoginModel>(
              DioManager.POST,
              Api.wechatAuthLoginOrCertifyUrl,
              params: {
                'access_token': user['credential']['token'],
                'openid': user['rawData']['openid']
              },
              success: (ThirdLoginModel obj) {
                if (obj.data.binding != 'true') {
                  //未绑定
                  if (obj.data.wxUsed) {
                    //微信已被使用
                    if (obj.data.msg != null) {
                      Fluttertoast.showToast(msg: obj.data.msg);
                    }
                  } else {
                    //微信未被使用,绑定手机号
                    Get.toNamed(AppPages.BINDPHONE, arguments: {
                      "appleLogin": false,
                      "openid": user['rawData']['openid'],
                      "memberId": obj.data.memberId,
                      "unionid": user['rawData']['unionid']
                    });
                  }
                } else {
                  //已绑定
                  Get.find<UserController>().getUserInfo();
                  Get.offNamed(AppPages.HOME);
                }
              },
            );
          } else {
            LogUtil.v(error);
          }
        });
      } else {
        Fluttertoast.showToast(msg: '请先安装微信客户端');
      }
    });
  }

  //苹果登录
  void appleLogin() {
    LogUtil.v('苹果登录');
    if (!aggree.value) {
      Fluttertoast.showToast(msg: '请仔细阅读《WOW STATION App隐私政策》及《广汽本田平台服务协议》');
      return;
    }
    SharesdkPlugin.auth(ShareSDKPlatforms.apple, null,
        (SSDKResponseState state, Map user, SSDKError error) {
      if (state == SSDKResponseState.Success) {
        DioManager().request<CommonModel>(
          DioManager.POST,
          Api.appleLoginUrl,
          params: {
            'clientUser': user['credential']['uid'],
            'identityToken': user['credential']['token']
          },
          success: (CommonModel obj) {
            if (obj.result) {
              Get.find<UserController>().getUserInfo();
              Get.offNamed(AppPages.HOME);
            } else {
              if (obj.code == 1001) {
                //绑定手机号
                Get.toNamed(AppPages.BINDPHONE, arguments: {
                  "appleLogin": true,
                  "clientUser": user['credential']['uid'],
                  "identityToken": user['credential']['token'],
                });
              } else {
                Fluttertoast.showToast(msg: obj.message);
              }
            }
          },
        );
      } else {
        LogUtil.v(error);
      }
    });
  }

  @override
  void pushH5Page({Map<String, dynamic> args}) {
    Get.toNamed(AppPages.WEBVIEW, arguments: args);
    super.pushH5Page(args: args);
  }

  //倒计时
  void doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: 59 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      int _count = _tick.toInt();
      pwdBtnTitle.value = '$_count重新获取';
      enabled.value = false;
      if (_tick == 0) {
        enabled.value = true;
        pwdBtnTitle.value = '获取验证码';
      }
    });
    _timerUtil.startCountDown();
  }
}
