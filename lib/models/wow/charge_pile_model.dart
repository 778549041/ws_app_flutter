import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ChargePileListModel {
  bool result;
  List<ChargePileInfo> list;

  ChargePileListModel({this.result, this.list});

  ChargePileListModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool>(json['result']);
    list = <ChargePileInfo>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list.add(
                ChargePileInfo.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
      });
    }
  }
}

class ChargePileInfo {
  String connectorID; //充电设备编码
  String equipmentID; //充电桩ID
  String connectorName; //充电设备接口名称
  String
      connectorType; //充电设备接口类型:1：家用插座（模式2）2：交流接口插座（模式3，连接方式B ）3：交流接口插头（带枪线，模式3，连接方式C）4：直流接口枪头（带枪线，模式4）5：无线充电座6：其他
  String voltageUpperLimits; //额定电压上限
  String voltageLowerLimits; //额定电压下限
  String current; //额定电流
  String power; //额定功率
  String parkNo; //车位号
  String nationalStandard; //国家标准 1:2011 2:2015

  ChargePileInfo.fromJson(Map<String, dynamic> json) {
    connectorID = asT<String>(json['ConnectorID']);
    equipmentID = asT<String>(json['EquipmentID']);
    connectorName = asT<String>(json['ConnectorName']);
    connectorType = asT<String>(json['ConnectorType']);
    voltageUpperLimits = asT<String>(json['VoltageUpperLimits']);
    voltageLowerLimits = asT<String>(json['VoltageLowerLimits']);
    current = asT<String>(json['Current']);
    power = asT<String>(json['Power']);
    parkNo = asT<String>(json['ParkNo']);
    nationalStandard = asT<String>(json['NationalStandard']);
  }
}
