class CertifyModel {
  bool result;
  String message;
  int code;

  CertifyModel({this.result,this.message,this.code});

  CertifyModel.fromJson(Map<String,dynamic> json) {
    this.result = json['result'];
    this.message = json['message'];
    this.code = json['code'];
  }
}