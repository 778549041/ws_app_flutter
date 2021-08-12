import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/friend_circle_img_model.dart';
import 'package:ws_app_flutter/models/circle/friend_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/im_info_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class ProfileController extends GetxController {
  final String userId = Get.arguments['user_id'];
  var friendModel = FriendModel().obs;
  var friendCircleImgModel = FriendCircleImgListModel().obs;
  IMInfoModel? imInfoModel;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getFriendData();
    getFriendIMInfo();
    getFriendCircleData();
    super.onReady();
  }

  //获取好友信息
  Future getFriendData() async {
    friendModel.value = await DioManager().request<FriendModel>(
        DioManager.GET, 'm/friends-item-${userId}.html');
  }

  //获取好友圈子图集信息
  Future getFriendCircleData() async {
    friendCircleImgModel.value = await DioManager()
        .request<FriendCircleImgListModel>(
            DioManager.POST, Api.circleFriendsMomentUrl,
            params: {'member_id': userId});
  }

  //获取好友IM信息
  Future getFriendIMInfo() async {
    imInfoModel = await DioManager().request<IMInfoModel>(
        DioManager.GET, 'm/friends-getImUserSig-${userId}.html');
  }

  //按钮事件
  void buttonAction(int index) async {
    if (index == 1000) {
      //跳转个人圈子列表
      Get.toNamed(Routes.SINGLECIRCLELIST,
          arguments: {'memberId': userId});
    } else if (index == 1001) {
      //删除好友
      Get.dialog(
          BaseDialog(
            title: '删除联系人',
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('确认删除？', style: TextStyle(fontSize: 16.0)),
            ),
            onConfirm: () async {
              CommonModel result = await DioManager().request<CommonModel>(
                  DioManager.GET, 'm/friends-delFriend-${userId}.html');
              if (result.success != null) {
                EasyLoading.showToast(result.success!,
                    toastPosition: EasyLoadingToastPosition.bottom);
                Future.delayed(Duration(seconds: 2)).then((value) {
                  Get.back();
                });
              } else {
                EasyLoading.showToast(result.error!,
                    toastPosition: EasyLoadingToastPosition.bottom);
              }
            },
          ),
          barrierDismissible: false);
    } else if (index == 1002) {
      //添加好友、发消息
      if (friendModel.value.member!.isFriend!) {
        Get.find<UserController>().requestIMInfoAndLogin().then((value) {
          Get.toNamed(Routes.CHAT, arguments: {
            'userId': imInfoModel!.data!.user,
            'showName': friendModel.value.member!.name
          });
        });
      } else {
        CommonModel result = await DioManager().request<CommonModel>(
            DioManager.POST, Api.circleAddFriendUrl,
            params: {'member_id': userId});
        if (result.success != null) {
          EasyLoading.showToast('已向该好友发送邀请，等待对方确认',
              toastPosition: EasyLoadingToastPosition.bottom);
        } else {
          EasyLoading.showToast(result.error!,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
    }
  }
}
