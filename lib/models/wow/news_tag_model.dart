import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class NewsTagListModel {
  List<NewsTagModel> list;

  NewsTagListModel({this.list});

  NewsTagListModel.fromJson(Map<String, dynamic> json) {
    list = <NewsTagModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list.add(NewsTagModel.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
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
    tagId = asT<String>(json['tag_id']);
    tagName = asT<String>(json['tag_name']);
    selected = false;
  }
}
