import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class ConversationController extends ListController<V2TimConversation> {
  @override
  void onReady() {
    super.onReady();
  }

  //获取会话列表数据
  @override
  Future<List<V2TimConversation>> loadData() async {
    V2TimValueCallback<V2TimConversationResult> data = await TencentImSDKPlugin
        .v2TIMManager
        .getConversationManager()
        .getConversationList(count: 100, nextSeq: 0);
    return data.data.conversationList;
  }

  //删除某个会话
  Future deleteSingleConversition(String conversitionId) async {
    TencentImSDKPlugin.v2TIMManager
        .getConversationManager()
        .deleteConversation(
          conversationID: conversitionId,
        )
        .then((value) {
      if (value.code == 0) {
        EasyLoading.showToast('删除成功',
            toastPosition: EasyLoadingToastPosition.bottom);
        list.removeWhere((element) => element.conversationID == conversitionId);
      } else {
        EasyLoading.showToast('删除失败 ${value.code} ${value.desc}',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }

  //点击某个会话跳转聊天界面
  void clickConversation(V2TimConversation conversition) {
    Get.toNamed(Routes.CHAT, arguments: {
      'userId': conversition.userID,
      'showName': conversition.showName,
    });
  }
}
