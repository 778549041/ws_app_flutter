import 'package:get/get.dart';
import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/circle/circle_hot_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';

class CircleHotMoreListController extends ListController<CircleHotData> {
  @override
  Future<List<CircleHotData>?> loadData() async {
    CircleHotModel model = await DioManager()
        .request<CircleHotModel>(DioManager.GET, Api.circleHotListUrl);
    return model.data;
  }

  void pushAction(CircleHotData data) {
    if (data.type == 1) {
      String _url = '';
      if (data.is_custom!) {
        _url = data.url!;
      } else {
        _url = Env.envConfig.serviceUrl +
            HtmlUrls.ActivityDetailsPage +
            '?is_online=${data.is_online!}&is_vote=${data.is_vote!}&activity_id=${data.huodong_id!}';
      }
      Get.toNamed(Routes.WEBVIEW, arguments: {'url': _url, 'hasNav': true});
    } else if (data.type == 2) {
      Get.toNamed(Routes.NEWSDETAIL,
          arguments: {'article_id': data.article_id!});
    } else if (data.type == 3) {
      Get.toNamed(Routes.CIRCLTOPICLIST, arguments: {'topcid': data.topic_id!});
    }
  }
}
