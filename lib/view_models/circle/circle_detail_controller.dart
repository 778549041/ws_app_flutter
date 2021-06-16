import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/circle/moment_comment_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/circle_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_list_controller.dart';
import 'package:ws_app_flutter/view_models/circle/single_user_circle_list_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
import 'package:ws_app_flutter/widgets/wow/share_menu.dart';

class CircleDetailController extends RefreshListController<MomentCommentModel> {
  final String circleId =
      Get.arguments == null ? null : Get.arguments['circle_id']; //圈子id
  final String commentId = Get.arguments == null
      ? null
      : Get.arguments['commentId'] ?? ''; //需要置顶的评论id
  var momentDetailModel = SingleMomentModel().obs;
  FocusNode focusNode;
  TextEditingController textEditingController;
  var placeholder = '我来说下~'.obs; //输入框占位符
  var addOrReply = true.obs; //评论是新增还是回复
  MomentCommentModel currentSelectComment; //当前选择的评论
  MomentCommentReplyModel currentSelectReply; //当前选择的回复

  @override
  void onInit() {
    pageSize = 10;
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    await getMomentDetailData();
    super.onReady();
  }

  @override
  Future<List<MomentCommentModel>> loadData({int pageNum}) async {
    MomentCommentListModel _model = await DioManager()
        .request<MomentCommentListModel>(
            DioManager.GET, Api.circleMomentDetailCommentListUrl,
            queryParamters: {
          'cmt_page': pageNum,
          'c_id': circleId,
          'comment_id': commentId
        });
    return _model.data;
  }

  //获取圈子详情数据
  Future getMomentDetailData() async {
    momentDetailModel.value = await DioManager().request<SingleMomentModel>(
        DioManager.GET, Api.circleMomentDetailUrl,
        queryParamters: {'cid': circleId});

    //本地同步数据状态到其他圈子列表页面
    //wow推荐圈子
    for (var i = 0;
        i < Get.find<RecommendController>().momentListModel.value.list.length;
        i++) {
      MomentModel momentModel =
          Get.find<RecommendController>().momentListModel.value.list[i];
      if (momentModel.circleId == momentDetailModel.value.list.circleId) {
        Get.find<RecommendController>()
            .momentListModel
            .value
            .list
            .remove(momentModel);
        momentModel.visitsNum =
            (int.parse(momentModel.visitsNum) + 1).toString();
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
      if (momentModel.circleId == momentDetailModel.value.list.circleId) {
        Get.find<CircleController>().list.remove(momentModel);
        momentModel.visitsNum =
            (int.parse(momentModel.visitsNum) + 1).toString();
        Get.find<CircleController>().list.insert(i, momentModel);
      }
    }
    //话题圈子列表
    if (Get.isRegistered<CircleTopicListController>()) {
      for (var i = 0;
          i < Get.find<CircleTopicListController>().list.length;
          i++) {
        MomentModel momentModel = Get.find<CircleTopicListController>().list[i];
        if (momentModel.circleId == momentDetailModel.value.list.circleId) {
          Get.find<CircleTopicListController>().list.remove(momentModel);
          momentModel.visitsNum =
              (int.parse(momentModel.visitsNum) + 1).toString();
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
        if (momentModel.circleId == momentDetailModel.value.list.circleId) {
          Get.find<SingleUserCircleController>().list.remove(momentModel);
          momentModel.visitsNum =
              (int.parse(momentModel.visitsNum) + 1).toString();
          Get.find<SingleUserCircleController>().list.insert(i, momentModel);
        }
      }
    }
  }

  //资讯分享
  void share() {
    if (momentDetailModel.value.list.circleId == null) {
      return;
    }
    //分享数据
    Map<String, dynamic> shareParams = Map<String, dynamic>();
    //易观统计数据
    Map<String, dynamic> extraParams = Map<String, dynamic>();
    shareParams['title'] = '这里有一个好玩的话题，来看看？';
    shareParams['desc'] = '喜欢VE-1的朋友都在这里，分享用车趣事，发布爱车美图，快来一起玩吧！';
    shareParams['thumbImage'] = '';
    shareParams['url'] = CacheKey.SERVICE_URL_HOST +
        HtmlUrls.CircleMomentDetailPage +
        '?cid=${momentDetailModel.value.list.circleId}';
    Get.bottomSheet(ShareMenuWidget(
      isCircle: true,
      shareData: shareParams,
    ));
  }

  //删除自己的评论
  Future deleteComment(MomentCommentModel model) async {
    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circleMomentDetailDeleteCommentUrl,
        params: {'cmt_id': model.id, 'c_id': circleId});
    if (result.result) {
      momentDetailModel.value.list.comment =
          (int.parse(momentDetailModel.value.list.comment) - 1).toString();
      list.remove(model);

      //本地同步数据状态到其他圈子列表页面
      //wow推荐圈子
      for (var i = 0;
          i < Get.find<RecommendController>().momentListModel.value.list.length;
          i++) {
        MomentModel momentModel =
            Get.find<RecommendController>().momentListModel.value.list[i];
        if (momentModel.circleId == momentDetailModel.value.list.circleId) {
          Get.find<RecommendController>()
              .momentListModel
              .value
              .list
              .remove(momentModel);
          momentModel.comment = (int.parse(momentModel.comment) - 1).toString();
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
        if (momentModel.circleId == momentDetailModel.value.list.circleId) {
          Get.find<CircleController>().list.remove(momentModel);
          momentModel.comment = (int.parse(momentModel.comment) - 1).toString();
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
          if (momentModel.circleId == momentDetailModel.value.list.circleId) {
            Get.find<CircleTopicListController>().list.remove(momentModel);
            momentModel.comment =
                (int.parse(momentModel.comment) - 1).toString();
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
          if (momentModel.circleId == momentDetailModel.value.list.circleId) {
            Get.find<SingleUserCircleController>().list.remove(momentModel);
            momentModel.comment =
                (int.parse(momentModel.comment) - 1).toString();
            Get.find<SingleUserCircleController>().list.insert(i, momentModel);
          }
        }
      }
    } else {
      EasyLoading.showToast(result.error,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //评论点赞
  Future<bool> praiseForCommentOrNot(
      bool isLiked, MomentCommentModel model) async {
    if (isLiked) {
      //已点赞，再点一次为取消点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.circleMomentCommentUnPraiseUrl,
          params: {'cmt_id': model.id});
      if (result.result) {
        model.praiseStatus = false;
        model.praiseNum = (int.parse(model.praiseNum) - 1).toString();
      } else {
        EasyLoading.showToast(result.error,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return model.praiseStatus;
    } else {
      //未点赞，为评论点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.circleMomentCommentPraiseUrl,
          params: {'cmt_id': model.id});
      if (result.result) {
        model.praiseStatus = true;
        model.praiseNum = (int.parse(model.praiseNum) + 1).toString();
      } else {
        EasyLoading.showToast(result.error,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return model.praiseStatus;
    }
  }

  //点击输入栏旁边的评论按钮
  void clickArticleCommentBtn() {
    Get.focusScope.unfocus();
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      Get.focusScope.requestFocus(focusNode);
      placeholder.value = '我来说下~';
      addOrReply.value = true;
      currentSelectComment = null;
      currentSelectReply = null;
    });
  }

  //评论点击
  void clickComment(MomentCommentModel model) {
    Get.focusScope.unfocus();
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      Get.focusScope.requestFocus(focusNode);
      placeholder.value = '回复 ${model.nickname}:';
      addOrReply.value = false;
      currentSelectComment = model;
      currentSelectReply = null;
    });
  }

  //回复评论点击
  void clickReplyComment(
      MomentCommentModel model, MomentCommentReplyModel replyModel) {
    Get.focusScope.unfocus();
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      Get.focusScope.requestFocus(focusNode);
      placeholder.value = '回复 ${replyModel.plName}:';
      addOrReply.value = false;
      currentSelectComment = model;
      currentSelectReply = replyModel;
    });
  }

  //发送评论
  Future sendComment(String input) async {
    if (CommonUtil.isBlank(input)) {
      textEditingController.text = '';
      return;
    }
    if (CommonUtil.containsLink(input)) {
      EasyLoading.showToast('发布内容中不能包含URL链接或网址',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    Map<String, dynamic> params = Map<String, dynamic>();
    params['c_id'] = momentDetailModel.value.list.circleId;
    params['content'] = input;
    if (!addOrReply.value) {
      //回复别人的评论
      params['pid'] = currentSelectComment.id;
      if (currentSelectReply != null) {
        params['reply_id'] = currentSelectReply.id;
      } else {
        params['reply_id'] = currentSelectComment.id;
      }
    }

    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circleMomentDetailAddReplyForCommentUrl,
        params: params);
    if (result.result) {
      momentDetailModel.value.list.comment =
          (int.parse(momentDetailModel.value.list.comment) + 1).toString();
      String comment_type, commented_content_id;
      if (addOrReply.value) {
        //添加新的评论
        comment_type = "圈子";
        commented_content_id = "";

        MomentCommentModel commentModel = MomentCommentModel();
        commentModel.avatar =
            Get.find<UserController>().userInfo.value.member.headImg;
        commentModel.content = input;
        commentModel.isSelf = true;
        commentModel.isVehicle =
            (Get.find<UserController>().userInfo.value.member.isVehicle ==
                'true');
        commentModel.nickname =
            Get.find<UserController>().userInfo.value.member.showName;
        commentModel.memberInfo =
            Get.find<UserController>().userInfo.value.member.memberInfo;
        commentModel.pubdate =
            DateUtil.formatDate(DateTime.now(), format: DateFormats.full);
        commentModel.id = result.list;
        commentModel.userId =
            Get.find<UserController>().userInfo.value.member.memberId;
        commentModel.isOfficial = false;
        commentModel.praiseNum = '0';
        commentModel.praiseStatus = false;
        commentModel.replyData = [];
        list.insert(0, commentModel);
      } else {
        //回复别人的评论
        comment_type = "回复";
        if (currentSelectReply != null) {
          commented_content_id = currentSelectReply.id;
        } else {
          commented_content_id = currentSelectComment.id;
        }

        int index = list.indexOf(currentSelectComment);
        list.remove(currentSelectComment);

        MomentCommentReplyModel replyModel = MomentCommentReplyModel();
        replyModel.id = result.list;
        replyModel.plName =
            Get.find<UserController>().userInfo.value.member.showName;
        replyModel.content = input;
        if (currentSelectReply != null) {
          replyModel.replyName = currentSelectReply.plName;
          replyModel.pid = currentSelectReply.id;
        } else {
          replyModel.replyName = currentSelectComment.nickname;
          replyModel.pid = currentSelectComment.id;
        }
        replyModel.isOfficial = false;
        currentSelectComment.replyData.add(replyModel);
        list.insert(index, currentSelectComment);
      }

      placeholder.value = '我来说下~';
      addOrReply.value = true;
      currentSelectComment = null;
      currentSelectReply = null;
      textEditingController.text = '';
    } else {
      EasyLoading.showToast(result.message,
          toastPosition: EasyLoadingToastPosition.bottom);
      Future.delayed(Duration(seconds: 2)).then((value) {
        refresh();
      });
    }
  }

  //头像点击
  void clickAvatar(String userId) {
    Get.toNamed(Routes.USERPROFILE, arguments: {'user_id': userId});
  }

  //点击勋章
  void clickMedal() {}
}
