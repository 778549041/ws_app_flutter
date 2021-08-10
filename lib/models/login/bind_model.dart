import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class BindModel {
  String? result;
  BindData? data;

  BindModel({this.result = ''}) : data = BindData();

  BindModel.fromJson(Map<String, dynamic> json) {
    result = asT<String>(json['result'], '');
    data = BindData.fromJson(
        asT<Map<String, dynamic>>(json['data'], Map<String, dynamic>())!);
  }
}

class BindData {
  bool? isMobile;
  bool? isVehicle;
  String? msg;

  BindData({this.isMobile = false, this.isVehicle = false, this.msg = ''});

  BindData.fromJson(Map<String, dynamic> json) {
    isMobile = asT<bool>(json['is_mobile'], false);
    isVehicle = asT<bool>(json['is_vehicle'], false);
    msg = asT<String>(json['msg'], '');
  }
}

class AppleBindModel {
  bool? result;
  String? message;
  int? code;
  bool? firstLogin;

  AppleBindModel(
      {this.result = false,
      this.message = '',
      this.code = 0,
      this.firstLogin = false});

  AppleBindModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool>(json['result'], false);
    message = asT<String>(json['message'], '');
    code = asT<int>(json['code'], 0);
    firstLogin = asT<bool>(json['first_login'], false);
  }
}
