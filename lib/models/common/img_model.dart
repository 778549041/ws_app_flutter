import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ImgListModel {
  List<String>? data;

  ImgListModel({this.data});

  ImgListModel.fromJson(Map<String, dynamic> json) {
    data = <String>[];
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(asT<String>(element)!);
          });
        }
      });
    }
  }
}
