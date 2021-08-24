import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class MsgModel {
  String? interactionCount;
  String? msgCount;
  String? circleCount;
  CommonMemberModel? memberInfo;

  MsgModel(
      {this.interactionCount = '0',
      this.msgCount = '0',
      this.circleCount = '0',
      this.memberInfo});

  MsgModel.fromJson(Map<String, dynamic> json) {
    interactionCount = asT<String>(json['interactionCount'],'0');
    msgCount = asT<String>(json['msgCount'],'0');
    circleCount = asT<String>(json['circleCount'],'0');
    memberInfo = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['memberInfo'], Map<String, dynamic>())!);
  }
}
