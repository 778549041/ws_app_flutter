import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/mine_circle_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_topic_follow_controller.dart';

class MineCircleTabController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<MineCircleController>(() => MineCircleController());
    Get.lazyPut<MineTopicFollowController>(() => MineTopicFollowController());
  }
}
