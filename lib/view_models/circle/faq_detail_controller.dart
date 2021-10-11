import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/circle/faq_answer_list_controller.dart';

class FAQDetailController extends GetxController {
  final String questionId = Get.arguments['question_id'];
  var model = SingleFAQModel().obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<FAQAnswerListController>(() => FAQAnswerListController(0),
        tag: '0');
    Get.lazyPut<FAQAnswerListController>(() => FAQAnswerListController(1),
        tag: '1');
    _getQuestionDetailData();
  }

  void _getQuestionDetailData() async {
    model.value = await DioManager().request<SingleFAQModel>(
        DioManager.POST, Api.faqDetailQuestionUrl,
        params: {'question_id': questionId});
  }
}
