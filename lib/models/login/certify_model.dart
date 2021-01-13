class CertifyModel {
  bool result;
  String message;
  int code;

  CertifyModel({this.result = false, this.message = '', this.code = 0});

  CertifyModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? false;
    message = json['message'] ?? '';
    code = json['code'] ?? 0;
  }
}
