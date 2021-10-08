import 'package:ws_app_flutter/models/circle/topic_apply_join_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class MyMemberReviewController
    extends RefreshListController<TopicApplyJoinModel> {
  final String topicid;

  MyMemberReviewController(this.topicid);

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<TopicApplyJoinModel>?> loadData({int pageNum = 1}) async {
    TopicApplyJoinListModel model = await DioManager()
        .request<TopicApplyJoinListModel>(
            DioManager.GET, Api.applyJoinTopicListUrl,
            queryParamters: {'page': pageNum, 'topic_id': topicid});
    return model.data;
  }

  //成员审核
  void reviewAction(int examine, TopicApplyJoinModel model) async {
    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.GET, Api.reviewMomentUrl, queryParamters: {
      'topic_id': model.topic_id!,
      'info_id': model.id!,
      'examine': examine
    });
    if (result.result! && result.code == 200) {
      refresh();
    }
  }
}
