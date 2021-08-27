import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class InteraMsgModel {
  List<InteraModel>? list;
  Map? memberList;

  InteraMsgModel({this.list, this.memberList});

  InteraMsgModel.fromJson(Map<String, dynamic> json) {
    memberList = (json['memberList'] != null && json['memberList'] != false) ? json['memberList'] : null;
    list = <InteraModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                InteraModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class InteraModel {
  String? commentId;
  String? interactionId;
  int? inv; //1表示其他用户请求添加自己为好友，2表示自己请求添加其他用户为好友
  String? proMemberId; //请求添加好友的memberid
  bool? read;
  String? relId;//点赞资讯id
  int? status; //1等待验证，2已添加,3已拒绝
  String? type;//friends表示添加好友，content_comment_praise表示资讯评论点赞
  String? name;
  String? avatar;

  InteraModel({
    this.commentId,
    this.interactionId,
    this.inv,
    this.proMemberId,
    this.read,
    this.relId,
    this.status,
    this.type,
    this.name,
    this.avatar,
  });

  InteraModel.fromJson(Map<String, dynamic> json) {
    commentId = asT<String?>(json['comment_id']);
    interactionId = asT<String?>(json['interaction_id']);
    inv = asT<int?>(json['inv']);
    proMemberId = asT<String?>(json['pro_member_id']);
    read = asT<bool?>(json['read']);
    relId = asT<String?>(json['rel_id']);
    status = asT<int?>(json['status']);
    type = asT<String?>(json['type']);
  }
}
