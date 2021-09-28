import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/comment_review_controller.dart';
import 'package:ws_app_flutter/view_models/circle/moment_review_controller.dart';

class ContentReviewController extends GetxController {
  final String topicid = Get.arguments['topicid'];

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<MomentReviewController>(() => MomentReviewController(topicid));
    Get.lazyPut<CommentReviewController>(() => CommentReviewController(topicid));
  }
}