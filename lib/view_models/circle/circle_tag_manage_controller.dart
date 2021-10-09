import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/circle/circle_tab_controller.dart';

class CircleTagManageController extends GetxController {
  var myTags = <CircleTagModel>[].obs; //我的标签
  var allTags = <CircleTagModel>[].obs; //全部标签
  var isEditing = false.obs; //编辑状态

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

  //排序
  void reorderTags(int oldIndex, int newIndex) {
    if (newIndex == 0) {
      return;
    }
    CircleTagModel model = myTags.removeAt(oldIndex);
    myTags.insert(newIndex, model);
  }

  //删除标签
  void deleteTag(CircleTagModel model) {
    myTags.remove(model);
  }

  //添加新标签
  void addNewTag(CircleTagModel model) {
    bool contains = false;
    for (var item in myTags) {
      if (item.tag_id! == model.tag_id!) {
        contains = true;
        break;
      }
    }
    if (contains) {
      EasyLoading.showToast('请勿重复添加该标签',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    model.canLongPress = true;
    model.canPan = true;
    model.canDelete = true;
    myTags.add(model);
  }

  //编辑、完成
  void editingAction() async {
    if (isEditing.value) {
      //编辑状态，点击表示完成操作，同步数据到服务器
      String tagIds = '';
      for (var i = 0; i < myTags.length; i++) {
        CircleTagModel model = myTags[i];
        if (tagIds == '') {
          tagIds = model.tag_id!.toString();
        } else {
          tagIds = tagIds + ',' + model.tag_id!.toString();
        }
      }
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.saveUsersTagUrl,
          params: {'tagIds': tagIds});
      if (result.result!) {
        Get.find<CircleTabController>().getCircleTagListData();
      } else {
        EasyLoading.showToast(result.message!,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    }
    isEditing.value = !isEditing.value;
  }
}
