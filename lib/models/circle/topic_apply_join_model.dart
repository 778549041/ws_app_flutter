import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class TopicApplyJoinListModel {
  bool? result;
  int? code;
  int? total_page;
  List<TopicApplyJoinModel>? data;

  TopicApplyJoinListModel({this.result, this.code, this.total_page, this.data});

  TopicApplyJoinListModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    code = asT<int?>(json['code']);
    total_page = asT<int?>(json['total_page']);
    data = <TopicApplyJoinModel>[];
    if (json['data'] != null && json['data'] != false) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(TopicApplyJoinModel.fromJson(
                asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class TopicApplyJoinModel {
  String? id; //记录id
  String? topic_id; //话题id
  int? status; // 0待审核 1通过 2拒绝
  String? member_id; //申请用户id
  String? create_time; //时间
  CommonMemberModel? memberInfo; //申请用户信息

  TopicApplyJoinModel(
      {this.id,
      this.topic_id,
      this.status,
      this.member_id,
      this.create_time,
      this.memberInfo});

  TopicApplyJoinModel.fromJson(Map<String, dynamic> json) {
    id = asT<String?>(json['id']);
    topic_id = asT<String?>(json['topic_id']);
    status = asT<int?>(json['status']);
    member_id = asT<String?>(json['member_id']);
    create_time = asT<String?>(json['create_time']);
    memberInfo = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['memberInfo'], Map<String, dynamic>())!);
  }
}
