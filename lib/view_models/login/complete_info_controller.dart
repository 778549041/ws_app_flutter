import 'package:city_pickers/city_pickers.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
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
    Get.toNamed(Routes.SELECTINTREST);
  }

  //选择性别
  void selectSex() {
    DataPicker.showDatePicker(
      Get.context,
      datas: ['男', '女'],
      onConfirm: (value) {
        sex.value = value;
      },
    );
  }

  //选择出生日期
  void selectBirth() {
    DatePicker.showDatePicker(
      Get.context,
      pickerTheme: DateTimePickerTheme(
          confirm: Text(
            '确定',
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
          cancel: Text(
            '取消',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          )),
      minDateTime: DateTime.parse('1997-01-01'),
      maxDateTime: DateTime.parse('2100-01-01'),
      initialDateTime: DateTime.now(),
      dateFormat: 'yyyy-MMMM-dd',
      locale: DateTimePickerLocale.zh_cn,
      onClose: () => LogUtil.v('------close-----'),
      onCancel: () => LogUtil.v('------cancel------'),
      onConfirm: (dateTime, selectedIndex) {
        birthday.value = dateTime.toString().split(' ')[0];
      },
    );
  }

  //选择地址
  void selectAddress() async {
    Result result =
        await CityPickers.showCityPicker(context: Get.context, height: 256);
    if (result != null) {
      addr.value =
          result.provinceName + '/' + result.cityName + '/' + result.areaName;
    }
  }

  //继续完善
  void nextStep() async {
    CommonModel obj = await DioManager()
        .request<CommonModel>(DioManager.POST, Api.changeUserInfoUrl, params: {
      "contact[name]": nameController.text,
      "profile[gender]": sex.value == '男'
          ? 'male'
          : sex.value == '女'
              ? 'female'
              : '',
      "profile[birthday]": birthday.value == '请选择出生日期' ? '' : birthday.value,
      "contact[profession]": professionController.text,
      "contact[area]": addr.value == '请选择现居地' ? '' : addr.value,
    });
    if (obj.success != null) {
      //跳转兴趣标签
      Get.toNamed(Routes.SELECTINTREST);
    } else if (obj.error != null) {
      EasyLoading.showToast(obj.error,toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
