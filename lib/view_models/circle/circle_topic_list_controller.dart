import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class CircleTopicListController extends RefreshListController<MomentModel> {
  final String topcId = Get.arguments['topcid'];
  SingleTopicodel? topicDetailModel;

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<MomentModel>?> loadData({int pageNum = 1}) async {
    if (pageNum == 1) {
      getTopicDetailData();
    }
    return await requestCircleListData(pageNum);
  }

  Future requestCircleListData(int pageNum) async {
    MomentListModel _model = await DioManager().request<MomentListModel>(
        DioManager.POST, Api.newVersionMomentListUrl,
        params: {"page": pageNum, 'topic_id': topcId, 'tag_id': '1'});
    return _model.list;
  }

  Future getTopicDetailData() async {
    topicDetailModel = await DioManager().request<SingleTopicodel>(
        DioManager.GET, Api.circleTopicDetailUrl,
        queryParamters: {'t_id': topcId});
    update(['topicHeader']);
  }

  void pushToPublish() {
    Get.toNamed(Routes.CIRCLPUBLISH,
        arguments: {'model': topicDetailModel!.list});
  }

  //申请加入话题
  void applyJoinTopic() async {
    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.GET, Api.applyJoinTopicUrl,
        queryParamters: {'topic_id': topicDetailModel!.list!.topicId!});
    if (model.result!) {
      topicDetailModel!.list!.isJoin = 1;
      update(['topicHeader']);
      EasyLoading.showToast('申请成功，等待管理员审核',
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast(model.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //权限设置
  void changePermission(int index) {}

  //关注、取消关注
  void followAction() async {
    if (topicDetailModel!.list!.is_follow!) {
      //取消关注
      CommonModel model = await DioManager().request<CommonModel>(
          DioManager.GET, Api.cancelFocusOnTopicUrl,
          queryParamters: {'topic_id': topicDetailModel!.list!.topicId!});
      if (model.result!) {
        topicDetailModel!.list!.is_follow = false;
        update(['topicHeader']);
        EasyLoading.showToast('关注已取消',
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        EasyLoading.showToast(model.message!,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      //关注
      CommonModel model = await DioManager().request<CommonModel>(
          DioManager.GET, Api.focusOnTopicUrl,
          queryParamters: {'topic_id': topicDetailModel!.list!.topicId!});
      if (model.result!) {
        topicDetailModel!.list!.is_follow = true;
        update(['topicHeader']);
        EasyLoading.showToast('关注成功',
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        EasyLoading.showToast(model.message!,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    }
  }
}
