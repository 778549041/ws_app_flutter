import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CommonQuModel {
  Map? filePath;
  List<SingleQuestion>? list;

  CommonQuModel({this.filePath, this.list});

  CommonQuModel.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
    list = <SingleQuestion>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                SingleQuestion.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class SingleQuestion {
  String? answer;
  String? answeringId;
  double? createtime;
  bool? diy;
  String? fileId;
  String? fileType;
  String? ordernum;
  String? questions;
  String? filePath;

  SingleQuestion({
    this.answer,
    this.answeringId,
    this.createtime,
    this.diy,
    this.fileId,
    this.fileType,
    this.ordernum,
    this.questions,
    this.filePath,
  });

  SingleQuestion.fromJson(Map<String, dynamic> json) {
    answer = asT<String?>(json['answer']);
    answeringId = asT<String?>(json['answering_id']);
    createtime = asT<double?>(json['createtime']);
    diy = asT<bool?>(json['diy']);
    fileId = asT<String?>(json['file_id']);
    fileType = asT<String?>(json['file_type']);
    ordernum = asT<String?>(json['ordernum']);
    questions = asT<String?>(json['questions']);
  }
}
