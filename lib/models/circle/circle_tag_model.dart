import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CircleTagListModel {
  bool? result;
  int? code;
  String? message;
  List<CircleTagModel>? data;

  CircleTagListModel({
    this.result,
    this.code,
    this.message,
    this.data,
  });

  CircleTagListModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    code = asT<int?>(json['code']);
    message = asT<String?>(json['message']);
    data = <CircleTagModel>[];
    if (json['data'] != null && json['data'] != false) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(
                CircleTagModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class CircleTagModel {
  String? title; // 标签名
  int? tag_id; // 标签id
  bool? canPan; // 是否允许拖拽
  bool? canDelete; // 是否可以删除
  bool? canLongPress; // 是否允许长按
  bool? hideDelete; // 是否隐藏删除按钮
  bool? selected; // 是否选中

  CircleTagModel({
    this.title,
    this.tag_id,
    this.canPan,
    this.canDelete,
    this.canLongPress,
    this.hideDelete,
    this.selected,
  });

  CircleTagModel.fromJson(Map<String, dynamic> json) {
    title = asT<String?>(json['title']);
    tag_id = asT<int?>(json['tag_id']);
  }
}
