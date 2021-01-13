class BindModel {
  String result;
  BindData data;

  BindModel({this.result = ''}) : data = BindData();

  BindModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    data = json['data'] != null ? BindData.fromJson(json['data']) : BindData();
  }
}

class BindData {
  bool isMobile;
  bool isVehicle;
  String msg;

  BindData({this.isMobile = false, this.isVehicle = false, this.msg = ''});

  BindData.fromJson(Map<String, dynamic> json) {
    isMobile = json['is_mobile'] ?? false;
    isVehicle = json['is_vehicle'] ?? false;
    msg = json['msg'] ?? '';
  }
}

class AppleBindModel {
  bool result;
  String message;
  int code;
  bool firstLogin;

  AppleBindModel(
      {this.result = false,
      this.message = '',
      this.code = 0,
      this.firstLogin = false});

  AppleBindModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? false;
    message = json['message'] ?? '';
    code = json['code'] ?? 0;
    firstLogin = json['first_login'] ?? false;
  }
}
