import 'package:flutter/material.dart';
import 'package:ws_app_flutter/models/circle/friend_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';
import 'package:get/get.dart';

class AddFriendsController extends ListController<FriendMember> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;
  String? searchKey;
  var isActive = false.obs; //是否搜索状态，如果是搜索则根据搜索结果展示列表，否则根据推荐结果展示
  var showListData = <FriendMember?>[].obs; //最终要展示的数据结果

  @override
  void onInit() {
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<List<FriendMember>?> loadData() async {
    AddFriendListModel model = await DioManager().request<AddFriendListModel>(
        DioManager.GET, Api.circleAddFriendRecommendListUrl);
    showListData.assignAll(model.list!);
    return model.list;
  }

  //搜索结果数据
  Future doSearch() async {
    if (searchKey?.length == 0 || searchKey == null) {
      isActive.value = false;
      showListData.assignAll(list);
      return;
    }
    isActive.value = true;
    Get.focusScope?.unfocus();
    AddFriendListModel model = await DioManager().request<AddFriendListModel>(
        DioManager.POST, Api.circleAddFriendSearchUrl,
        params: {'nickname': searchKey});
    showListData.assignAll(model.list!);
  }

  //添加好友操作
  void addFriend(FriendMember model) {
    Get.focusScope?.unfocus();
    Get.toNamed(Routes.USERPROFILE, arguments: {'user_id': model.memberId});
  }
}
