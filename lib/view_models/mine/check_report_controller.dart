import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CheckReportController extends RefreshListController {
  @override
  Future<List?> loadData({int pageNum = 1}) {
    DioManager().request(DioManager.GET, Api.reportListUrl);
    throw UnimplementedError();
  }
}