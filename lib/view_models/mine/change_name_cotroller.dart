import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/view_models/mine/mine_info_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class ChangeNameController extends GetxController {
  String value;

  @override
  void onInit() {
    value = '';
    super.onInit();
  }

  void submmited(bool isName) async {
    CommonModel _model;
    if (isName) {
      if (value.length == 0) {
        value = Get.find<UserController>().userInfo.value.member.showName;
      }
      _model = await Get.find<UserController>().changeUserInfo(name: value);
    } else {
      _model =
          await Get.find<UserController>().changeUserInfo(profession: value);
    }
    if (_model.success != null) {
      EasyLoading.showToast('修改成功',
          toastPosition: EasyLoadingToastPosition.bottom);
      Future.delayed(Duration(seconds: 1)).then((value) => Get.back());
      Get.find<MineInfoController>().initData();
    }
  }
}
