import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class ViolationController extends GetxController {
  var data = [].obs;
  String brandCode = '', engineNumber = '', vin = '';

  @override
  void onInit() {
    super.onInit();
    UserInfo _userInfo = Get.find<UserController>().userInfo.value;
    brandCode = _userInfo.member!.fLicPlate!;
    vin = _userInfo.member!.fVIN!;
    data.assignAll([
      {'title': '号牌类型', 'content': '新能源小型车', 'placeholder': ''},
      {
        'title': '号牌',
        'content': brandCode.length > 6
            ? brandCode.replaceRange(2, 6, '****')
            : brandCode,
        'placeholder': '请输入号牌'
      },
      {'title': '电机号', 'content': engineNumber, 'placeholder': '请输入电机号'},
      {
        'title': '车架号',
        'content': vin.length > 12 ? vin.replaceRange(5, 12, '*******') : vin,
        'placeholder': '请输入车架号'
      },
    ]);
  }

  //输入
  void inputAction(int index, String value) {
    if (index == 1) {
      brandCode = value;
    } else if (index == 2) {
      engineNumber = value;
    } else if (index == 3) {
      vin = value;
    }
    data.assignAll([
      {'title': '号牌类型', 'content': '新能源小型车', 'placeholder': ''},
      {'title': '号牌', 'content': brandCode, 'placeholder': '请输入号牌'},
      {'title': '电机号', 'content': engineNumber, 'placeholder': '请输入电机号'},
      {'title': '车架号', 'content': vin, 'placeholder': '请输入车架号'},
    ]);
  }

  void submitAction() async {
    if (brandCode.length == 0 || engineNumber.length == 0 || vin.length == 0) {
      EasyLoading.showToast('请确认信息是否填写完整',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    Get.toNamed(Routes.VIOLATIONLIST, arguments: {
      'brandCode': brandCode,
      'engineNumber': engineNumber,
      'vin': vin
    });
  }
}
