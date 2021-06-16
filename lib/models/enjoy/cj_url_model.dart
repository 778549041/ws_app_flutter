import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CJUrlModel {
  String message;
  bool result;
  int code;
  CJUrlData data;

  CJUrlModel({this.message, this.result, this.code, this.data});

  CJUrlModel.fromJson(Map<String, dynamic> json) {
    message = asT<String>(json['message']);
    result = asT<bool>(json['result']);
    code = asT<int>(json['code']);
    data = CJUrlData.fromJson(
        asT<Map<String, dynamic>>(json['data'], Map<String, dynamic>()));
  }
}

class CJUrlData {
  String activityAdventuresUrl;
  String activityMachineUrl;
  String activityScratchUrl;
  String activityShakeUrl;

  CJUrlData(
      {this.activityAdventuresUrl,
      this.activityMachineUrl,
      this.activityScratchUrl,
      this.activityShakeUrl});

  CJUrlData.fromJson(Map<String, dynamic> json) {
    activityAdventuresUrl = asT<String>(json['activity_adventures_url']);
    activityMachineUrl = asT<String>(json['activity_machine_url']);
    activityScratchUrl = asT<String>(json['activity_scratch_url']);
    activityShakeUrl = asT<String>(json['activity_shake_url']);
  }
}
