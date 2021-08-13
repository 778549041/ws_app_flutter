import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class TopicListModel {
  int? totalPage;
  List<TopicModel>? list;

  TopicListModel({this.totalPage = 0}) : list = <TopicModel>[];

  TopicListModel.fromJson(Map<String, dynamic> json) {
    list = <TopicModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(TopicModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    totalPage = asT<int>(json['total_page']);
  }
}

class SingleTopicodel {
  TopicModel? list;

  SingleTopicodel() : list = TopicModel();

  SingleTopicodel.fromJson(Map<String, dynamic> json) {
    list = json['list'] == null ? null : TopicModel.fromJson(
        asT<Map<String, dynamic>>(json['list'])!);
  }
}

class TopicModel {
  String? topicId;
  String? title;
  String? content;
  String? imageUrl;
  String? adminUrl;
  int? totalNum;
  bool? join;
  bool? showAll;

  TopicModel(
      {this.topicId,
      this.title,
      this.content,
      this.imageUrl,
      this.adminUrl,
      this.totalNum,
      this.join,
      this.showAll = false});

  TopicModel.fromJson(Map<String, dynamic> json) {
    topicId = asT<String?>(json['topic_id']);
    title = asT<String?>(json['title']);
    content = asT<String?>(json['content']);
    imageUrl = asT<String?>(json['image_url']);
    adminUrl = asT<String?>(json['admin_url']);
    totalNum = asT<int?>(json['num']);
    join = asT<bool?>(json['join']);
    showAll = false;
  }
}
