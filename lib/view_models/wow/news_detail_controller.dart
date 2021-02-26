import 'package:ws_app_flutter/models/wow/news_comment_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class NewsDetailController extends RefreshListController<NewsCommentModel> {
  var articleId = ''.obs;
  var newsDetailModel = NewsDetailModel().obs;

  @override
  void onInit() {
    pageSize = 10;
    super.onInit();
  }

  @override
  void onReady() async {
    await getNewsDetailData();
    super.onReady();
  }

  @override
  Future<List<NewsCommentModel>> loadData({int pageNum}) async {
    NewsCommentListModel _model = await DioManager()
        .request<NewsCommentListModel>(
            DioManager.GET, Api.newsDetailCommentListUrl,
            queryParamters: {'cmt_page': pageNum, 'art_id': articleId.value});
    return _model.cmtList;
  }

  //资讯详情数据
  Future getNewsDetailData() async {
    newsDetailModel.value = await DioManager().request<NewsDetailModel>(
        DioManager.GET, Api.newsDetailUrl,
        queryParamters: {'art_id': articleId.value});
  }
}
