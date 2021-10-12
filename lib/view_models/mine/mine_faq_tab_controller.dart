import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/mine_answer_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_question_controller.dart';

class MineFaqTabController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<MineQuestionController>(() => MineQuestionController());
    Get.lazyPut<MineAnswerController>(() => MineAnswerController());
  }
}