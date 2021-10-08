import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class CircleTagManageController extends GetxController {
  var myTags = <CircleTagModel>[].obs;//我的标签
  var allTags = <CircleTagModel>[].obs;//全部标签

  @override
  void onInit() {
    super.onInit();
    _getCircleTagListData();
    _getAllCircleTagListData();
  }

  //用户圈子标签分类数据
  Future _getCircleTagListData() async {
    CircleTagListModel tagListModel = await DioManager()
        .request<CircleTagListModel>(DioManager.GET, Api.userCircleTagUrl);
    myTags.clear();
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
        item.canDelete = true;
      }
      myTags.add(item);
    }
  }

  //全部圈子标签分类数据
  Future _getAllCircleTagListData() async {
    CircleTagListModel tagListModel = await DioManager()
        .request<CircleTagListModel>(DioManager.GET, Api.circleTagListUrl);
    allTags.clear();
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
        item.canDelete = true;
      }
      allTags.add(item);
    }
  }
}