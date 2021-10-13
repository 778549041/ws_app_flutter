import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class UnBindCarController extends GetxController {
  String? phone, code;

  @override
  void onInit() {
    phone = Get.find<UserController>()
        .userInfo
        .value
        .member!
        .mobile!
        .replaceFirst(RegExp(r'\d{4}'), '****', 3);
    code = '';
    super.onInit();
  }

  //发送验证码
  Future<bool> sendCode() async {
    CommonModel obj = await DioManager()
        .request<CommonModel>(DioManager.GET, Api.unbindCarSendCodeUrl);
    EasyLoading.showToast(obj.message!,
        toastPosition: EasyLoadingToastPosition.bottom);
    return true;
  }

  Future submitted() async {
    if (code?.length == 0) {
      EasyLoading.showToast('请输入验证码',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }

    CommonModel obj = await DioManager()
        .request<CommonModel>(DioManager.POST, Api.unbindCarUrl, params: {
      'phoneNumber': Get.find<UserController>().userInfo.value.member!.mobile,
      'vcode': code
    });
    if (obj.result!) {
      Get.until((route) => Get.currentRoute == Routes.HOME);
    } else {
      EasyLoading.showToast(obj.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
