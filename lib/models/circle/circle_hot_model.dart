import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CircleHotModel {
  bool? result;
  int? code;
  String? message;
  List<CircleHotData>? data;

  CircleHotModel({
    this.result,
    this.code,
    this.message,
    this.data,
  });

  CircleHotModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    code = asT<int?>(json['code']);
    message = asT<String?>(json['message']);
    if (json['data'] != null && json['data'] != false) {
      data = <CircleHotData>[];
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(
                CircleHotData.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class CircleHotData {
  //活动
  String? huodong_id;
  String? url;
  bool? is_online;
  bool? is_vote;
  bool? is_custom;
  String? name;
  //资讯
  String? article_id;
  String? comment;
  String? title;
  //话题
  String? topic_id;
  bool? hot1; //为true显示新标签
  bool? hot6; //为true显示热标签
  bool? hot24; //为true显示爆标签
  int? type; //1活动，2资讯，3话题

  String? typeImgName; //类型图标

  CircleHotData({
    this.huodong_id,
    this.url,
    this.is_online,
    this.is_vote,
    this.is_custom,
    this.name,
    this.article_id,
    this.comment,
    this.title,
    this.topic_id,
    this.hot1,
    this.hot6,
    this.hot24,
    this.type,
    this.typeImgName,
  });

  CircleHotData.fromJson(Map<String, dynamic> json) {
    huodong_id = asT<String?>(json['huodong_id']);
    url = asT<String?>(json['url']);
    is_online = asT<bool?>(json['is_online']);
    is_vote = asT<bool?>(json['is_vote']);
    is_custom = asT<bool?>(json['is_custom']);
    name = asT<String?>(json['name']);
    article_id = asT<String?>(json['article_id']);
    comment = asT<String?>(json['comment']);
    title = asT<String?>(json['title']);
    topic_id = asT<String?>(json['topic_id']);
    hot1 = asT<bool?>(json['hot1']);
    hot6 = asT<bool?>(json['hot6']);
    hot24 = asT<bool?>(json['hot24']);
    type = asT<int?>(json['type']);
    if (type == 1) {
      typeImgName = 'assets/images/circle/hot_recommend_act.png';
    } else if (type == 2) {
      typeImgName = 'assets/images/circle/hot_recommend_art.png';
    } else if (type == 3) {
      typeImgName = 'assets/images/circle/hot_recommend_topic.png';
    }
  }
}
