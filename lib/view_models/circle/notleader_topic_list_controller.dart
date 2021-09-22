import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class NotleaderTopicListController extends RefreshListController<TopicModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<TopicModel>?> loadData({int pageNum = 1}) async {
    TopicListModel model = await DioManager().request<TopicListModel>(
        DioManager.GET, Api.myTopicApplyListUrl,
        queryParamters: {'page': pageNum});
    return model.list;
  }
}
