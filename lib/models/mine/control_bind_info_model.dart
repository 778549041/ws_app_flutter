import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ControlBindInfoModel {
  bool? result;
  String? message;
  ControlBindInfoData? data;

  ControlBindInfoModel({this.message, this.result});

  ControlBindInfoModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    message = asT<String?>(json['message']);
    data = json['data'] == null
        ? null
        : ControlBindInfoData.fromJson(
            asT<Map<String, dynamic>>(json['data'])!);
  }
}

class ControlBindInfoData {
  String? name; //姓名
  String? id_card; //身份证号
  String? mobile; //手机号
  String? engine_number; //发动机号
  String? brand; //品牌型号

  ControlBindInfoData(
      {this.brand, this.engine_number, this.id_card, this.mobile, this.name});

  ControlBindInfoData.fromJson(Map<String, dynamic> json) {
    name = asT<String?>(json['name']);
    id_card = asT<String?>(json['id_card']);
    mobile = asT<String?>(json['mobile']);
    engine_number = asT<String?>(json['engine_number']);
    brand = asT<String?>(json['brand']);
  }
}
