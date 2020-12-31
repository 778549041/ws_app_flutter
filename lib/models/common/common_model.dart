class CommonModel {
  String success;
  String error;
  String redirect;
  bool result;
  int code;
  String message;

  CommonModel({this.success,this.error,this.redirect,this.result,this.code,this.message});

  CommonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    redirect = json['redirect'];
    result = json['result'];
    code = json['code'];
    message = json['message'];
  }
}