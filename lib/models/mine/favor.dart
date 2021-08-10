import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class FavorModel {
  int? circleNum;
  int? collectionNum;

  FavorModel({this.circleNum = 0, this.collectionNum = 0});

  FavorModel.fromJson(Map<String, dynamic> json) {
    circleNum = asT<int>(json['circle_num'], 0);
    collectionNum = asT<int>(json['collection_num'], 0);
  }
}
