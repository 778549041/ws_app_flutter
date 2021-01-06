import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';

class UserController extends BaseController {
  var userInfo = UserInfo(member: Member(memberInfo:MemberInfo())).obs; //用户信息
  var isLogin = false.obs; //是否登录

  @override
  void onReady() {
    getUserInfo();
    super.onReady();
  }

  //获取用户信息
  Future getUserInfo() {
    return DioManager().request<UserInfo>(
      DioManager.POST,
      Api.userInfoUrl,
      success: (UserInfo user) {
        userInfo.value = user;
        isLogin.value = (user.member.memberId.length != 0);
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
          userInfo.value = UserInfo(member: Member(memberInfo:MemberInfo()));
          isLogin.value = false;
          Get.offAllNamed(Routes.LOGIN);
        }
      },
    );
  }
}
