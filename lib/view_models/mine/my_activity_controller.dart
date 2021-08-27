import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/my_act_all_controller.dart';
import 'package:ws_app_flutter/view_models/mine/my_act_ing_controller.dart';
import 'package:ws_app_flutter/view_models/mine/my_act_nostart_controller.dart';
import 'package:ws_app_flutter/view_models/mine/my_act_over_controller.dart';

class MyActivityController extends GetxController {
  @override
  void onInit() {
    Get.lazyPut<MyActAllController>(() => MyActAllController());
    Get.lazyPut<MyActNostartController>(() => MyActNostartController());
    Get.lazyPut<MyActIngController>(() => MyActIngController());
    Get.lazyPut<MyActOverController>(() => MyActOverController());
    super.onInit();
  }
}