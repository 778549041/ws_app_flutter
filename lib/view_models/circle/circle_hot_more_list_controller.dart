import 'package:ws_app_flutter/models/circle/circle_hot_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';

class CircleHotMoreListController extends ListController<CircleHotData> {
  @override
  Future<List<CircleHotData>?> loadData() async {
    CircleHotModel model = await DioManager()
        .request<CircleHotModel>(DioManager.GET, Api.circleHotListUrl);
    return model.data;
  }
}
