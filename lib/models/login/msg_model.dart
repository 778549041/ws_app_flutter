import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

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
    interactionCount = asT<String>(json['interactionCount']);
    msgCount = asT<String>(json['msgCount']);
    circleCount = asT<String>(json['circleCount']);
    memberInfo = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['memberInfo'], Map<String, dynamic>()));
  }
}
