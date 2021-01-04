import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/routes/routes.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';

class UserController extends BaseController {
  var userInfo = UserInfo().obs; //用户信息
  var isLogin = false.obs; //是否登录

  @override
  void onReady() {
    getUserInfo();
    super.onReady();
  }

  //获取用户信息
  void getUserInfo() {
    DioManager().request<UserInfo>(
      DioManager.POST,
      Api.userInfoUrl,
      success: (UserInfo user) {
        userInfo.value = user;
        isLogin.value = (user.member != null);
        if (!isLogin.value) {
          //没有查到用户信息跳转到登录页面
          Get.offAllNamed(AppPages.LOGIN);
        }
      },
    );
  }

  //退出登录
  void logout() {
    DioManager().request<CommonModel>(
      DioManager.POST,
      Api.logoutUrl,
      success: (CommonModel obj) {
        if (obj.success != null) {
          userInfo.value = null;
          isLogin.value = false;
          Get.offAllNamed(AppPages.LOGIN);
        }
      },
    );
  }
}
