class CommonModel {
  String success;
  String error;
  String redirect;
  bool result;
  String code;
  String message;
  String imageId;
  bool status;
  String datas;

  CommonModel(
      {this.success,
      this.error,
      this.redirect,
      this.result = false,
      this.code,
      this.message,
      this.imageId,
      this.status,
      this.datas});

  CommonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    redirect = json['redirect'];
    result = json['result'];
    code = json['code'].toString();
    message = json['message'];
    imageId = json['image_id'];
    status = json['status'];
    datas = json['datas'];
  }
}
