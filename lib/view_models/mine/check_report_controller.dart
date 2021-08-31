import 'package:ws_app_flutter/models/mine/report_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CheckReportController extends RefreshListController<ReportModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<ReportModel>?> loadData({int pageNum = 1}) async {
    ReportListModel model = await DioManager().request<ReportListModel>(
        DioManager.GET, Api.reportListUrl,
        queryParamters: {'page': pageNum});
    return model.data;
  }
}
