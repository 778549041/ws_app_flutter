import 'package:get/get.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class CircleTabController extends RefreshListController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<List?> loadData({int pageNum = 1}) async {
    await _getHotListData();
    await _getTopicData(pageNum);
    await _getOfficialData();
    await _getCircleTagListData();
    return list;
  }

  //热门榜数据
  Future _getHotListData() async {
    DioManager().request(DioManager.GET, Api.circleHotRecommendUrl);
  }

  //精彩话题数据
  Future _getTopicData(int pageNum) async {
    DioManager().request(DioManager.POST, Api.circleTopicListUrl,
        params: {'page': pageNum});
  }

  //官方圈子数据
  Future _getOfficialData() async {
    DioManager().request(DioManager.GET, Api.circleOfficialMomenttUrl);
  }

  //用户圈子标签分类数据
  Future _getCircleTagListData() async {
    DioManager().request(DioManager.GET, Api.userCircleTagUrl);
  }
}
