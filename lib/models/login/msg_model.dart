import 'package:ws_app_flutter/models/common/common_member.dart';

class MsgModel {
  String interactionCount;
  String msgCount;
  String circleCount;
  CommonMemberModel memberInfo;

  MsgModel(
      {this.interactionCount = '',
      this.msgCount = '',
      this.circleCount = '',
      this.memberInfo});

  MsgModel.fromJson(Map<String, dynamic> json) {
    interactionCount = json['interactionCount'].toString();
    msgCount = json['msgCount'].toString();
    circleCount = json['circleCount'].toString();
    memberInfo = json['memberInfo'] != null
        ? CommonMemberModel.fromJson(json['memberInfo'])
        : null;
  }
}
