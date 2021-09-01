import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ReportListModel {
  List<ReportModel>? data;

  ReportListModel({this.data});

  ReportListModel.fromJson(Map<String, dynamic> json) {
    data = <ReportModel>[];
    if (json['data'] != null && json['data'] != false) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(
                ReportModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class ReportModel {
  String? date;
  String? id;

  ReportModel({this.date, this.id});

  ReportModel.fromJson(Map<String, dynamic> json) {
    date = asT<String?>(json['Date']);
    id = asT<String?>(json['id']);
  }
}

class ReportDetailModel {
  bool? result;
  ReportInfo? info;

  ReportDetailModel({this.result}) : info = ReportInfo();

  ReportDetailModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    info = json['info'] != null
        ? ReportInfo.fromJson(asT<Map<String, dynamic>>(json['info'])!)
        : null;
  }
}

class ReportInfo {
  String? Accelerate;
  String? ChargeAdvice;
  String? ChargeCount;
  Map? checkData;
  ReportData? data;
  String? Date;
  String? DcsNum;
  String? Evaluation;
  String? FNumber;
  String? FastChargeRatio;
  int? Fraction;
  String? Free;
  String? HabitsAdvice;
  String? InitialCharge;
  String? Mileage;
  String? PushDate;
  String? Suggest;
  String? Timelength;
  String? Toll;
  String? VIN;
  String? id;
  String? member_id;
  String? name;
  int? pudtime;

  ReportInfo({
    this.Accelerate = '',
    this.ChargeAdvice = '',
    this.ChargeCount = '',
    this.Date = '',
    this.DcsNum = '',
    this.Evaluation = '',
    this.FNumber = '',
    this.FastChargeRatio = '',
    this.Fraction = 0,
    this.Free = '',
    this.HabitsAdvice = '',
    this.InitialCharge = '',
    this.Mileage = '',
    this.PushDate = '',
    this.Suggest = '',
    this.Timelength = '',
    this.Toll = '',
    this.VIN = '',
    this.checkData,
    this.data,
    this.id = '',
    this.member_id = '',
    this.name = '',
    this.pudtime = 0,
  });

  ReportInfo.fromJson(Map<String, dynamic> json) {
    Accelerate = asT<String?>(json['Accelerate']);
    ChargeAdvice = asT<String?>(json['ChargeAdvice']);
    ChargeCount = asT<String?>(json['ChargeCount']);
    Date = asT<String?>(json['Date']);
    DcsNum = asT<String?>(json['DcsNum']);
    Evaluation = asT<String?>(json['Evaluation']);
    FNumber = asT<String?>(json['FNumber']);
    FastChargeRatio = asT<String?>(json['FastChargeRatio']);
    Fraction = asT<int?>(json['Fraction']);
    Free = asT<String?>(json['Free']);
    HabitsAdvice = asT<String?>(json['HabitsAdvice']);
    InitialCharge = asT<String?>(json['InitialCharge']);
    Mileage = asT<String?>(json['Mileage']);
    PushDate = asT<String?>(json['PushDate']);
    Suggest = asT<String?>(json['Suggest']);
    Timelength = asT<String?>(json['Timelength']);
    Toll = asT<String?>(json['Toll']);
    VIN = asT<String?>(json['VIN']);
    checkData = asT<Map?>(json['CheckData']);
    id = asT<String?>(json['id']);
    member_id = asT<String?>(json['member_id']);
    name = asT<String?>(json['name']);
    pudtime = asT<int?>(json['pudtime']);
  }
}

class ReportData {
  String? CheckType;
  String? FXY;
  String? ItemNo;
  String? Remark;

  ReportData({this.CheckType, this.FXY, this.ItemNo, this.Remark});

  ReportData.fromJson(Map<String, dynamic> json) {
    CheckType = asT<String?>(json['CheckType']);
    FXY = asT<String?>(json['FXY']);
    ItemNo = asT<String?>(json['ItemNo']);
    Remark = asT<String?>(json['Remark']);
  }
}
