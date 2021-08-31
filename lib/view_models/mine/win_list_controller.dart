import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/win_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class WinListController extends RefreshListController<WinModel> {
  var month = ''.obs;
  var date;

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<WinModel>?> loadData({int pageNum = 1}) async {
    String url = 'm/my-myprize-$pageNum.html';
    if (date != null) {
      url = 'm/my-myprize-$pageNum-$date.html';
    }
    WinListModel model = await DioManager().request<WinListModel>(DioManager.GET, url);
    return model.wins_list;
  }

  //选择出生日期
  void selectDate() {
    Pickers.showDatePicker(
      Get.context!,
      mode: DateMode.YM,
      onConfirm: (res) async {
        if (res.month! < 10) {
          date = '${res.year!}-0${res.month!}';
          month.value = '0${res.month!}';
        } else {
          date = '${res.year!}-${res.month!}';
          month.value = '${res.month!}';
        }
        refresh();
      },
    );
  }
}
