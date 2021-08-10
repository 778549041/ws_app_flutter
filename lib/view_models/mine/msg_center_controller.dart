import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/login/msg_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class MsgCenterController extends BaseController {
  MsgModel? msgModel;

  @override
  void onInit() {
    Get.lazyPut<ConversationController>(() => ConversationController());
    msgModel = Get.find<UserController>().msgModel.value;
    super.onInit();
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
}
