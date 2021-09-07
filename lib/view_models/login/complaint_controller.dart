import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class ComplaintController extends GetxController {
  var data = [].obs;
  final String province = Get.arguments['province'];
  final String city = Get.arguments['city'];
  final String store = Get.arguments['store'];
  final String name = Get.arguments['name'];
  final String vincode = Get.arguments['vincode'];
  String? storeid, inputStr;

  @override
  void onReady() {
    data.assignAll([
      {'title': '', 'content': ''},
      {'title': '省   份', 'content': province},
      {'title': '城   市', 'content': city},
      {'title': '特约店', 'content': store},
      {'title': '姓   名', 'content': name},
      {'title': '车架号', 'content': vincode},
      {
        'title': '手机号',
        'content': Get.find<UserController>().userInfo.value.member == null ? '' : Get.find<UserController>().userInfo.value.member!.mobile
      },
      {'title': '', 'content': ''},
      {'title': '', 'content': ''},
    ]);
    super.onReady();
  }

  Future submitAction() async {
    if (inputStr == null || inputStr?.length == 0) {
      EasyLoading.showToast('请输入申述内容',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel _model = await DioManager()
        .request<CommonModel>(DioManager.POST, Api.certifyFeedBackUrl, params: {
      'province': province,
      'city': city,
      'store': store,
      'name': name,
      'vin': vincode,
      'mobile': Get.find<UserController>().userInfo.value.member == null ? '' : Get.find<UserController>().userInfo.value.member!.mobile,
      'content': inputStr,
    });
    if (_model.success != null) {
      EasyLoading.showToast(_model.success!,
          toastPosition: EasyLoadingToastPosition.bottom);
      Future.delayed(Duration(seconds: 1), () {
        Get.back();
      });
    } else if (_model.error != null) {
      EasyLoading.showToast(_model.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
