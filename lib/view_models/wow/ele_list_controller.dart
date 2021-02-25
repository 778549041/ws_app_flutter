import 'package:ws_app_flutter/models/wow/charge_pile_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';
import 'package:get/get.dart';

class EleListController extends ListController<ChargePileInfo> {
  var stationID = ''.obs;
  var serviceType = ''.obs;

  @override
  Future<List<ChargePileInfo>> loadData() async {
    ChargePileListModel _model = await DioManager().request<ChargePileListModel>(
        DioManager.GET, Api.mapAllCDZhanListUrl, queryParamters: {
      'StationID': stationID.value,
      'ServiceType': serviceType.value
    });
    return _model.list;
  }
}
