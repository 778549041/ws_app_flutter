import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class ActivityController extends RefreshListController {
  var condition = 'all'.obs;

  @override
  Future<List> loadData({int pageNum}) async {
    ActivityListModel _model = await DioManager().request<ActivityListModel>(
        DioManager.GET,
        'index.php/m/huodong-$pageNum-10-${condition.value}.html?key=');
    return _model.list;
  }
}
