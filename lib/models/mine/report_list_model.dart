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
