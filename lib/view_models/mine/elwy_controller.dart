import 'package:ws_app_flutter/models/mine/pac_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class ELWYController extends RefreshListController<PackageModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<PackageModel>?> loadData({int pageNum = 1}) async {
    PackageListModel model = await DioManager()
        .request<PackageListModel>(DioManager.GET, Api.myPackagesListUrl);
    return model.list;
  }
}
