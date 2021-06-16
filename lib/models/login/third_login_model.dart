import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ThirdLoginModel {
  ThirdLoginData data;
  ThirdLoginModel() : data = ThirdLoginData();

  ThirdLoginModel.fromJson(Map<String, dynamic> json) {
    data = ThirdLoginData.fromJson(
        asT<Map<String, dynamic>>(json['data'], Map<String, dynamic>()));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ThirdLoginData {
  String binding;
  bool wxUsed;
  bool isVehicle;
  String memberId;
  String msg;

  ThirdLoginData(
      {this.binding = '',
      this.wxUsed = false,
      this.isVehicle = false,
      this.memberId = '',
      this.msg = ''});

  ThirdLoginData.fromJson(Map<String, dynamic> json) {
    binding = asT<String>(json['binding'], '');
    wxUsed = asT<bool>(json['wx_used'], false);
    isVehicle = asT<bool>(json['is_vehicle'], false);
    memberId = asT<String>(json['member_id'], '');
    msg = asT<String>(json['msg'], '');
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['binding'] = this.binding;
    data['wx_used'] = this.wxUsed;
    data['is_vehicle'] = this.isVehicle;
    data['member_id'] = this.memberId;
    data['msg'] = this.msg;
    return data;
  }
}
