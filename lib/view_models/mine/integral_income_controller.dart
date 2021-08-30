import 'package:flustars/flustars.dart';
import 'package:ws_app_flutter/models/mine/integral_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class IntegralIncomeController extends RefreshListController<Integral> {
  var selectDate =
      DateUtil.formatDate(DateTime.now(), format: DateFormats.y_mo);

  @override
  void onInit() {
    super.onInit();
    pageSize = 20;
  }

  @override
  Future<List<Integral>?> loadData({int pageNum = 1}) async {
    IntegralModel model = await DioManager().request<IntegralModel>(
        DioManager.POST, 'm/my-integral-$pageNum-income-$selectDate.html');
    late Map<String, dynamic> mapObj;
    if (model.integral_list != null) {
      String mapKey = selectDate.split('-')[0] + '.' + selectDate.split('-')[1];
      mapObj = model.integral_list![mapKey];
      IntegralList integralList = IntegralList.fromJson(mapObj);
      return integralList.list;
    } else {
      return null;
    }
  }
}
