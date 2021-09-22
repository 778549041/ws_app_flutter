import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class MineCircleController extends RefreshListController<MomentModel> {
  @override
  Future<List<MomentModel>?> loadData({int pageNum = 1}) async {
    return await requestCircleListData(pageNum);
  }

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  Future requestCircleListData(int pageNum) async {
    MomentListModel _model = await DioManager().request<MomentListModel>(
        DioManager.POST, Api.circleMomentListUrl,
        params: {
          "page": pageNum,
          'member_id':
              Get.find<UserController>().userInfo.value.member?.memberId
        });
    return _model.list;
  }
}
