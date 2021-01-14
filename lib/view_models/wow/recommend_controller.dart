import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/models/wow/banner_model.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/models/wow/moment_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/models/wow/text_banner.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class RecommendController extends RefreshListController {
  TimerUtil _timerUtil;
  var userInfo = UserInfo().obs;
  var eletricModel = CarDataModel().obs;
  var bannerModel = BannerModel().obs;
  var textBannerModel = TextBannerListModel().obs;
  var momentListModel = MomentListModel().obs;
  var newsListModel = NewsListModel().obs;
  var activityListModel = RecommendActivityListModel().obs;
  var elePercent = 1.0.obs;
  var colorList = [Color(0xFF2659FF), Color(0xFF01D4D7)].obs;
  var chargeStatus = false.obs;

  @override
  Future<List> loadData({int pageNum}) async {
    await _requestElectricityData();
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
    _timerUtil = TimerUtil(mInterval: 120 * 1000);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //请求电量信息数据
  Future _requestElectricityData() async {
    if (userInfo.value.member.isVehicle == 'true') {
      if (_timerUtil != null) _timerUtil.cancel();
      _timerUtil.setOnTimerTickCallback((millisUntilFinished) {
        DioManager().request<CarDataModel>(
          DioManager.POST,
          Api.vechileEleDataUrl,
          queryParamters: {"member_id":userInfo.value.member.memberId},
          success: (CarDataModel obj) {
            eletricModel.value = obj;
            if (obj.datas.rspBody.chargingStatus == 1 || obj.datas.rspBody.chargingStatus == 2) {
              chargeStatus.value = true;
              colorList.assignAll([Color(0xFF2659FF), Color(0xFF01D4D7)]);
            } else {
              elePercent.value = obj.datas.rspBody.soc/100;
              chargeStatus.value = false;
              if (elePercent.value <= 0.25) {
                colorList.assignAll([Color(0xFFE80016), Color(0xFFE80016)]);
              } else if (elePercent.value <= 0.50) {
                colorList.assignAll([Color(0xFFF2AE2C), Color(0xFFF2AE2C)]);
              } else {
                colorList.assignAll([Color(0xFF1EE623), Color(0xFF1EE623)]);
              }
            }
          },
          error: (e) {
            
          },
        );
      });
      _timerUtil.startTimer();
    }
  }

  //banner图数据
  Future _requestImageBannerData() async {
    DioManager().request<BannerModel>(
      DioManager.GET,
      Api.homeImageBannerDataUrl,
      success: (BannerModel obj) {
        bannerModel.value = obj;
      },
      error: (e) {},
    );
  }

  //文本banner数据
  Future _requestTextBannerData() async {
    DioManager().request<TextBannerListModel>(
      DioManager.POST,
      Api.homeTextBannerDataUrl,
      success: (TextBannerListModel obj) {
        textBannerModel.value = obj;
      },
      error: (e) {},
    );
  }

  //首页推荐圈子
  Future _requestCircleData() async {
    DioManager().request<MomentListModel>(
      DioManager.POST,
      Api.homeCircleDataUrl,
      success: (MomentListModel obj) {
        momentListModel.value = obj;
      },
      error: (e) {},
    );
  }

  //首页推荐资讯
  Future _requestRecommendNewsData() async {
    DioManager().request<NewsListModel>(
      DioManager.GET,
      Api.homeRecommendNewsUrl,
      success: (NewsListModel obj) {
        newsListModel.value = obj;
      },
      error: (e) {},
    );
  }

  //首页推荐活动
  Future _requestRecommendActivityData() async {
    DioManager().request<RecommendActivityListModel>(
      DioManager.POST,
      Api.homeRecommendActivityUrl,
      success: (RecommendActivityListModel obj) {
        activityListModel.value = obj;
      },
      error: (e) {},
    );
  }
}
