import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class TestDriveReceive {
  bool? data;

  TestDriveReceive({this.data});

  TestDriveReceive.fromJson(Map<String, dynamic> json) {
    data = asT<bool?>(json['data']);
  }
}