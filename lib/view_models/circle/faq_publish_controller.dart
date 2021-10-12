import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class FAQPublishController extends GetxController {
  final int typeId = Get.arguments['type_id'];
  TextEditingController? textEditingController;
  FocusNode? focusNode;
  String? publishText;

  @override
  void onInit() {
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.onInit();
  }

  //输入内容变化
  void onInputChange(String input) {
    publishText = input;
  }

  //点击发布按钮
  Future publishQuestion() async {
    Get.focusScope?.unfocus();
    if (publishText?.length == 0) {
      //无任何内容
      EasyLoading.showToast('发布内容不能为空',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (publishText != null &&
        publishText!.length > 0 &&
        CommonUtil.isBlank(publishText)) {
      textEditingController?.text = '';
      return;
    }
    if (publishText != null && publishText!.length > 0) {
      _publishContentIsLegal();
    }
  }

  //检查发布文本内容是否合法
  Future _publishContentIsLegal() async {
    if (CommonUtil.containsLink(publishText)) {
      EasyLoading.showToast('发布内容中不能包含URL链接或网址',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circlePublishContentValidateUrl,
        params: {'content': publishText});
    if (model.result!) {
      _publishNetWork({'content': publishText!, 'type_id': typeId});
    } else {
      EasyLoading.showToast(model.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //发布操作网络请求
  Future _publishNetWork(Map<String, dynamic> params) async {
    CommonModel receive = await DioManager().request<CommonModel>(
        DioManager.POST, Api.publishQuestionUrl,
        params: params);
    if (receive.result! && receive.code == '200') {
      EasyLoading.showToast('发布成功',
          toastPosition: EasyLoadingToastPosition.bottom);
      Future.delayed(Duration(seconds: 1)).then((value) async {
        Get.back();
      });
    } else {
      EasyLoading.showToast(receive.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
