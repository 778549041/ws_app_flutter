import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class LoginModel {
  String? success;
  String? error;
  String? redirect;
  LoginData? data;

  LoginModel({this.success, this.error, this.redirect}) : data = LoginData();

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = asT<String>(json['success']);
    error = asT<String>(json['error']);
    redirect = asT<String>(json['redirect']);
    data = LoginData.fromJson(
        asT<Map<String, dynamic>>(json['data'], Map<String, dynamic>())!);
  }
}

class LoginData {
  bool? firstLogin;
  LoginData({this.firstLogin});

  LoginData.fromJson(Map<String, dynamic> json) {
    firstLogin = asT<bool>(json['first_login']);
  }
}
