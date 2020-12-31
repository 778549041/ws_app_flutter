class LoginModel {
  String success;
  String error;
  String redirect;
  LoginData data;

  LoginModel({this.success, this.error, this.redirect, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    redirect = json['redirect'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
}

class LoginData {
  bool firstLogin;
  LoginData({this.firstLogin});

  LoginData.fromJson(Map<String, dynamic> json) {
    firstLogin = json['first_login'];
  }
}
