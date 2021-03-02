import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CircleTopicListController extends RefreshListController<MomentModel> {
  @override
  Future<List<MomentModel>> loadData({int pageNum}) {
    // TODO: implement loadData
    throw UnimplementedError();
  }
}