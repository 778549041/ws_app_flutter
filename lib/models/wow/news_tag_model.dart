class NewsTagListModel {
  List<NewsTagModel> list;

  NewsTagListModel({this.list});

  NewsTagListModel.fromJson(Map<String, dynamic> json) {
    list = <NewsTagModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(NewsTagModel.fromJson(element));
      });
    }
  }
}

class NewsTagModel {
  String tagId;
  String tagName;
  bool selected;

  NewsTagModel({this.tagId, this.tagName, this.selected});

  NewsTagModel.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    tagName = json['tag_name'];
    selected = false;
  }
}
