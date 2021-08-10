import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class NearStoreListModel {
  List<NearStoreModel>? data;

  NearStoreListModel() : data = <NearStoreModel>[];

  NearStoreListModel.fromJson(Map<String, dynamic> json) {
    data = <NearStoreModel>[];
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(
                NearStoreModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class NearStoreModel {
  String? fSalesPhone;
  String? fShopAddr;
  String? fShopName;
  String? fShopLat;
  String? fShopLng;
  String? block;
  String? slow;

  NearStoreModel(
      {this.fSalesPhone,
      this.fShopAddr,
      this.fShopName,
      this.fShopLat,
      this.fShopLng,
      this.block,
      this.slow});

  NearStoreModel.fromJson(Map<String, dynamic> json) {
    fSalesPhone = asT<String>(json['FSalesPhone'], '');
    fShopAddr = asT<String>(json['FShopAddr'], '');
    fShopName = asT<String>(json['FShopName'], '');
    fShopLat = asT<String>(json['FShopLat'], '');
    fShopLng = asT<String>(json['FShopLng'], '');
    block = asT<String>(json['block'], '');
    slow = asT<String>(json['slow'], '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FSalesPhone'] = this.fSalesPhone;
    data['FShopAddr'] = this.fShopAddr;
    data['FShopName'] = this.fShopName;
    data['FShopLat'] = this.fShopLat;
    data['FShopLng'] = this.fShopLng;
    data['block'] = this.block;
    data['slow'] = this.slow;
    return data;
  }
}
