import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:ws_app_flutter/view_models/base/view_state.dart';

class MineTopicFollowController extends RefreshListController<TopicModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<TopicModel>?> loadData({int pageNum = 1}) async {
    TopicListModel model = await DioManager().request<TopicListModel>(
        DioManager.GET, Api.mineFollowTopicListUrl,
        queryParamters: {'page': pageNum});
    return model.list;
  }

  void cancelFollow(TopicModel topicModel) async {
    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.GET, Api.cancelFocusOnTopicUrl,
        queryParamters: {'topic_id': topicModel.topicId!});
    if (model.result!) {
      for (var i = 0; i < list.length; i++) {
        TopicModel item = list[i];
        if (item.topicId == topicModel.topicId) {
          list.remove(item);
          if (list.length == 0 || list.isEmpty) {
            viewState.value = ViewState.empty;
          }
        }
      }
      EasyLoading.showToast('关注已取消',
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast(model.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
