import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/intre_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class SelectIntreController extends BaseController {
  List<String> selectIntres = List<String>(); //选中兴趣爱好
  List<IntresData> allIntres = List<IntresData>(); //所有兴趣爱好

  @override
  void onReady() async {
    IntresModel obj = await DioManager()
        .request<IntresModel>(DioManager.GET, Api.intrestListUrl);
    allIntres.addAll(obj.list);
    selectIntres.addAll(Get.find<UserController>().userInfo.value.member.interest);
    for (var select in selectIntres) {
      for (var item in allIntres) {
        if (item.name == select) {
          item.selected = true;
        }
      }
    }
    update();
    super.onReady();
  }

  //选择事件
  void selectItem(int index) {
    if (allIntres[index].selected) {
      allIntres[index].selected = false;
      selectIntres.remove(allIntres[index].name);
      update();
    } else {
      if (selectIntres.length < 5) {
        allIntres[index].selected = true;
        selectIntres.add(allIntres[index].name);
        update();
      } else {
        EasyLoading.showToast('最多选择五个',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    }
  }

  //跳过
  void jumpToNext() {
    print('object');
    if (Get.find<UserController>().userInfo.value.member.isVehicle == 'false') {
      Get.dialog(BaseDialog(
        title: '提示',
        content: Text('您还不是车主，请先认证'),
        rightText: '马上认证',
        onCancel: () {
          Get.offAllNamed(Routes.HOME);
          Get.find<UserController>().requestIMInfoAndLogin();
        },
        onConfirm: () {
          Get.find<UserController>().certifyVechile();
        },
      ));
    } else {
      Get.offAllNamed(Routes.HOME);
      Get.find<UserController>().requestIMInfoAndLogin();
    }
  }

  //保存
  void saveIntres(bool fromComplete) async {
    if (selectIntres.length < 2) {
      EasyLoading.showToast('最少选择两个',
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      CommonModel obj = await DioManager().request<CommonModel>(
          DioManager.POST, Api.changedIntrestUrl,
          params: {"interest": jsonEncode(selectIntres)});
      if (obj.success != null) {
        await Get.find<UserController>().getUserInfo();
        Future.delayed(Duration(seconds: 1)).then((value) {
          if (fromComplete) {
            jumpToNext();
          } else {
            Get.back();
          }
        });
      } else if (obj.error != null) {
        EasyLoading.showToast('提交失败！',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    }
  }
}
