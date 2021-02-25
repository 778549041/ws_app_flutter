class CJUrlModel {
  String message;
  bool result;
  int code;
  CJUrlData data;

  CJUrlModel({this.message, this.result, this.code, this.data});

  CJUrlModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result = json['result'];
    code = json['code'];
    data = json['data'] != null ? CJUrlData.fromJson(json['data']) : null;
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
    activityAdventuresUrl = json['activity_adventures_url'];
    activityMachineUrl = json['activity_machine_url'];
    activityScratchUrl = json['activity_scratch_url'];
    activityShakeUrl = json['activity_shake_url'];
  }
}
