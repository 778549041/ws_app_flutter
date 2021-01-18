import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CircleController extends RefreshListController {
  @override
  Future<List> loadData({int pageNum}) {
    throw UnimplementedError();
  }
}