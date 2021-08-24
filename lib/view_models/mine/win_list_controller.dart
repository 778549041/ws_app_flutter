import 'package:get/get.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class WinListController extends RefreshListController {
  var month = ''.obs;

  @override
  Future<List?> loadData({int pageNum = 1}) {
    DioManager().request(DioManager.GET, 'm/my-myprize-$pageNum.html');
    throw UnimplementedError();
  }
}