import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CircleTopicMoreListController extends RefreshListController<TopicModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<TopicModel>?> loadData({int pageNum = 1}) async {
    TopicListModel _model = await DioManager().request<TopicListModel>(
        DioManager.POST, Api.circleTopicListUrl,
        params: {"page": pageNum, 'is_all': '1'});
    return _model.list;
  }

  //选择话题
  void selectTopic(TopicModel model) {
    Get.toNamed(Routes.CIRCLTOPICLIST, arguments: {'topcid': model.topicId!});
  }
}
