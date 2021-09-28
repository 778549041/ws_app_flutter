import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/my_member_review_controller.dart';
import 'package:ws_app_flutter/view_models/circle/my_members_controller.dart';

class MemberReviewController extends GetxController {
  final String topicid = Get.arguments['topicid'];

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<MyMemberReviewController>(
        () => MyMemberReviewController(topicid));
    Get.lazyPut<MyMembersController>(() => MyMembersController(topicid));
  }
}
