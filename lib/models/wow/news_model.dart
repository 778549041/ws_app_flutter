class NewsListModel {
  List<NewModel> list;
  int totalPage;
  String contentName;

  NewsListModel({this.totalPage, this.contentName}) : list = List<NewModel>();

  NewsListModel.fromJson(Map<String, dynamic> json) {
    list = List<NewModel>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(NewModel.fromJson(element));
      });
    }
    totalPage = json['total_page'];
    contentName = json['content_name'];
  }
}

class NewModel {
  String articleId;
  int articlePraise;
  String title;
  String pubtime;
  String imageUrl;
  int commentCount;
  bool collectStatus;
  String collection;
  String read;
  bool isBgClear;
  HtmlBody bodys;
  bool praiseStatus;
  bool isLogin;
  String uptime;

  NewModel(
      {this.articleId,
      this.articlePraise,
      this.title,
      this.pubtime,
      this.imageUrl,
      this.commentCount,
      this.collectStatus,
      this.collection,
      this.read,
      this.isBgClear = false,
      this.isLogin,
      this.praiseStatus,
      this.uptime})
      : bodys = HtmlBody();

  NewModel.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    articlePraise = json['article_praise'];
    title = json['title'];
    pubtime = json['pubtime'];
    imageUrl = json['image_url'];
    commentCount = json['comment_count'];
    collectStatus = json['collect_status'];
    collection = json['collection'];
    read = json['read'];
    isBgClear = false;
    bodys =
        json['bodys'] != null ? HtmlBody.fromJson(json['bodys']) : HtmlBody();
    isLogin = json['is_login'];
    praiseStatus = json['praise_status'];
    uptime = json['uptime'];
  }
}

class NewsDetailModel {
  NewModel article;

  NewsDetailModel() : article = NewModel();

  NewsDetailModel.fromJson(Map<String, dynamic> json) {
    article = json['article'] != null
        ? NewModel.fromJson(json['article'])
        : NewModel();
  }
}

class HtmlBody {
  String content;
  String seoDescription;
  String seotitle;

  HtmlBody({this.content, this.seoDescription, this.seotitle});

  HtmlBody.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    seoDescription = json['seo_description'];
    seotitle = json['seo_title'];
  }
}