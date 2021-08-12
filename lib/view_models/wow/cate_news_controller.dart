import 'package:ws_app_flutter/models/wow/category_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class CateNewsController extends RefreshListController<NewModel> {
  final CategoryModel model = Get.arguments['model'];

  @override
  void onInit() {
    super.onInit();
    pageSize = 5;
  }

  @override
  Future<List<NewModel>?> loadData({int? pageNum}) async {
    return await _requestRecommendNewsList(pageNum);
  }

  //资讯数据
  Future _requestRecommendNewsList(int? pageNum) async {
    NewsListModel obj = await DioManager().request<NewsListModel>(
        DioManager.POST, Api.newsListDataUrl,
        queryParamters: {"page": pageNum, 'node_id': model.nodeId});
    return obj.list;
  }
}
