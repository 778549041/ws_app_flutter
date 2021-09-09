import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class BatteryModel {
  int? code;
  BatteryDatas? datas;
  String? message;

  BatteryModel({this.code, this.datas, this.message});

  BatteryModel.fromJson(Map<String, dynamic> json) {
    code = asT<int?>(json['code']);
    datas = (json['datas'] != null && json['datas'] != false)
        ? BatteryDatas.fromJson(asT<Map<String, dynamic>>(json['datas'])!)
        : null;
    message = asT<String?>(json['message']);
  }
}

class BatteryDatas {
  double? chargeFast; //快充占比
  double? chargeSlow; //慢充占比
  String? chargeTimeMonth; //月均充电次数
  String? comments; //行驶建议
  int? healthValue; //电池健康度
  String? milesDay; //日均行驶里程
  String? rapidAcc; //急加速次数
  String? rapidSlow; //急减速次数
  double? socCharge; //起始充电量
  String? speedAvg; //平均速度
  String? timeDay; //日均行驶时长

  BatteryDatas({
    this.chargeFast,
    this.chargeSlow,
    this.chargeTimeMonth,
    this.comments,
    this.healthValue,
    this.milesDay,
    this.rapidAcc,
    this.rapidSlow,
    this.socCharge,
    this.speedAvg,
    this.timeDay,
  });

  BatteryDatas.fromJson(Map<String, dynamic> json) {
    chargeFast = asT<double?>(json['chargeFast']);
    chargeSlow = asT<double?>(json['chargeSlow']);
    chargeTimeMonth = asT<String?>(json['chargeTimeMonth']);
    comments = asT<String?>(json['comments']);
    healthValue = asT<int?>(json['healthValue']);
    milesDay = asT<String?>(json['milesDay']);
    rapidAcc = asT<String?>(json['rapidAcc']);
    rapidSlow = asT<String?>(json['rapidSlow']);
    socCharge = asT<double?>(json['socCharge']);
    speedAvg = asT<String?>(json['speedAvg']);
    timeDay = asT<String?>(json['timeDay']);
  }
}
