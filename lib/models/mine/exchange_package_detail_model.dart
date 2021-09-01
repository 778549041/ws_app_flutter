import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ExchangePackageDetailModel {
  ExchangePackageDetailData? list;

  ExchangePackageDetailModel({this.list});

  ExchangePackageDetailModel.fromJson(Map<String, dynamic> json) {
    list = (json['list'] != null && json['list'] != false)
        ? ExchangePackageDetailData.fromJson(
            asT<Map<String, dynamic>>(json['list'])!)
        : null;
  }
}

class ExchangePackageDetailData {
  String? FActiveBeginTime;
  String? FActiveDetail;
  String? FActiveEndTime;
  String? FCardBagName;
  List<ExchangePackageCard>? card_list;
  String? score;

  ExchangePackageDetailData({
    this.FActiveBeginTime,
    this.FActiveDetail,
    this.FActiveEndTime,
    this.FCardBagName,
  });

  ExchangePackageDetailData.fromJson(Map<String, dynamic> json) {
    FActiveBeginTime = asT<String?>(json['FActiveBeginTime']);
    FActiveDetail = asT<String?>(json['FActiveDetail']);
    FActiveEndTime = asT<String?>(json['FActiveEndTime']);
    FCardBagName = asT<String?>(json['FCardBagName']);
    card_list = <ExchangePackageCard>[];
    if (json['card_list'] != null && json['card_list'] != false) {
      (json['card_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            card_list?.add(ExchangePackageCard.fromJson(
                asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    score = asT<String?>(json['score']);
  }
}

class ExchangePackageCard {
  String? FCardCount;
  String? FCardID;
  String? FLocalLogoPath;
  String? FNotice;
  String? FTitle;

  ExchangePackageCard({
    this.FCardCount,
    this.FCardID,
    this.FLocalLogoPath,
    this.FNotice,
    this.FTitle,
  });

  ExchangePackageCard.fromJson(Map<String, dynamic> json) {
    FCardCount = asT<String?>(json['FCardCount']);
    FCardID = asT<String?>(json['FCardID']);
    FLocalLogoPath = asT<String?>(json['FLocalLogoPath']);
    FNotice = asT<String?>(json['FNotice']);
    FTitle = asT<String?>(json['FTitle']);
  }
}
