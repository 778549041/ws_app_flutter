import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/models/wow/banner_model.dart';
import 'package:ws_app_flutter/models/wow/moment_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/models/wow/text_banner.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class RecommendController extends RefreshListController {
  var userInfo = UserInfo().obs;
  var bannerModel = BannerModel().obs;
  var textBannerModel = TextBannerListModel().obs;
  var momentListModel = MomentListModel().obs;
  var newsListModel = NewsListModel().obs;
  var activityListModel = RecommendActivityListModel().obs;

  @override
  Future<List> loadData({int pageNum}) async {
    await _requestImageBannerData();
    await _requestTextBannerData();
    await _requestCircleData();
    await _requestRecommendNewsData();
    await _requestRecommendActivityData();
    return list;
  }

  @override
  void onInit() {
    userInfo.value = Get.find<UserController>().userInfo.value;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //banner图数据
  Future _requestImageBannerData() async {
    bannerModel.value = await DioManager().request<BannerModel>(
      DioManager.GET,
      Api.homeImageBannerDataUrl
    );
  }

  //文本banner数据
  Future _requestTextBannerData() async {
    textBannerModel.value = await DioManager().request<TextBannerListModel>(
      DioManager.POST,
      Api.homeTextBannerDataUrl
    );
  }

  //首页推荐圈子
  Future _requestCircleData() async {
    MomentListModel obj = await DioManager().request<MomentListModel>(
      DioManager.POST,
      Api.homeCircleDataUrl
    );
    momentListModel.value = obj;
  }

  //首页推荐资讯
  Future _requestRecommendNewsData() async {
    newsListModel.value = await DioManager().request<NewsListModel>(
      DioManager.GET,
      Api.homeRecommendNewsUrl
    );
  }

  //首页推荐活动
  Future _requestRecommendActivityData() async {
    activityListModel.value = await DioManager().request<RecommendActivityListModel>(
      DioManager.POST,
      Api.homeRecommendActivityUrl
    );
  }
}
