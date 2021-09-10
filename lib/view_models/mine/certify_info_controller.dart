import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class CertifyInfoController extends GetxController {
  var data = [].obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    UserInfo _userInfo = Get.find<UserController>().userInfo.value;
    data.assignAll([
      // {"title": "", "content": ''},
      {
        "title": "车架号码",
        "content": _userInfo.member?.fVIN == null
            ? ''
            : _userInfo.member!.fVIN!.replaceRange(5, 12, '*******')
      },
      {
        "title": "车牌号码",
        "content": _userInfo.member?.fLicPlate == null
            ? ''
            : _userInfo.member!.fLicPlate!
                .replaceRange(2, 6, '****'),
      },
      {
        "title": "车身颜色",
        "content": _userInfo.member?.fCarColor == null
            ? ''
            : _userInfo.member!.fCarColor!
      },
      {
        "title": "车主姓名",
        "content":
            _userInfo.member?.fName == null ? '' : _userInfo.member!.fName!,
      },
      {
        "title": "认证手机",
        "content": _userInfo.member?.fPhoneNum == null
            ? ''
            : _userInfo.member!.fPhoneNum!.replaceRange(3, 7, '****')
      },
      {
        "title": "认证时间",
        "content": _userInfo.member?.fcreateDate == null
            ? ''
            : DateUtil.formatDateMs(
                int.parse(_userInfo.member!.fcreateDate!) * 1000,
                format: DateFormats.y_mo_d)
      },
      {
        "title": "购车时间",
        "content": _userInfo.member?.fPurchaseDate == null
            ? ''
            : DateUtil.formatDateMs(
                int.parse(_userInfo.member!.fPurchaseDate!) * 1000,
                format: DateFormats.y_mo_d)
      },
    ]);
  }
}
