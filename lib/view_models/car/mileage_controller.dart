import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/car/mileage_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:ws_app_flutter/widgets/car/mileage_alert.dart';

class MileageController extends RefreshListController<MileageModel> {
  var totalMileage = ''.obs;
  var hasAccept = false.obs;

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<MileageModel>?> loadData({int pageNum = 1}) async {
    MileageListModel model = await DioManager().request<MileageListModel>(
        DioManager.GET, Api.mileageListUrl,
        queryParamters: {'page': pageNum});
    totalMileage.value = model.totalMileage!;
    hasAccept.value = (model.receive == null ? true : false);
    return model.list;
  }

  void buttonAction(int index) async {
    if (index == 0) {
      //导航栏右侧按钮
      Get.dialog(
        MileageAlert(),
        barrierDismissible: false,
      );
    } else if (index == 1) {
      //领取积分
      CommonModel model = await DioManager()
          .request<CommonModel>(DioManager.GET, Api.acceptPointsUrl);
      if (model.score != null && model.score! > 0) {
        EasyLoading.showSuccess('积分领取成功');
      }
    }
  }
}
