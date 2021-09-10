import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/report_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class CheckReportDetailController extends GetxController {
  final String id = Get.arguments['id'];
  var model = ReportDetailModel().obs;

  @override
  void onInit() async {
    super.onInit();
    model.value = await DioManager().request<ReportDetailModel>(
        DioManager.GET, Api.reportDetailUrl,
        queryParamters: {'id': id});
    print('1111');
  }
}
