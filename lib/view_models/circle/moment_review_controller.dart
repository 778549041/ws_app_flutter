import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class MomentReviewController extends RefreshListController<MomentModel> {
  final String topicid;

  MomentReviewController(this.topicid);

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<MomentModel>?> loadData({int pageNum = 1}) async {
    MomentListModel model = await DioManager().request<MomentListModel>(
        DioManager.GET, Api.momentReviewListUrl,
        queryParamters: {'page': pageNum, 'topic_id': topicid});
    return model.list;
  }

  void reviewAction(int examine, MomentModel model) async {
    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.GET, Api.reviewMomentUrl, queryParamters: {
      'topic_id': model.topicId!,
      'info_id': model.circleId!,
      'examine': examine
    });
    if (result.result! && result.code == 200) {
      refresh();
    }
    EasyLoading.showToast(result.message!,
        toastPosition: EasyLoadingToastPosition.bottom);
  }
}
