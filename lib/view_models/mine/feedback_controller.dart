import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class FeedBackController extends GetxController {
  TextEditingController? msgController;
  TextEditingController? mobileController;
  FocusNode? mobileFocusNode;

  @override
  void onInit() {
    msgController = TextEditingController();
    mobileController = TextEditingController();
    mobileFocusNode = FocusNode();
    super.onInit();
  }

  void submitted() async {
    String? _phone = mobileController?.text;
    if (_phone?.length == 0) {
      _phone = Get.find<UserController>().userInfo.value.member!.mobile;
    }
    if (!RegexUtil.isMobileExact(_phone!)) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (msgController?.text.length == 0) {
      EasyLoading.showToast('请先输入反馈内容',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel _model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.mineFeedBackUrl,
        params: {'mobile': _phone, 'content': msgController!.text});
    if (_model.success != null) {
      Get.back();
    } else if (_model.error != null) {
      EasyLoading.showToast(_model.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
