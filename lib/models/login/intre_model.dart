import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class IntresModel {
  List<IntresData>? list;
  IntresModel() : list = <IntresData>[];

  IntresModel.fromJson(Map<String, dynamic> json) {
    list = <IntresData>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(IntresData.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class IntresData {
  String? name;
  String? interestId;
  bool? selected;

  IntresData({this.name = '', this.interestId = '', this.selected = false});

  IntresData.fromJson(Map<String, dynamic> json) {
    name = asT<String>(json['name'], '');
    interestId = asT<String>(json['interest_id'], '');
    selected = false;
  }
}
