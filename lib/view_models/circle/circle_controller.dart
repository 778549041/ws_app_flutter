import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_controller.dart';

class CircleController extends RefreshListController<MomentModel> {
  @override
  void onInit() {
    Get.lazyPut<CircleTopicController>(() => CircleTopicController());
    pageSize = 10;
    super.onInit();
  }

  @override
  Future<List<MomentModel>> loadData({int pageNum}) async {
    return await requestCircleListData(pageNum);
  }

  Future requestCircleListData(int pageNum) async {
    MomentListModel _model = await DioManager().request<MomentListModel>(
        DioManager.POST, Api.circleMomentListUrl,
        params: {"page": pageNum});
    return _model.list;
  }

  //按钮事件
  void buttonAction(int index) {
    if (index == 1000) {
      //圈子搜索
      Get.toNamed(Routes.CIRCLESEARCH);
    } else if (index == 1001) {
      //添加好友
      Get.toNamed(Routes.ADDFRIEND);
    } else if (index == 1002) {
      Get.toNamed(Routes.CIRCLPUBLISH);
    }
  }
}
