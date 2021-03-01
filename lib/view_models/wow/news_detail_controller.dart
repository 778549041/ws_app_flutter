import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/wow/news_comment_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/widgets/wow/share_menu.dart';

class NewsDetailController extends RefreshListController<NewsCommentModel> {
  var articleId = ''.obs;
  var newsDetailModel = NewsDetailModel().obs;
  FocusNode focusNode;
  var placeholder = '我来说下~'.obs; //输入框占位符
  var addOrReply = true.obs;//评论是新增还是回复

  @override
  void onInit() {
    pageSize = 10;
    focusNode = FocusNode();
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

  //发送评论
  Future sendComment(String input) async {}

  //资讯文章点赞
  Future<bool> praiseForArticleOrNot(bool isLiked) async {
    if (isLiked) {
      //已点赞，再次点击取消点赞
      CommonModel result = await DioManager().request<CommonModel>(
          DioManager.POST, Api.newsDetailUnPraiseUrl,
          params: {'art_id': newsDetailModel.value.article.articleId});
      if (result.result) {
        newsDetailModel.value.article.praiseStatus = false;
        newsDetailModel.value.article.articlePraise = newsDetailModel.value.article.articlePraise - 1;
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
        newsDetailModel.value.article.articlePraise = newsDetailModel.value.article.articlePraise + 1;
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
        newsDetailModel.value.article.articlePraise = newsDetailModel.value.article.articlePraise - 1;
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
        newsDetailModel.value.article.articlePraise = newsDetailModel.value.article.articlePraise + 1;
      } else {
        EasyLoading.showToast(result.error,
          toastPosition: EasyLoadingToastPosition.bottom);
      }
      return newsDetailModel.value.article.praiseStatus;
    }
  }

  //点击输入栏旁边的点赞按钮
  void clickArticlePraiseBtn() {
    placeholder.value = '我来说下~';
    addOrReply.value = true;
    Get.focusScope.requestFocus(focusNode);
  }

  //头像点击
  void clickAvatar(NewsCommentModel model) {
    
  }

  //点击勋章
  void clickMedal() {}

  //删除自己的评论
  Future deleteComment(NewsCommentModel model) async {
    CommonModel result = await DioManager().request<CommonModel>(DioManager.POST, Api.newsDetailDeleteCommentUrl,params: {'cmt_id':model.id});
    if (result.res) {
      newsDetailModel.value.article.commentCount = (int.parse(newsDetailModel.value.article.commentCount) - 1).toString();
      list.remove(model);
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

  //评论点击
  void clickComment(NewsCommentModel model) {
    placeholder.value = '回复 ${model.nickname}:';
    addOrReply.value = false;
    Get.focusScope.requestFocus(focusNode);
  }

  //回复评论点击
  void clickReplyComment(ReplyModel replyModel) {
    placeholder.value = '回复 ${replyModel.plName}:';
    addOrReply.value = false;
    Get.focusScope.requestFocus(focusNode);
  }
}
