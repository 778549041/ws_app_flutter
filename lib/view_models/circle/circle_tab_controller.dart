import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_hot_model.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class CircleTabController extends GetxController {
  var hotData = CircleHotModel().obs;
  var topicData = TopicListModel().obs;
  var officialData = MomentListModel().obs;
  var tabsData = <CircleTagModel>[].obs; //tab数据
  CircleTagModel? currentTagModel; //当前tag
  int? currentIndex; //当前tab index

  @override
  void onInit() {
    super.onInit();
    _getHotListData();
    Get.find<UserController>().requestNewMessage();
    _getTopicData();
    _getOfficialData();
    _getCircleTagListData();
  }

  //热门榜数据
  Future _getHotListData() async {
    hotData.value = await DioManager()
        .request<CircleHotModel>(DioManager.GET, Api.circleHotRecommendUrl);
  }

  //精彩话题数据
  Future _getTopicData() async {
    topicData.value = await DioManager().request<TopicListModel>(
        DioManager.POST, Api.circleTopicListUrl,
        params: {'page': 1});
  }

  //官方圈子数据
  Future _getOfficialData() async {
    officialData.value = await DioManager()
        .request<MomentListModel>(DioManager.GET, Api.circleOfficialMomenttUrl);
  }

  //用户圈子标签分类数据
  Future _getCircleTagListData() async {
    CircleTagListModel tagListModel = await DioManager()
        .request<CircleTagListModel>(DioManager.GET, Api.userCircleTagUrl);
    tabsData.clear();
    for (var item in tagListModel.data!) {
      item.canLongPress = true;
      if (item.tag_id! == 1) {
        item.canPan = false;
      } else {
        item.canPan = true;
      }
      if (item.tag_id! < 5) {
        item.canDelete = false;
      } else {
        item.canPan = true;
      }
      tabsData.add(item);
    }
    if (currentTagModel == null) {
      currentIndex = 0;
    } else {
      for (var item in tabsData) {
        if (item.tag_id! == currentTagModel!.tag_id) {
          currentIndex = tabsData.indexOf(item);
        }
      }
    }
  }

  void indexChanged(index) {
    currentTagModel = tabsData[index];
  }
}
