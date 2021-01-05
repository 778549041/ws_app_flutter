class BindModel {
  String result;
  BindData data;

  BindModel({this.result, this.data});

  BindModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ? BindData.fromJson(json['data']) : null;
  }
}

class BindData {
  bool isMobile;
  bool isVehicle;
  String msg;

  BindData({this.isMobile, this.isVehicle, this.msg});

  BindData.fromJson(Map<String, dynamic> json) {
    isMobile = json['is_mobile'];
    isVehicle = json['is_vehicle'];
    msg = json['msg'];
  }
}

class AppleBindModel {
  bool result;
  String message;
  int code;
  bool firstLogin;

  AppleBindModel({this.result, this.message, this.code, this.firstLogin});

  AppleBindModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    code = json['code'];
    firstLogin = json['firs_login'];
  }
}
