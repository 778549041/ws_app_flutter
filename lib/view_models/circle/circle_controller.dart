import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_controller.dart';

class CircleController extends RefreshListController {
  @override
  void onInit() {
    Get.lazyPut<CircleTopicController>(() => CircleTopicController());
    pageSize = 10;
    super.onInit();
  }

  @override
  Future<List> loadData({int pageNum}) async {
    return await requestCircleListData(pageNum);
  }

  Future requestCircleListData(int pageNum) async {
    MomentListModel _model = await DioManager().request<MomentListModel>(
        DioManager.POST, Api.circleMomentListUrl,
        params: {"page": pageNum});
    return _model.list;
  }
}
