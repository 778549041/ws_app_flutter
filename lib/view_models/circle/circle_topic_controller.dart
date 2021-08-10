import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CircleTopicController extends RefreshListController<TopicModel> {
  @override
  void onInit() {
    pageSize = 10;
    super.onInit();
  }

  @override
  Future<List<TopicModel>?> loadData({int pageNum = 1}) async {
    TopicListModel _model = await DioManager().request<TopicListModel>(
        DioManager.POST, Api.circleTopicListUrl,
        queryParamters: {"page": pageNum});
    return _model.list;
  }

  //跳转话题列表
  void pushToTopicLst(String topicId) {
    Get.toNamed(Routes.CIRCLTOPICLIST, arguments: {'topcid': topicId});
  }
}
