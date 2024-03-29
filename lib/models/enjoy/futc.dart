import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class FUTCModel {
  FUTCData? list;

  FUTCModel() : list = FUTCData();

  FUTCModel.fromJson(Map<String, dynamic> json) {
    list = json['list'] == null
        ? null
        : FUTCData.fromJson(asT<Map<String, dynamic>>(json['list'])!);
  }
}

class FUTCData {
  String? imageUrl;
  String? url;

  FUTCData({this.imageUrl, this.url});

  FUTCData.fromJson(Map<String, dynamic> json) {
    imageUrl = asT<String?>(json['image_url']);
    url = asT<String?>(json['url']);
  }
}
