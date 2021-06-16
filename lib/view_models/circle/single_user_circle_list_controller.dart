import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class SingleUserCircleController extends RefreshListController<MomentModel> {
  final String memberId =
      Get.arguments == null ? null : Get.arguments['memberId']; //用户id

  @override
  Future<List<MomentModel>> loadData({int pageNum}) async {
    return await requestCircleListData(pageNum);
  }

  @override
  void onInit() {
    pageSize = 10;
    super.onInit();
  }

  Future requestCircleListData(int pageNum) async {
    MomentListModel _model = await DioManager().request<MomentListModel>(
        DioManager.POST, Api.circleMomentListUrl,
        params: {"page": pageNum, 'member_id': memberId});
    return _model.list;
  }
}
