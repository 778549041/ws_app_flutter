import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/login/msg_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class MsgCenterController extends BaseController {
  var msgModel = MsgModel().obs;

  @override
  void onInit() {
    Get.lazyPut<ConversationController>(() => ConversationController());
    msgModel.value = Get.find<UserController>().msgModel.value;
    super.onInit();
  }

  void pushAction(int msgType) async {
    if (msgType == 1) {
      //系统消息
      Get.toNamed(Routes.SYSTEMMSGPAGE);
    } else if (msgType == 2) {
      //互动消息
      Get.toNamed(Routes.INTERAMSGPAGE);
    }
    await DioManager().request(DioManager.GET, Api.clearUnReadMessageUrl,
        queryParamters: {'type': msgType});
    await Get.find<UserController>().requestNewMessage();
    msgModel.value = Get.find<UserController>().msgModel.value;
  }
}
