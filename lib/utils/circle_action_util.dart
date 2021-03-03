import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/circle/circle_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_list_controller.dart';
import 'package:ws_app_flutter/view_models/circle/single_user_circle_list_controller.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';

class CircleActionUtil {
  //点击勋章
  void clickMedal() {
    //TODO
  }

  //列表添加好友操作
  Future addFriend(MomentModel model) async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circleAddFriendUrl,
        params: {'member_id': model.memberId});
    if (res.success != null) {
      EasyLoading.showToast('已向该好友发送邀请，等待对方确认',
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast(res.error,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //列表删除某条动态并同步更新数据到其他列表界面
  Future deleteMoment(MomentModel model) async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circleDeleteMomentUrl,
        params: {'cid': model.circleId});
    if (res.list == 'true') {
      //本地同步数据状态到其他圈子列表页面
      //wow推荐圈子
      for (var i = 0;
          i < Get.find<RecommendController>().momentListModel.value.list.length;
          i++) {
        MomentModel momentModel =
            Get.find<RecommendController>().momentListModel.value.list[i];
        if (momentModel.circleId == model.circleId) {
          Get.find<RecommendController>()
              .momentListModel
              .value
              .list
              .remove(momentModel);
        }
      }
      //圈子列表
      for (var i = 0; i < Get.find<CircleController>().list.length; i++) {
        MomentModel momentModel = Get.find<CircleController>().list[i];
        if (momentModel.circleId == model.circleId) {
          Get.find<CircleController>().list.remove(momentModel);
        }
      }
      //话题圈子列表
      if (Get.isRegistered<CircleTopicListController>()) {
        for (var i = 0;
            i < Get.find<CircleTopicListController>().list.length;
            i++) {
          MomentModel momentModel =
              Get.find<CircleTopicListController>().list[i];
          if (momentModel.circleId == model.circleId) {
            Get.find<CircleTopicListController>().list.remove(momentModel);
          }
        }
      }
      //个人圈子列表
      if (Get.isRegistered<SingleUserCircleController>()) {
        for (var i = 0;
            i < Get.find<SingleUserCircleController>().list.length;
            i++) {
          MomentModel momentModel =
              Get.find<SingleUserCircleController>().list[i];
          if (momentModel.circleId == model.circleId) {
            Get.find<SingleUserCircleController>().list.remove(momentModel);
          }
        }
      }
    } else {
      EasyLoading.showToast(res.error,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //列表点赞按钮操作，并同步更新点赞状态到其他界面
  Future<bool> clickLikeButton(bool isLiked, MomentModel model) async {
    if (isLiked) {
      //已点赞，再次点击取消点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.circleMomentUnPraiseUrl,
          params: {'cid': model.circleId});
      if (result.res) {
        //本地同步数据状态到其他圈子列表页面
        //wow推荐圈子
        for (var i = 0;
            i <
                Get.find<RecommendController>()
                    .momentListModel
                    .value
                    .list
                    .length;
            i++) {
          MomentModel momentModel =
              Get.find<RecommendController>().momentListModel.value.list[i];
          if (momentModel.circleId == model.circleId) {
            Get.find<RecommendController>()
                .momentListModel
                .value
                .list
                .remove(momentModel);
            momentModel.praiseStatus = false;
            momentModel.praise = (int.parse(momentModel.praise) - 1).toString();
            Get.find<RecommendController>()
                .momentListModel
                .value
                .list
                .insert(i, momentModel);
          }
        }
        //圈子列表
        for (var i = 0; i < Get.find<CircleController>().list.length; i++) {
          MomentModel momentModel = Get.find<CircleController>().list[i];
          if (momentModel.circleId == model.circleId) {
            Get.find<CircleController>().list.remove(momentModel);
            momentModel.praiseStatus = false;
            momentModel.praise = (int.parse(momentModel.praise) - 1).toString();
            Get.find<CircleController>().list.insert(i, momentModel);
          }
        }
        //话题圈子列表
        if (Get.isRegistered<CircleTopicListController>()) {
          for (var i = 0;
              i < Get.find<CircleTopicListController>().list.length;
              i++) {
            MomentModel momentModel =
                Get.find<CircleTopicListController>().list[i];
            if (momentModel.circleId == model.circleId) {
              Get.find<CircleTopicListController>().list.remove(momentModel);
              momentModel.praiseStatus = false;
              momentModel.praise =
                  (int.parse(momentModel.praise) - 1).toString();
              Get.find<CircleTopicListController>().list.insert(i, momentModel);
            }
          }
        }
        //个人圈子列表
        if (Get.isRegistered<SingleUserCircleController>()) {
          for (var i = 0;
              i < Get.find<SingleUserCircleController>().list.length;
              i++) {
            MomentModel momentModel =
                Get.find<SingleUserCircleController>().list[i];
            if (momentModel.circleId == model.circleId) {
              Get.find<SingleUserCircleController>().list.remove(momentModel);
              momentModel.praiseStatus = false;
              momentModel.praise =
                  (int.parse(momentModel.praise) - 1).toString();
              Get.find<SingleUserCircleController>()
                  .list
                  .insert(i, momentModel);
            }
          }
        }
        return !isLiked;
      } else {
        EasyLoading.showToast(result.error,
            toastPosition: EasyLoadingToastPosition.bottom);
        return true;
      }
    } else {
      //未点赞，点击点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.circleMomentPraiseUrl,
          params: {'cid': model.circleId});
      if (result.res) {
        //本地同步数据状态到其他圈子列表页面
        //wow推荐圈子
        for (var i = 0;
            i <
                Get.find<RecommendController>()
                    .momentListModel
                    .value
                    .list
                    .length;
            i++) {
          MomentModel momentModel =
              Get.find<RecommendController>().momentListModel.value.list[i];
          if (momentModel.circleId == model.circleId) {
            Get.find<RecommendController>()
                .momentListModel
                .value
                .list
                .remove(momentModel);
            momentModel.praiseStatus = true;
            momentModel.praise = (int.parse(momentModel.praise) + 1).toString();
            Get.find<RecommendController>()
                .momentListModel
                .value
                .list
                .insert(i, momentModel);
          }
        }
        //圈子列表
        for (var i = 0; i < Get.find<CircleController>().list.length; i++) {
          MomentModel momentModel = Get.find<CircleController>().list[i];
          if (momentModel.circleId == model.circleId) {
            Get.find<CircleController>().list.remove(momentModel);
            momentModel.praiseStatus = true;
            momentModel.praise = (int.parse(momentModel.praise) + 1).toString();
            Get.find<CircleController>().list.insert(i, momentModel);
          }
        }
        //话题圈子列表
        if (Get.isRegistered<CircleTopicListController>()) {
          for (var i = 0;
              i < Get.find<CircleTopicListController>().list.length;
              i++) {
            MomentModel momentModel =
                Get.find<CircleTopicListController>().list[i];
            if (momentModel.circleId == model.circleId) {
              Get.find<CircleTopicListController>().list.remove(momentModel);
              momentModel.praiseStatus = true;
              momentModel.praise =
                  (int.parse(momentModel.praise) + 1).toString();
              Get.find<CircleTopicListController>().list.insert(i, momentModel);
            }
          }
        }
        //个人圈子列表
        if (Get.isRegistered<SingleUserCircleController>()) {
          for (var i = 0;
              i < Get.find<SingleUserCircleController>().list.length;
              i++) {
            MomentModel momentModel =
                Get.find<SingleUserCircleController>().list[i];
            if (momentModel.circleId == model.circleId) {
              Get.find<SingleUserCircleController>().list.remove(momentModel);
              momentModel.praiseStatus = true;
              momentModel.praise =
                  (int.parse(momentModel.praise) + 1).toString();
              Get.find<SingleUserCircleController>()
                  .list
                  .insert(i, momentModel);
            }
          }
        }
        return !isLiked;
      } else {
        EasyLoading.showToast(result.error,
            toastPosition: EasyLoadingToastPosition.bottom);
        return false;
      }
    }
  }
}
