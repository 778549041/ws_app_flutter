import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class MineQuestionController extends RefreshListController<FAQModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<FAQModel>?> loadData({int pageNum = 1}) async {
    FAQListModel model = await DioManager().request<FAQListModel>(
        DioManager.POST, Api.mineQuestionListUrl,
        params: {'page': pageNum, 'limit': '10'});
    return model.data;
  }
}
