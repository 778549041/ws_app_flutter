import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/leader_my_apply_topic_controller.dart';
import 'package:ws_app_flutter/view_models/circle/leader_my_topic_controller.dart';

class LeaderTopicListController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<LeaderMyTopicController>(() => LeaderMyTopicController());
    Get.lazyPut<LeaderMyApplyTopicController>(() => LeaderMyApplyTopicController());
  }
}