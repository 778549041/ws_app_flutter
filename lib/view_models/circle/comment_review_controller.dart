import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/models/circle/review_comment_list_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CommentReviewController
    extends RefreshListController<ReviewCommentModel> {
  final String topicid;

  CommentReviewController(this.topicid);

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<ReviewCommentModel>?> loadData({int pageNum = 1}) async {
    ReviewCommentListModel model = await DioManager()
        .request<ReviewCommentListModel>(
            DioManager.GET, Api.commentReviewListUrl,
            queryParamters: {'page': pageNum, 'topic_id': topicid});
    return model.data;
  }

  //评论审核
  void reviewAction(int examine, ReviewCommentModel model) async {
    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.GET, Api.reviewCommentUrl, queryParamters: {
      'topic_id': model.circleInfo!.topicId!,
      'info_id': model.id!,
      'examine': examine
    });
    if (result.result! && result.code == 200) {
      refresh();
    }
    EasyLoading.showToast(result.message!,
        toastPosition: EasyLoadingToastPosition.bottom);
  }
}
