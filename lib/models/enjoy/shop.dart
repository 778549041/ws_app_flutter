import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ShopListModel {
  List<ShopModel>? dataList;
  Pager? pager;

  ShopListModel()
      : dataList = <ShopModel>[],
        pager = Pager();

  ShopListModel.fromJson(Map<String, dynamic> json) {
    dataList = <ShopModel>[];
    if (json['data_list'] != null) {
      (json['data_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            dataList?.add(ShopModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    pager = Pager.fromJson(
        asT<Map<String, dynamic>>(json['pager'], Map<String, dynamic>())!);
  }
}

class ShopModel {
  String? deduction;
  String? integral;
  String? name;
  String? image;
  Product? product;
  bool? typeVip;

  ShopModel(
      {this.deduction = '',
      this.integral = '',
      this.name = '',
      this.image = '',
      this.typeVip = false})
      : product = Product();

  ShopModel.fromJson(Map<String, dynamic> json) {
    deduction = asT<String>(json['deduction']);
    integral = asT<String>(json['integral']);
    name = asT<String>(json['name']);
    image = asT<String>(json['image']);
    product = Product.fromJson(
        asT<Map<String, dynamic>>(json['product'], Map<String, dynamic>())!);
    typeVip = asT<bool>(json['type_vip']);
  }
}

class Product {
  String? productId;

  Product({this.productId = ''});

  Product.fromJson(Map<String, dynamic> json) {
    productId = asT<String>(json['product_id']);
  }
}

class Pager {
  int? current;
  int? total;

  Pager({this.current = 0, this.total = 0});

  Pager.fromJson(Map<String, dynamic> json) {
    current = asT<int>(json['current']);
    total = asT<int>(json['total']);
  }
}
