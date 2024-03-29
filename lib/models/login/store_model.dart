import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class StoreListModel {
  List<StoreModel>? list;
  StoreListModel({this.list});

  StoreListModel.fromJson(Map<String, dynamic> json) {
    list = <StoreModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(StoreModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class StoreModel {
  String? fAppID;
  String? fAdminShopName;
  String? FShopAddr;//预约试驾参数
  String? FShopName;//预约试驾参数
  StoreModel({this.fAppID, this.fAdminShopName,this.FShopAddr,this.FShopName});

  StoreModel.fromJson(Map<String, dynamic> json) {
    fAppID = asT<String>(json['FAppID']);
    fAdminShopName = asT<String>(json['FAdminShopName']);
    FShopAddr = asT<String>(json['FShopAddr']);
    FShopName = asT<String>(json['FShopName']);
  }
}
