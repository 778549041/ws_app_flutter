import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class TopicController extends RefreshListController<TopicModel> {
  List<CircleTagModel> tagList = <CircleTagModel>[];
  int selectedTagId = 1;
  TopicModel? selectedTopic;

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
    _getAllTagList();
  }

  @override
  Future<List<TopicModel>?> loadData({int pageNum = 1}) async {
    TopicListModel _model = await DioManager().request<TopicListModel>(
        DioManager.POST, Api.publishSelectTopicListUrl,
        queryParamters: {"page": pageNum, 'tag_id': selectedTagId});
    return _model.list;
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
    refresh();
  }

  //选择话题
  void selectTopic(TopicModel model) {
    selectedTopic = model;
    for (var i = 0; i < list.length; i++) {
      TopicModel item = list[i];
      if (item.topicId == model.topicId) {
        item.selected = true;
      } else {
        item.selected = false;
      }
      list.remove(item);
      list.insert(i, item);
    }
  }

  //确定
  void confirmAction() {
    Get.back(result: selectedTopic);
  }
}
