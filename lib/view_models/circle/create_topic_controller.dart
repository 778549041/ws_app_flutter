import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class CreateTopicController extends GetxController {
  int selectedTagId = 1;
  List<CircleTagModel> tagList = <CircleTagModel>[];

  @override
  void onInit() {
    super.onInit();
    _getAllTagList();
  }

  Future _getAllTagList() async {
    CircleTagListModel tagListModel = await DioManager()
        .request<CircleTagListModel>(DioManager.GET, Api.allCircleTagListUrl);
    for (var item in tagListModel.data!) {
      if (item.tag_id! == selectedTagId) {
        item.selected = true;
      } else {
        item.selected = false;
      }
      tagList.add(item);
    }
    update(['tagList']);
  }

  //选择标签
  void selectTag(CircleTagModel model) {
    selectedTagId = model.tag_id!;
    for (var item in tagList) {
      if (item.tag_id! == selectedTagId) {
        item.selected = true;
      } else {
        item.selected = false;
      }
    }
    update(['tagList']);
  }
}