import 'package:flutter/foundation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class ChatController extends RefreshListController<V2TimMessage> with DiagnosticableTreeMixin {
  String lastMsgID;
  String userID;
  var show = true.obs;

  @override
  Future<List<V2TimMessage>> loadData({int pageNum}) async {
    if (pageNum == 1) {
      lastMsgID = null;
    } else {
      V2TimMessage _lastMsg = list.last;
      lastMsgID = _lastMsg.msgID;
    }
    V2TimValueCallback<List<V2TimMessage>> _msgRes = await TencentImSDKPlugin
        .v2TIMManager
        .getMessageManager()
        .getC2CHistoryMessageList(userID: userID, count: pageSize,lastMsgID: lastMsgID);
    return _msgRes.data;
  }

  //发送接收消息添加到list
  addMessageIfNotExits(V2TimMessage message) {
    if (message.userID == userID) {
      list.add(message);
    }
  }

  showkeyborad() {
    show.value = true;
  }

  hidekeyborad() {
    show.value = false;
  }

  setStatus(bool status) {
    show.value = status;
  }
  
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('show', show.value ? 1 : 0));
  }
}
