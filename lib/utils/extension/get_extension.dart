import 'package:get/get.dart';
import 'package:ws_app_flutter/widgets/loading_dialog.dart';

extension GetExtension on GetInterface {
  showLoading({String message}) {
    if (Get.isDialogOpen) {
      Get.back();
    }
    Get.dialog(LoadingDialog(message: message,));
  }

  dismiss() {
    if (Get.isDialogOpen) {
      Get.back();
    }
  }
}