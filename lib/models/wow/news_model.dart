import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class NewsListModel {
  List<NewModel>? list;
  int? totalPage;
  String? contentName;

  NewsListModel({this.totalPage, this.contentName}) : list = <NewModel>[];

  NewsListModel.fromJson(Map<String, dynamic> json) {
    list = <NewModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list!.add(NewModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    totalPage = asT<int>(json['total_page']);
    contentName = asT<String>(json['content_name']);
  }
}

class NewModel {
  String? articleId;
  int? articlePraise;
  String? title;
  String? pubtime;
  String? imageUrl;
  String? commentCount;
  bool? collectStatus;
  String? collection;
  String? read;
  bool? isBgClear;
  HtmlBody? bodys;
  bool? praiseStatus;
  bool? isLogin;
  String? uptime;

  NewModel(
      {this.articleId,
      this.articlePraise = 0,
      this.title = '',
      this.pubtime = '0',
      this.imageUrl = '',
      this.commentCount = '0',
      this.collectStatus = false,
      this.collection = '0',
      this.read = '0',
      this.isBgClear = false,
      this.isLogin,
      this.praiseStatus = false,
      this.uptime = ''})
      : bodys = HtmlBody();

  NewModel.fromJson(Map<String, dynamic> json) {
    articleId = asT<String>(json['article_id']);
    articlePraise = asT<int>(json['article_praise']);
    title = asT<String>(json['title']);
    pubtime = asT<String>(json['pubtime']);
    imageUrl = asT<String>(json['image_url']);
    commentCount = asT<String>(json['comment_count']);
    collectStatus = asT<bool>(json['collect_status']);
    collection = asT<String>(json['collection']);
    read = asT<String>(json['read']);
    isBgClear = false;
    bodys = HtmlBody.fromJson(
        asT<Map<String, dynamic>>(json['bodys'], Map<String, dynamic>())!);
    isLogin = asT<bool>(json['is_login']);
    praiseStatus = asT<bool>(json['praise_status']);
    uptime = asT<String>(json['uptime']);
  }
}

class NewsDetailModel {
  NewModel? article;

  NewsDetailModel() : article = NewModel();

  NewsDetailModel.fromJson(Map<String, dynamic> json) {
    article = NewModel.fromJson(
        asT<Map<String, dynamic>>(json['article'], Map<String, dynamic>())!);
  }
}

class HtmlBody {
  String? content;
  String? seoDescription;
  String? seotitle;

  HtmlBody({this.content = '', this.seoDescription = '', this.seotitle = ''});

  HtmlBody.fromJson(Map<String, dynamic> json) {
    content = asT<String>(json['content']);
    seoDescription = asT<String>(json['seo_description']);
    seotitle = asT<String>(json['seo_title']);
  }
}
