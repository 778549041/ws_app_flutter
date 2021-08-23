import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class SystemMsgModel {
  List<SystemMsg>? msgList;

  SystemMsgModel({this.msgList});

  SystemMsgModel.fromJson(Map<String, dynamic> json) {
    msgList = <SystemMsg>[];
    if (json['msg_list'] != null && json['msg_list'] != false) {
      (json['msg_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            msgList?.add(
                SystemMsg.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class SystemMsg {
  String? content;
  int? createtime;
  String? memberId;
  String? msgId;
  String? msgType;
  String? status;
  String? subject;
  String? target;

  SystemMsg({
    this.content,
    this.createtime,
    this.memberId,
    this.msgId,
    this.msgType,
    this.status,
    this.subject,
    this.target,
  });

  SystemMsg.fromJson(Map<String, dynamic> json) {
    content = asT<String?>(json['content']);
    createtime = asT<int?>(json['createtime']);
    memberId = asT<String?>(json['member_id']);
    msgId = asT<String?>(json['msg_id']);
    msgType = asT<String?>(json['msg_type']);
    status = asT<String?>(json['status']);
    subject = asT<String?>(json['subject']);
    target = asT<String?>(json['target']);
  }
}
