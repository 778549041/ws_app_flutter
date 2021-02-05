class CommonModel {
  String success;
  String error;
  String redirect;
  bool result;
  int code;
  String message;
  String imageId;

  CommonModel({this.success,this.error,this.redirect,this.result = false,this.code = 0,this.message,this.imageId});

  CommonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    redirect = json['redirect'];
    result = json['result'];
    code = json['code'];
    message = json['message'];
    imageId = json['image_id'];
  }
}