import 'package:ws_app_flutter/models/wow/category_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class NewsController extends RefreshListController<NewModel> {
  var categoryListModel = CategoryListModel().obs;

  @override
  void onInit() {
    pageSize = 5;
    super.onInit();
  }

  @override
  Future<List<NewModel>?> loadData({int? pageNum}) async {
    if (pageNum == 1) {
      await _requestCategoryData();
    }
    return await _requestRecommendNewsList(pageNum);
  }

  //分类数据
  Future _requestCategoryData() async {
    categoryListModel.value = await DioManager()
        .request<CategoryListModel>(DioManager.GET, Api.newsCategoryUrl);
  }

  //热门资讯数据
  Future _requestRecommendNewsList(int? pageNum) async {
    NewsListModel obj = await DioManager().request<NewsListModel>(
        DioManager.POST, Api.newsHotListUrl,
        queryParamters: {"page": pageNum});
    return obj.list;
  }

  //资讯分类点击
  void clickCategory(CategoryModel model) {
    Get.toNamed(Routes.CATENEWSLIST, arguments: {'model': model});
  }

  //资讯搜索
  void clickSearch() {
    Get.toNamed(Routes.NEWSSEARCH);
  }
}
