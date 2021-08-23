import 'package:flustars/flustars.dart';
import 'package:ws_app_flutter/models/mine/system_msg_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class SystemMsgController extends RefreshListController<SystemMsg> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<SystemMsg>?> loadData({int pageNum = 1}) async {
    SystemMsgModel model = await DioManager().request<SystemMsgModel>(DioManager.GET, 'm/my-message-0-$pageNum.html');
    return model.msgList;
  }
}