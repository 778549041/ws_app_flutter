import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class BindCarController extends GetxController {
  var data = [].obs;
  String? carOwnerName, identityCard = '', phoneNumber, engineNumber = '', vin;

  @override
  void onInit() {
    UserInfo _userInfo = Get.find<UserController>().userInfo.value;
    carOwnerName =
        _userInfo.member?.name == null ? '' : _userInfo.member!.name!;
    phoneNumber = _userInfo.member!.mobile!.replaceRange(3, 7, '****');
    vin = _userInfo.member!.fVIN!.replaceRange(5, 12, '*******');

    initData();
    super.onInit();
  }

  void initData() {
    data.assignAll([
      {'title': '姓名', 'content': carOwnerName, 'placeholder': '请输入姓名'},
      {'title': '身份证号', 'content': identityCard, 'placeholder': '请输入身份证号'},
      {'title': '手机号', 'content': phoneNumber, 'placeholder': '请输入手机号'},
      {
        'title': '发动机号码',
        'content': engineNumber,
        'placeholder': '请输入您行驶证上的发动机号码'
      },
      {'title': '车架号', 'content': '', 'placeholder': vin},
    ]);
  }

  //输入
  void inputAction(int index, String value) {
    if (index == 0) {
      carOwnerName = value;
    } else if (index == 1) {
      identityCard = value;
    } else if (index == 2) {
      phoneNumber = value;
    } else if (index == 3) {
      engineNumber = value;
    }
    initData();
  }

  //提交资料
  Future submitAction() async {
    if (carOwnerName == null || carOwnerName!.length == 0) {
      EasyLoading.showToast('请输入姓名',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (identityCard == null || identityCard!.length == 0) {
      EasyLoading.showToast('请输入身份证号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (phoneNumber == null || phoneNumber!.length == 0) {
      EasyLoading.showToast('请输入手机号',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (engineNumber != null && engineNumber!.length != 8) {
      EasyLoading.showToast('请输入正确的发动机号码',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.bindCarUrl,
        shouldLoading: true,
        params: {
          'carOwnerName': carOwnerName,
          'identityCard': identityCard,
          'phoneNumber': phoneNumber,
          'engineNumber': engineNumber,
          'vin': vin,
        });
    if (res.result!) {
      Future.delayed(Duration(seconds: 1)).then((value) async {
        Get.back();
      });
    }
  }
}
