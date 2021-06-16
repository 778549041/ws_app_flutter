import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class CircleTopicListController extends RefreshListController<MomentModel> {
  final String topcId = Get.arguments == null ? null : Get.arguments['topcid'];
  var topicDetailModel = SingleTopicodel().obs;

  @override
  void onInit() {
    pageSize = 10;
    super.onInit();
  }

  @override
  void onReady() async {
    await getTopicDetailData();
    super.onReady();
  }

  @override
  Future<List<MomentModel>> loadData({int pageNum}) async {
    return await requestCircleListData(pageNum);
  }

  Future requestCircleListData(int pageNum) async {
    MomentListModel _model = await DioManager().request<MomentListModel>(
        DioManager.POST, Api.circleMomentListUrl,
        params: {"page": pageNum, 'topic_id': topcId});
    return _model.list;
  }

  Future getTopicDetailData() async {
    topicDetailModel.value = await DioManager().request<SingleTopicodel>(
        DioManager.GET, Api.circleTopicDetailUrl,
        queryParamters: {'cid': topcId});
  }

  void pushToPublish() {
    Get.toNamed(Routes.CIRCLPUBLISH,
        arguments: {'model': topicDetailModel.value.list});
  }
}
