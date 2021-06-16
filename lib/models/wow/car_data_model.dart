import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CarDataModel {
  String code;
  String message;
  CarData datas;

  CarDataModel({this.code, this.message}) : datas = CarData();

  CarDataModel.fromJson(Map<String, dynamic> json) {
    code = asT<String>(json['code'], '');
    message = asT<String>(json['message'], '');
    datas = CarData.fromJson(
        asT<Map<String, dynamic>>(json['datas'], Map<String, dynamic>()));
  }
}

class CarData {
  CarHeader rspBody;
  String fcarColor;
  String fcarColorURL;
  String carType;

  CarData({this.fcarColor = '', this.fcarColorURL = '', this.carType})
      : rspBody = CarHeader();

  CarData.fromJson(Map<String, dynamic> json) {
    rspBody = CarHeader.fromJson(
        asT<Map<String, dynamic>>(json['rspBody'], Map<String, dynamic>()));
    fcarColor = asT<String>(json['fcarColor'], '');
    fcarColorURL = asT<String>(json['fcarColorURL'], '');
    carType = asT<String>(json['carType']);
  }
}

class CarHeader {
  int chargingStatus;
  int soc;
  int rangMileage;

  CarHeader({this.chargingStatus, this.soc = 0, this.rangMileage = 0});

  CarHeader.fromJson(Map<String, dynamic> json) {
    chargingStatus = asT<int>(json['charging_status'], 0);
    soc = asT<int>(json['SOC'], 0);
    rangMileage = asT<int>(json['rang_mileage'], 0);
  }
}
