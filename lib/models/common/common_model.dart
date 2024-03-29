import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CommonModel {
  String? success;
  String? error;
  String? redirect;
  bool? result;
  String? code;
  String? message;
  String? imageId;
  bool? status;
  String? datas;
  bool? res;
  String? list;
  String? id;
  int? score;
  CommonData? data;

  CommonModel({
    this.success,
    this.error,
    this.redirect,
    this.result = false,
    this.code,
    this.message,
    this.imageId,
    this.status,
    this.datas,
    this.res,
    this.list,
    this.id,
    this.score,
    this.data,
  });

  CommonModel.fromJson(Map<String, dynamic> json) {
    success = asT<String>(json['success']);
    error = asT<String>(json['error']);
    redirect = asT<String>(json['redirect']);
    result = asT<bool>(json['result']);
    code = asT<String>(json['code']);
    message = asT<String>(json['message']);
    imageId = asT<String>(json['image_id']);
    status = asT<bool>(json['status']);
    datas = asT<String>(json['datas']);
    res = asT<bool>(json['res']);
    list = asT<String>(json['list']);
    id = asT<String>(json['id']);
    score = asT<int?>(json['score']);
    data = json['data'] == null
        ? null
        : CommonData.fromJson(asT<Map<String, dynamic>>(json['data'])!);
  }
}

class CommonData {
  bool? has_vehicle;

  CommonData({this.has_vehicle});

  CommonData.fromJson(Map<String, dynamic> json) {
    has_vehicle = asT<bool?>(json['has_vehicle']);
  }
}
