import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class PackageListModel {
  List<PackageModel>? list;

  PackageListModel({this.list});

  PackageListModel.fromJson(Map<String, dynamic> json) {
    list = <PackageModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                PackageModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class PackageModel {
  String? FCardBagName;
  String? bn;
  List<CardName>? cardname;
  String? createtime;
  String? order_id;
  int? status;
  String? store;

  PackageModel({
    this.FCardBagName,
    this.bn,
    this.cardname,
    this.createtime,
    this.order_id,
    this.status,
    this.store,
  });

  PackageModel.fromJson(Map<String, dynamic> json) {
    FCardBagName = asT<String?>(json['FCardBagName']);
    bn = asT<String?>(json['bn']);
    cardname = <CardName>[];
    if (json['cardname'] != null && json['cardname'] != false) {
      (json['cardname'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            cardname
                ?.add(CardName.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    createtime = asT<String?>(json['createtime']);
    order_id = asT<String?>(json['order_id']);
    status = asT<int?>(json['status']);
    store = asT<String?>(json['store']);
  }
}

class CardName {
  String? FEVCardID;
  String? FEndDate;
  String? FLocalLogoPath;
  String? FPutAppID;
  String? FTitle;
  String? savepath;

  CardName({
    this.FEVCardID,
    this.FEndDate,
    this.FLocalLogoPath,
    this.FPutAppID,
    this.FTitle,
    this.savepath,
  });

  CardName.fromJson(Map<String, dynamic> json) {
    FEVCardID = asT<String?>(json['FEVCardID']);
    FEndDate = asT<String?>(json['FEndDate']);
    FLocalLogoPath = asT<String?>(json['FLocalLogoPath']);
    FPutAppID = asT<String?>(json['FPutAppID']);
    FTitle = asT<String?>(json['FTitle']);
    savepath = asT<String?>(json['savepath']);
  }
}
