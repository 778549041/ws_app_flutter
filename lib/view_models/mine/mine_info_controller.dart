import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_sheet.dart';

class MineInfoController extends GetxController {
  var data = [].obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    UserInfo _userInfo = Get.find<UserController>().userInfo.value;
    var _address = _userInfo.member?.area;
    if (_address != null && _address.contains('mainland')) {
      _address = _address.split(':')[1];
    } else {
      _address = '';
    }
    data.assignAll([
      {"title": "", "content": ''},
      {"title": "昵    称", "content": _userInfo.member!.showName},
      {
        "title": "手 机 号",
        "content": _userInfo.member!.mobile != null
            ? _userInfo.member!.mobile!.replaceFirst(RegExp(r'\d{4}'), '****', 3)
            : ''
      },
      {"title": "性    别", "content": _userInfo.member!.sex == '0' ? '女' : '男'},
      {
        "title": "出生日期",
        "content": _userInfo.member!.bYear != null && _userInfo.member!.bYear!.length > 0
            ? (_userInfo.member!.bYear! +
                '-' +
                (_userInfo.member!.bMonth != null && _userInfo.member!.bMonth!.length == 2
                    ? _userInfo.member!.bMonth!
                    : ('0' + _userInfo.member!.bMonth!)) +
                '-' +
                (_userInfo.member!.bDay != null && _userInfo.member!.bDay!.length == 2
                    ? _userInfo.member!.bDay!
                    : ('0' + _userInfo.member!.bDay!)))
            : ''
      },
      {"title": "职    业", "content": _userInfo.member?.profession == null ? '' : _userInfo.member?.profession},
      {"title": "现 居 地", "content": _address},
      {"title": "设置兴趣爱好", "content": ''},
      {"title": "我的收货地址", "content": ''}
    ]);
  }

  //点击头像
  void clickAvatar() {
    Get.bottomSheet(
      CustomSheet(
        title: '图片选择',
        dataArr: ['去拍照', '从相册选择'],
        clickCallback: (selectIndex, selectText) async {
          if (selectIndex == 1) {
            if (await PermissionManager()
                .requestPermission(Permission.camera)) {
              uploadAvatar(ImageSource.camera);
            }
          } else if (selectIndex == 2) {
            if (await PermissionManager()
                .requestPermission(Permission.photos)) {
              uploadAvatar(ImageSource.gallery);
            }
          }
        },
      ), //设置圆角
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
    );
  }

  //我的二维码
  void clickQR() {
    Get.toNamed(Routes.MINEQR);
  }

  //上传头像
  Future uploadAvatar(ImageSource source) async {
    var _image = await ImagePicker().pickImage(source: source);
    if (_image == null) {
      return;
    }
    Uint8List bytes = await _image.readAsBytes();
    String bs64 = base64Encode(bytes);
    String bs64Image = "data:image/png;base64," + bs64;
    CommonModel _model = await DioManager().request<CommonModel>(
        DioManager.POST, 'index.php/m/imagemanage-upload.html',
        params: {'avatar': bs64Image});
    CommonModel _res = await DioManager().request<CommonModel>(
        DioManager.POST, 'm/my-avatar.html',
        params: {'avatar': _model.imageId});
    if (_res.success != null) {
      EasyLoading.showToast('修改头像成功',
          toastPosition: EasyLoadingToastPosition.bottom);
      await Get.find<UserController>().getUserInfo();
    }
  }

  void listItemClick(int index) {
    if (index == 1) {
      Get.toNamed(Routes.MINECHANGENAME, arguments: {'isName': true});
    } else if (index == 2) {
      Get.toNamed(Routes.MINEPHONE);
    } else if (index == 3) {
      selectSex();
    } else if (index == 4) {
      selectBirth();
    } else if (index == 5) {
      Get.toNamed(Routes.MINECHANGENAME,arguments: {'isName': false});
    } else if (index == 6) {
      Get.toNamed(Routes.MINECHANGEAREA);
    } else if (index == 7) {
      Get.toNamed(Routes.SELECTINTREST);
    } else if (index == 8) {
      Get.toNamed(Routes.MINESHOPADDRLIST);
    }
  }

  //选择性别
  void selectSex() {
    Pickers.showSinglePicker(
      Get.context!,
      data: ['男', '女'],
      onConfirm: (data, position) async {
        await Get.find<UserController>().changeUserInfo(
            gender: data == '男'
                ? 'male'
                : data == '女'
                    ? 'female'
                    : '');
        initData();
      },
    );
  }

  //选择出生日期
  void selectBirth() {
    Pickers.showDatePicker(
      Get.context!,
      onConfirm: (res) async {
        var birthday = '${res.year}-${res.month}-${res.day}';
        await Get.find<UserController>().changeUserInfo(birthday: birthday);
        initData();
      },
    );
  }
}
