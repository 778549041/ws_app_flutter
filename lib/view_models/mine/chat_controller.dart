import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class ChatController extends RefreshListController<V2TimMessage> {
  String lastMsgID;
  final String userID = Get.arguments['userId'];//用户聊天信息
  final String showName = Get.arguments['showName'];
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
        .getC2CHistoryMessageList(
            userID: userID, count: pageSize, lastMsgID: lastMsgID);
    bool hasNoRead = _msgRes.data.any((element) {
      return !element.isSelf && !element.isRead;
    });
    if (hasNoRead) {
      TencentImSDKPlugin.v2TIMManager
          .getMessageManager()
          .markC2CMessageAsRead(userID: userID)
          .then((res) {
        if (res.code == 0) {
        } else {
        }
      });
    }
    return _msgRes.data;
  }

  //更新未读状态
  updateC2CMessageByUserId(String userid) {
    if (userID == userid) {
      list.forEach((element) {
        element.isPeerRead = true;
      });
      update();
    }
  }

  //发送接收消息添加到list
  addMessageIfNotExits(V2TimMessage message) {
    if (message.userID == userID) {
      list.add(message);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        update();
      });
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
}
