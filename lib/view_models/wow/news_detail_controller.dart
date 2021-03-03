import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/wow/news_comment_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/cate_news_controller.dart';
import 'package:ws_app_flutter/view_models/wow/news_controller.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
import 'package:ws_app_flutter/widgets/wow/share_menu.dart';

class NewsDetailController extends RefreshListController<NewsCommentModel> {
  var articleId = ''.obs;
  var newsDetailModel = NewsDetailModel().obs;
  FocusNode focusNode;
  TextEditingController textEditingController;
  var placeholder = '我来说下~'.obs; //输入框占位符
  var addOrReply = true.obs; //评论是新增还是回复
  NewsCommentModel currentSelectComment; //当前选择的评论
  ReplyModel currentSelectReply; //当前选择的回复

  @override
  void onInit() {
    pageSize = 10;
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    await getNewsDetailData();
    super.onReady();
  }

  @override
  Future<List<NewsCommentModel>> loadData({int pageNum}) async {
    NewsCommentListModel _model = await DioManager()
        .request<NewsCommentListModel>(
            DioManager.GET, Api.newsDetailCommentListUrl,
            queryParamters: {'cmt_page': pageNum, 'art_id': articleId.value});
    return _model.cmtList;
  }

  //资讯详情数据
  Future getNewsDetailData() async {
    newsDetailModel.value = await DioManager().request<NewsDetailModel>(
        DioManager.GET, Api.newsDetailUrl,
        queryParamters: {'art_id': articleId.value});

    //本地同步数据状态到上级资讯列表页面
    //首页资讯列表
    for (var i = 0; i < Get.find<NewsController>().list.length; i++) {
      NewModel newModel = Get.find<NewsController>().list[i];
      if (newModel.articleId == newsDetailModel.value.article.articleId) {
        Get.find<NewsController>().list.remove(newModel);
        newModel.read = (int.parse(newModel.read) + 1).toString();
        Get.find<NewsController>().list.insert(i, newModel);
      }
    }
    //首页wow推荐资讯
    for (var i = 0;
        i < Get.find<RecommendController>().newsListModel.value.list.length;
        i++) {
      NewModel newModel =
          Get.find<RecommendController>().newsListModel.value.list[i];
      if (newModel.articleId == newsDetailModel.value.article.articleId) {
        Get.find<RecommendController>()
            .newsListModel
            .value
            .list
            .remove(newModel);
        newModel.read = (int.parse(newModel.read) + 1).toString();
        Get.find<RecommendController>()
            .newsListModel
            .value
            .list
            .insert(i, newModel);
      }
    }
    //分类资讯列表
    if (Get.isRegistered<CateNewsController>()) {
      for (var i = 0; i < Get.find<CateNewsController>().list.length; i++) {
        NewModel newModel = Get.find<CateNewsController>().list[i];
        if (newModel.articleId == newsDetailModel.value.article.articleId) {
          Get.find<CateNewsController>().list.remove(newModel);
          newModel.read = (int.parse(newModel.read) + 1).toString();
          Get.find<CateNewsController>().list.insert(i, newModel);
        }
      }
    }
  }

  //资讯分享
  void share() {
    if (newsDetailModel.value.article.articleId == null) {
      return;
    }
    //分享数据
    Map<String, dynamic> shareParams = Map<String, dynamic>();
    //易观统计数据
    Map<String, dynamic> extraParams = Map<String, dynamic>();
    shareParams['title'] = newsDetailModel.value.article.title;
    shareParams['desc'] =
        newsDetailModel.value.article.bodys.seoDescription.length > 0
            ? newsDetailModel.value.article.bodys.seoDescription
            : newsDetailModel.value.article.title;
    if (newsDetailModel.value.article.imageUrl.contains('?')) {
      shareParams['icon'] =
          newsDetailModel.value.article.imageUrl.split('?').first;
    }

    shareParams['url'] = CacheKey.SERVICE_URL_HOST +
        HtmlUrls.NewsDetailPage +
        '?art_id=${newsDetailModel.value.article.articleId}';
    Get.bottomSheet(ShareMenuWidget(
      shareData: shareParams,
    ));
  }

  //资讯文章点赞
  Future<bool> praiseForArticleOrNot(bool isLiked) async {
    if (isLiked) {
      //已点赞，再次点击取消点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.newsDetailUnPraiseUrl,
          params: {'art_id': newsDetailModel.value.article.articleId});
      if (result.result) {
        newsDetailModel.value.article.praiseStatus = false;
        newsDetailModel.value.article.articlePraise =
            newsDetailModel.value.article.articlePraise - 1;

        //本地同步数据状态到上级资讯列表页面
        //首页资讯列表
        for (var i = 0; i < Get.find<NewsController>().list.length; i++) {
          NewModel newModel = Get.find<NewsController>().list[i];
          if (newModel.articleId == newsDetailModel.value.article.articleId) {
            Get.find<NewsController>().list.remove(newModel);
            newModel.articlePraise = newModel.articlePraise - 1;
            Get.find<NewsController>().list.insert(i, newModel);
          }
        }
        //首页wow推荐资讯
        for (var i = 0;
            i < Get.find<RecommendController>().newsListModel.value.list.length;
            i++) {
          NewModel newModel =
              Get.find<RecommendController>().newsListModel.value.list[i];
          if (newModel.articleId == newsDetailModel.value.article.articleId) {
            Get.find<RecommendController>()
                .newsListModel
                .value
                .list
                .remove(newModel);
            newModel.articlePraise = newModel.articlePraise - 1;
            Get.find<RecommendController>()
                .newsListModel
                .value
                .list
                .insert(i, newModel);
          }
        }
        //分类资讯列表
        if (Get.isRegistered<CateNewsController>()) {
          for (var i = 0; i < Get.find<CateNewsController>().list.length; i++) {
            NewModel newModel = Get.find<CateNewsController>().list[i];
            if (newModel.articleId == newsDetailModel.value.article.articleId) {
              Get.find<CateNewsController>().list.remove(newModel);
              newModel.articlePraise = newModel.articlePraise - 1;
              Get.find<CateNewsController>().list.insert(i, newModel);
            }
          }
        }
      } else {
        EasyLoading.showToast(result.message,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return newsDetailModel.value.article.praiseStatus;
    } else {
      //未点赞，点击点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.newsDetailPraiseUrl,
          params: {'art_id': newsDetailModel.value.article.articleId});
      if (result.result) {
        newsDetailModel.value.article.praiseStatus = true;
        newsDetailModel.value.article.articlePraise =
            newsDetailModel.value.article.articlePraise + 1;

        //本地同步数据状态到上级资讯列表页面
        //首页资讯列表
        for (var i = 0; i < Get.find<NewsController>().list.length; i++) {
          NewModel newModel = Get.find<NewsController>().list[i];
          if (newModel.articleId == newsDetailModel.value.article.articleId) {
            Get.find<NewsController>().list.remove(newModel);
            newModel.articlePraise = newModel.articlePraise + 1;
            Get.find<NewsController>().list.insert(i, newModel);
          }
        }
        //首页wow推荐资讯
        for (var i = 0;
            i < Get.find<RecommendController>().newsListModel.value.list.length;
            i++) {
          NewModel newModel =
              Get.find<RecommendController>().newsListModel.value.list[i];
          if (newModel.articleId == newsDetailModel.value.article.articleId) {
            Get.find<RecommendController>()
                .newsListModel
                .value
                .list
                .remove(newModel);
            newModel.articlePraise = newModel.articlePraise + 1;
            Get.find<RecommendController>()
                .newsListModel
                .value
                .list
                .insert(i, newModel);
          }
        }
        //分类资讯列表
        if (Get.isRegistered<CateNewsController>()) {
          for (var i = 0; i < Get.find<CateNewsController>().list.length; i++) {
            NewModel newModel = Get.find<CateNewsController>().list[i];
            if (newModel.articleId == newsDetailModel.value.article.articleId) {
              Get.find<CateNewsController>().list.remove(newModel);
              newModel.articlePraise = newModel.articlePraise + 1;
              Get.find<CateNewsController>().list.insert(i, newModel);
            }
          }
        }
      } else {
        EasyLoading.showToast(result.message,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return newsDetailModel.value.article.praiseStatus;
    }
  }

  //资讯文章收藏
  Future<bool> collectForArticleOrNot(bool isLiked) async {
    if (isLiked) {
      //已收藏，再次点击取消收藏
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.newsDetailUnFavorUrl,
          params: {'art_id': newsDetailModel.value.article.articleId});
      if (result.res) {
        newsDetailModel.value.article.praiseStatus = false;
        newsDetailModel.value.article.articlePraise =
            newsDetailModel.value.article.articlePraise - 1;
      } else {
        EasyLoading.showToast(result.error,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return newsDetailModel.value.article.praiseStatus;
    } else {
      //未收藏，点击收藏
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.newsDetailFavorUrl,
          params: {'art_id': newsDetailModel.value.article.articleId});
      if (result.res) {
        newsDetailModel.value.article.praiseStatus = true;
        newsDetailModel.value.article.articlePraise =
            newsDetailModel.value.article.articlePraise + 1;
      } else {
        EasyLoading.showToast(result.error,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return newsDetailModel.value.article.praiseStatus;
    }
  }

  //删除自己的评论
  Future deleteComment(NewsCommentModel model) async {
    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.POST, Api.newsDetailDeleteCommentUrl,
        params: {'cmt_id': model.id});
    if (result.res) {
      newsDetailModel.value.article.commentCount =
          (int.parse(newsDetailModel.value.article.commentCount) - 1)
              .toString();
      list.remove(model);

      //本地同步数据状态到上级资讯列表页面
    //首页资讯列表
    for (var i = 0; i < Get.find<NewsController>().list.length; i++) {
      NewModel newModel = Get.find<NewsController>().list[i];
      if (newModel.articleId == newsDetailModel.value.article.articleId) {
        Get.find<NewsController>().list.remove(newModel);
        newModel.commentCount = (int.parse(newModel.commentCount) - 1).toString();
        Get.find<NewsController>().list.insert(i, newModel);
      }
    }
    //首页wow推荐资讯
    for (var i = 0;
        i < Get.find<RecommendController>().newsListModel.value.list.length;
        i++) {
      NewModel newModel =
          Get.find<RecommendController>().newsListModel.value.list[i];
      if (newModel.articleId == newsDetailModel.value.article.articleId) {
        Get.find<RecommendController>()
            .newsListModel
            .value
            .list
            .remove(newModel);
        newModel.commentCount = (int.parse(newModel.commentCount) - 1).toString();
        Get.find<RecommendController>()
            .newsListModel
            .value
            .list
            .insert(i, newModel);
      }
    }
    //分类资讯列表
    if (Get.isRegistered<CateNewsController>()) {
      for (var i = 0; i < Get.find<CateNewsController>().list.length; i++) {
        NewModel newModel = Get.find<CateNewsController>().list[i];
        if (newModel.articleId == newsDetailModel.value.article.articleId) {
          Get.find<CateNewsController>().list.remove(newModel);
          newModel.commentCount = (int.parse(newModel.commentCount) - 1).toString();
          Get.find<CateNewsController>().list.insert(i, newModel);
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
      bool isLiked, NewsCommentModel model) async {
    if (isLiked) {
      //已点赞，再点一次为取消点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.newsDetailCommentUnPraiseUrl,
          params: {'cmt_id': model.id});
      if (result.res) {
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
          DioManager.POST, Api.newsDetailCommentPraiseUrl,
          params: {'cmt_id': model.id});
      if (result.res) {
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
  void clickComment(NewsCommentModel model) {
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
  void clickReplyComment(NewsCommentModel model, ReplyModel replyModel) {
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
    }
    Map<String, dynamic> params = Map<String, dynamic>();
    params['art_id'] = newsDetailModel.value.article.articleId;
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
        DioManager.POST, Api.newsDetailAddCommentUrl,
        params: params);
    if (result.result) {
      newsDetailModel.value.article.commentCount =
          (int.parse(newsDetailModel.value.article.commentCount) + 1)
              .toString();
      String comment_type, commented_content_id;
      if (addOrReply.value) {
        //添加新的评论
        comment_type = "资讯文章";
        commented_content_id = "";

        NewsCommentModel commentModel = NewsCommentModel();
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

        ReplyModel replyModel = ReplyModel();
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
  void clickAvatar(NewsCommentModel model) {
    Get.toNamed(Routes.USERPROFILE, arguments: {'user_id': model.userId});
  }

  //点击勋章
  void clickMedal() {}
}
