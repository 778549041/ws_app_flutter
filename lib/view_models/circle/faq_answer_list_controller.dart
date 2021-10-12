import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class FAQAnswerListController extends RefreshListController<AnswerModel> {
  final int type; //0全部回答，1我的回答
  final String? questionId;

  FAQAnswerListController({required this.type, this.questionId});

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<AnswerModel>?> loadData({int pageNum = 1}) async {
    AnswerListModel model = await DioManager().request<AnswerListModel>(
        DioManager.POST, Api.faqDetailAnswerListUrl, params: {
      'page': pageNum,
      'question_id': questionId,
      'is_oneself': type
    });
    return model.data;
  }
}
