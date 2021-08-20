import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/wow/activity_controller.dart';
import 'package:ws_app_flutter/view_models/wow/news_controller.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';

class WowController extends BaseController {
  @override
  void onInit() {
    Get.lazyPut<RecommendController>(() => RecommendController());
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<ActivityController>(() => ActivityController());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void tabClick(int index) {

  }
}