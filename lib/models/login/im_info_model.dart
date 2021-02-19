class IMInfoModel {
  IMInfo data;
  String error;

  IMInfoModel({this.data, this.error});

  IMInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? IMInfo.fromJson(json['data']) : null;
    error = json['error'];
  }
}

class IMInfo {
  String memberId;
  String sdkappid;
  String sig;
  String user;

  IMInfo({this.memberId, this.sdkappid, this.sig, this.user});

  IMInfo.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    sdkappid = json['sdkappid'];
    sig = json['sig'];
    user = json['user'];
  }
}
