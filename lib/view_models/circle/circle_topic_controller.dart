import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CircleTopicController extends RefreshListController {
  @override
  void onInit() {
    pageSize = 10;
    super.onInit();
  }

  @override
  Future<List> loadData({int pageNum}) async {
    TopicListModel _model = await DioManager().request<TopicListModel>(
        DioManager.GET, Api.circleTopicListUrl,
        queryParamters: {"page": pageNum});
    return _model.list;
  }
}
