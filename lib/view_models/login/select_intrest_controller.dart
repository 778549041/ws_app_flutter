import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/intre_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class SelectIntreController extends BaseController {
  List<String> selectIntres = List<String>(); //选中兴趣爱好
  List<IntresData> allIntres = List<IntresData>(); //所有兴趣爱好

  @override
  void onReady() async {
    IntresModel obj = await DioManager()
        .request<IntresModel>(DioManager.GET, Api.intrestListUrl);
    allIntres.addAll(obj.list);
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
        Fluttertoast.showToast(msg: '最多选择五个');
      }
    }
  }

  //跳过
  void jumpToNext() {
    print('object');
    if (Get.find<UserController>().userInfo.value.member.isVehicle == 'false') {
      Get.dialog(CupertinoAlertDialog(
        title: Text('提示'),
        content: Text('您还不是车主，请先认证'),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () => Get.back(),
          ),
          FlatButton(
            child: Text('马上认证'),
            onPressed: () {
              Get.find<UserController>().certifyVechile();
            },
          )
        ],
      ));
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  //保存
  void saveIntres() async {
    if (selectIntres.length < 2) {
      Fluttertoast.showToast(msg: '最少选择两个');
    } else {
      CommonModel obj = await DioManager().request<CommonModel>(
          DioManager.POST, Api.changedIntrestUrl,
          params: {"interest": jsonEncode(selectIntres)});
      if (obj.success != null) {
        Fluttertoast.showToast(msg: '提交成功！');
      } else if (obj.error != null) {
        Fluttertoast.showToast(msg: '提交失败！');
      }
    }
  }
}
