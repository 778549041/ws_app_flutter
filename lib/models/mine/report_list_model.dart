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

  ReportDetailModel({this.result, this.info});

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

  List<CheckDataItem>? neishi;
  List<CheckDataItem>? dongli;
  List<CheckDataItem>? dengguang;
  List<CheckDataItem>? yibiao;
  List<CheckDataItem>? kongtiao;
  List<CheckDataItem>? youshui;
  List<CheckDataItem>? chechuang;
  List<CheckDataItem>? yinxiang;
  List<CheckDataItem>? xuangua;

  List<ReportData>? data;
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
    this.Accelerate,
    this.ChargeAdvice,
    this.ChargeCount,
    this.Date,
    this.DcsNum,
    this.Evaluation,
    this.FNumber,
    this.FastChargeRatio,
    this.Fraction = 0,
    this.Free,
    this.HabitsAdvice,
    this.InitialCharge,
    this.Mileage,
    this.PushDate,
    this.Suggest,
    this.Timelength,
    this.Toll,
    this.VIN,
    this.neishi,
    this.dongli,
    this.dengguang,
    this.yibiao,
    this.kongtiao,
    this.youshui,
    this.chechuang,
    this.yinxiang,
    this.xuangua,
    this.data,
    this.id,
    this.member_id,
    this.name,
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

    data = <ReportData>[];
    if (json['Data'] != null && json['Data'] != false) {
      (json['Data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(ReportData.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    Map<String, dynamic>? checkData =
        asT<Map<String, dynamic>?>(json['CheckData']);

    if (checkData != null && checkData != false) {
      //内饰
      neishi = <CheckDataItem>[];
      if (checkData['neishi'] != null && checkData['neishi'] != false) {
        (checkData['neishi'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              neishi?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //动力
      dongli = <CheckDataItem>[];
      if (checkData['dongli'] != null && checkData['dongli'] != false) {
        (checkData['dongli'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              dongli?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //灯光
      dengguang = <CheckDataItem>[];
      if (checkData['dengguang'] != null && checkData['dengguang'] != false) {
        (checkData['dengguang'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              dengguang?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //仪表
      yibiao = <CheckDataItem>[];
      if (checkData['yibiao'] != null && checkData['yibiao'] != false) {
        (checkData['yibiao'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              yibiao?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //空调
      kongtiao = <CheckDataItem>[];
      if (checkData['kongtiao'] != null && checkData['kongtiao'] != false) {
        (checkData['kongtiao'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              kongtiao?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //油水检查
      youshui = <CheckDataItem>[];
      if (checkData['youshui'] != null && checkData['youshui'] != false) {
        (checkData['youshui'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              youshui?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //车窗玻璃
      chechuang = <CheckDataItem>[];
      if (checkData['chechuang'] != null && checkData['chechuang'] != false) {
        (checkData['chechuang'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              chechuang?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //音响系统
      yinxiang = <CheckDataItem>[];
      if (checkData['yinxiang'] != null && checkData['yinxiang'] != false) {
        (checkData['yinxiang'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              yinxiang?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
      //悬挂、制动
      xuangua = <CheckDataItem>[];
      if (checkData['xuangua'] != null && checkData['xuangua'] != false) {
        (checkData['xuangua'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              xuangua?.add(
                  CheckDataItem.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
    }

    id = asT<String?>(json['id']);
    member_id = asT<String?>(json['member_id']);
    name = asT<String?>(json['name']);
    pudtime = asT<int?>(json['pudtime']);
  }
}

class ReportData {
  String? CheckType;
  double? dx;
  double? dy;
  String? ItemNo;
  String? Remark;

  ReportData({this.CheckType, this.ItemNo, this.Remark, this.dx, this.dy});

  ReportData.fromJson(Map<String, dynamic> json) {
    CheckType = asT<String?>(json['CheckType']);
    String? FXY = asT<String?>(json['FXY']);
    if (FXY != null) {
      dx = double.parse(FXY.split(',')[0]);
    dy = double.parse(FXY.split(',')[1]);
    }
    ItemNo = asT<String?>(json['ItemNo']);
    Remark = asT<String?>(json['Remark']);
  }
}

class CheckDataItem {
  String? name;
  bool? value;

  CheckDataItem({this.name, this.value});

  CheckDataItem.fromJson(Map<String, dynamic> json) {
    name = asT<String?>(json['name']);
    value = asT<bool?>(json['value']);
  }
}
