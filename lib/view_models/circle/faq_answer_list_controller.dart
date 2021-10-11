import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class FAQAnswerListController extends RefreshListController<AnswerModel> {
  final int type; //0全部回答，1我的回答

  FAQAnswerListController(this.type);

  @override
  void onInit() {
    super.onInit();
  }
  
  @override
  Future<List<AnswerModel>?> loadData({int pageNum = 1}) async {
    
  }
}
