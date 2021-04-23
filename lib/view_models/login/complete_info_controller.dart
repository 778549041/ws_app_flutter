import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class CompleteInfoController extends BaseController {
  TextEditingController nameController;
  TextEditingController professionController;
  var userInfo = UserInfo().obs;

  var phone = ''.obs; //手机号
  var sex = '请选择性别'.obs; //性别
  var birthday = '请选择出生日期'.obs; //出生日期
  var addr = '请选择现居地'.obs; //现居地

  @override
  void onInit() {
    userInfo.value = Get.find<UserController>().userInfo.value;
    nameController =
        TextEditingController(text: userInfo.value.member.name ?? '');
    professionController = TextEditingController();
    phone.value =
        userInfo.value.member.mobile.replaceFirst(RegExp(r'\d{4}'), '****', 3);
    super.onInit();
  }

  //直接跳过
  void jumpToNext() {
    //跳转兴趣标签
    Get.toNamed(Routes.SELECTINTREST, arguments: {'fromComplete': true});
  }

  //选择性别
  void selectSex() {
    Pickers.showSinglePicker(
      Get.context,
      data: ['男', '女'],
      onConfirm: (data) {
        sex.value = data;
      },
    );
  }

  //选择出生日期
  void selectBirth() {
    Pickers.showDatePicker(
      Get.context,
      onConfirm: (res) {
        birthday.value = '${res.year}-${res.month}-${res.day}';
      },
    );
  }

  //选择地址
  void selectAddress() async {
    Pickers.showAddressPicker(
      Get.context,
      initTown: '',
      addAllItem: false,
      onConfirm: (province, city, town) {
        addr.value = province + '/' + city + '/' + town;
      },
    );
  }

  //继续完善
  void nextStep() async {
    CommonModel obj = await Get.find<UserController>().changeUserInfo(
        name: nameController.text,
        gender: sex.value == '男'
            ? 'male'
            : sex.value == '女'
                ? 'female'
                : '',
        birthday: birthday.value == '请选择出生日期' ? '' : birthday.value,
        profession: professionController.text,
        area: addr.value == '请选择现居地' ? '' : addr.value);
    if (obj.success != null) {
      //跳转兴趣标签
      Get.toNamed(Routes.SELECTINTREST, arguments: {'fromComplete': true});
    }
  }
}
