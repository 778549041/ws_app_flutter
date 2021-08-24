import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';

class ELWYController extends ListController {
  @override
  Future<List?> loadData() {
    DioManager().request(DioManager.GET, Api.myPackagesListUrl);
    throw UnimplementedError();
  }
}