import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class ViolationListController extends ListController {
  final String brandCode = Get.arguments['brandCode'];
  final String engineNumber = Get.arguments['engineNumber'];
  final String vin = Get.arguments['vin'];

  @override
  Future<List?> loadData() async {
    DioManager().request(DioManager.POST, Api.violationQueryUrl, params: {
      'hphm': brandCode,
      'hpzl': '小型车',
      'engineno': engineNumber,
      'classno': vin
    });
  }
}