import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/certify_model.dart';
import 'package:ws_app_flutter/models/login/third_login_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';

class UserController extends BaseController {
  var userInfo = UserInfo().obs; //用户信息
  var isLogin = false.obs; //是否登录

  @override
  void onReady() {
    getUserInfo();
    super.onReady();
  }

  //获取用户信息
  Future getUserInfo() async {
    UserInfo user =
        await DioManager().request<UserInfo>(DioManager.POST, Api.userInfoUrl);
    userInfo.value = user;
    isLogin.value = (user.member.memberId.length != 0);
  }

  //车主认证
  Future certifyVechile() async {
    CertifyModel obj = await DioManager()
        .request<CertifyModel>(DioManager.GET, Api.certifyVechileUrl);
    if (obj.code == 200) {
      //认证成功
      certifyResult();
    } else if (obj.code == 201) {
      //微信授权认证
      SharesdkPlugin.isClientInstalled(ShareSDKPlatforms.wechatSession)
          .then((result) {
        if (result == true) {
          SharesdkPlugin.auth(ShareSDKPlatforms.wechatSession, null,
              (SSDKResponseState state, Map user, SSDKError error) async {
            if (state == SSDKResponseState.Success) {
              ThirdLoginModel obj = await DioManager().request<ThirdLoginModel>(
                  DioManager.POST, Api.wechatAuthLoginOrCertifyUrl,
                  shouldLoading: true,
                  params: {
                    'access_token': user['credential']['token'],
                    'openid': user['rawData']['openid']
                  });
              if (obj.data.binding == 'true') {
                //已绑定
                certifyResult();
              }
            } else {
              LogUtil.v(error);
            }
          });
        } else {
          EasyLoading.showToast('请先安装微信客户端',toastPosition: EasyLoadingToastPosition.bottom);
        }
      });
    } else if (obj.code == 202) {
      //手动留资认证
      Get.toNamed(Routes.COMPLAINT);
    }
  }

  //认证结果
  void certifyResult() async {
    await Get.find<UserController>().getUserInfo();
    if (Get.find<UserController>().userInfo.value.member.isVehicle == 'true') {
      //认证成功
      if (Get.currentRoute == Routes.SELECTINTREST) {
        //如果当前路由是选择兴趣爱好,则跳转首页
        Get.offAllNamed(Routes.HOME);
      } else {
        //否则返回顶层页面,并切换到第一个tab页
        Get.until((route) => Get.currentRoute == Routes.HOME);
        Get.find<MainController>().onItemTap(0);
      }
    } else {
      //认证失败
      Get.toNamed(Routes.COMPLAINT);
    }
  }

  //退出登录
  void logout() async {
    CommonModel obj =
        await DioManager().request<CommonModel>(DioManager.POST, Api.logoutUrl);
    if (obj.success != null) {
      userInfo.value = UserInfo();
      isLogin.value = false;
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
