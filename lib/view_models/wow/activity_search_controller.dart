import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class ActivitySearchController extends RefreshListController<ActivityModel> {
  String searchKey = '';

  @override
  void onInit() async {
    super.onInit();
    pageSize = 9;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<List<ActivityModel>?> loadData({int? pageNum}) async {
    ActivityListModel _model = await DioManager().request<ActivityListModel>(
        DioManager.GET,
        'index.php/m/huodong-$pageNum-10-all.html?key=$searchKey');
    return _model.list;
  }

  Future inputSearch(String input) async {
    searchKey = input;
    refresh();
  }
}
