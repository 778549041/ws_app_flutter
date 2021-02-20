import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/login/msg_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class MsgCenterController extends BaseController {
  MsgModel msgModel;
  var conversionList = List<V2TimConversation>().obs;

  @override
  void onInit() {
    msgModel = Get.find<UserController>().msgModel.value;
    super.onInit();
  }

  @override
  void onReady() {
    getConversionList();
    super.onReady();
  }

  void pushAction(int msgType) {
    DioManager().request(DioManager.GET, Api.clearUnReadMessageUrl,
        queryParamters: {'type': msgType});
    String _url = msgType == 2
        ? (CacheKey.SERVICE_URL_HOST + HtmlUrls.InteractiveMessagePage)
        : (CacheKey.SERVICE_URL_HOST + HtmlUrls.SystemMessagePage);
    pushH5Page(args: {
      'url': _url,
    });
  }

  //获取会话列表数据
  Future getConversionList() async {
    V2TimValueCallback<V2TimConversationResult> data = await TencentImSDKPlugin
        .v2TIMManager
        .getConversationManager()
        .getConversationList(count: 100, nextSeq: 0);
    conversionList.assignAll(data.data.conversationList);
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
        conversionList
            .removeWhere((element) => element.conversationID == conversitionId);
      } else {
        EasyLoading.showToast('删除失败 ${value.code} ${value.desc}',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }

  //点击某个会话跳转聊天界面
  void clickConversation(V2TimConversation conversition) {
    Get.toNamed(Routes.CHAT,arguments: {'conversition':conversition});
  }
}
