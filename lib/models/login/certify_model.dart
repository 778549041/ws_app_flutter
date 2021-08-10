import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CertifyModel {
  bool? result;
  String? message;
  int? code;

  CertifyModel({this.result = false, this.message = '', this.code = 0});

  CertifyModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool>(json['result'], false);
    message = asT<String>(json['message'], '');
    code = asT<int>(json['code'], 0);
  }
}
