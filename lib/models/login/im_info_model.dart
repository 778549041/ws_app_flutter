import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class IMInfoModel {
  IMInfo? data;
  String? error;

  IMInfoModel({this.data, this.error});

  IMInfoModel.fromJson(Map<String, dynamic> json) {
    data = IMInfo.fromJson(
        asT<Map<String, dynamic>>(json['data'], Map<String, dynamic>())!);
    error = asT<String>(json['error']);
  }
}

class IMInfo {
  String? memberId;
  String? sdkappid;
  String? sig;
  String? user;

  IMInfo({this.memberId, this.sdkappid, this.sig, this.user});

  IMInfo.fromJson(Map<String, dynamic> json) {
    memberId = asT<String>(json['member_id']);
    sdkappid = asT<String>(json['sdkappid']);
    sig = asT<String>(json['sig']);
    user = asT<String>(json['user']);
  }
}
