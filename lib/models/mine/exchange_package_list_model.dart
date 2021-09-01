import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ExchangePackageListModel {
  List<ExchangePackageModel>? list;
  int? all_count;

  ExchangePackageListModel({this.all_count, this.list});

  ExchangePackageListModel.fromJson(Map<String, dynamic> json) {
    all_count = asT<int?>(json['all_count']);
    list = <ExchangePackageModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(ExchangePackageModel.fromJson(
                asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class ExchangePackageModel {
  String? bn;
  List<CardType>? card_type;
  String? deduction;
  String? goods_id;
  String? name;
  String? product_id;
  String? score;

  ExchangePackageModel({
    this.bn,
    this.card_type,
    this.deduction,
    this.goods_id,
    this.name,
    this.product_id,
    this.score,
  });

  ExchangePackageModel.fromJson(Map<String, dynamic> json) {
    bn = asT<String?>(json['bn']);
    card_type = <CardType>[];
    if (json['card_type'] != null && json['card_type'] != false) {
      (json['card_type'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            card_type
                ?.add(CardType.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    deduction = asT<String?>(json['deduction']);
    goods_id = asT<String?>(json['goods_id']);
    name = asT<String?>(json['name']);
    product_id = asT<String?>(json['product_id']);
    score = asT<String?>(json['score']);
  }
}

class CardType {
  String? logo;
  String? titile;

  CardType({this.logo, this.titile});

  CardType.fromJson(Map<String, dynamic> json) {
    logo = asT<String?>(json['log']);
    titile = asT<String?>(json['titile']);
  }
}
