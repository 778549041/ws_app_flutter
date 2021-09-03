import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ProductDetailModel {
  Data_detail? dataDetail;
  Relgoods? relgoods;

  ProductDetailModel({
    this.dataDetail,
    this.relgoods,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> jsonRes) {
    dataDetail = jsonRes['data_detail'] == null
        ? null
        : Data_detail.fromJson(
            asT<Map<String, dynamic>>(jsonRes['data_detail'])!);
    relgoods = jsonRes['relgoods'] == null
        ? null
        : Relgoods.fromJson(asT<Map<String, dynamic>>(jsonRes['relgoods'])!);
  }
}

class Data_detail {
  String? description;
  String? explain;
  bool? isVirtual;
  String? name;
  Product? product;
  bool? typeVip;

  Data_detail({
    this.description,
    this.explain,
    this.isVirtual,
    this.name,
    this.product,
    this.typeVip,
  });

  Data_detail.fromJson(Map<String, dynamic> jsonRes) {
    description = asT<String?>(jsonRes['description']);
    explain = asT<String?>(jsonRes['explain']);
    isVirtual = asT<bool?>(jsonRes['is_virtual']);
    name = asT<String?>(jsonRes['name']);
    product = jsonRes['product'] == null
        ? null
        : Product.fromJson(asT<Map<String, dynamic>>(jsonRes['product'])!);
    typeVip = asT<bool?>(jsonRes['type_vip']);
  }
}

class Product {
  String? imageId;
  int? stock;
  String? imagePath;

  Product({
    this.imageId,
    this.stock,
    this.imagePath,
  });

  Product.fromJson(Map<String, dynamic> jsonRes) {
    imageId = asT<String?>(jsonRes['image_id']);
    stock = asT<int?>(jsonRes['stock']);
  }
}

class Relgoods {
  int? deduction;
  int? integral;

  Relgoods({
    this.deduction,
    this.integral,
  });

  Relgoods.fromJson(Map<String, dynamic> jsonRes) {
    deduction = asT<int?>(jsonRes['deduction']);
    integral = asT<int?>(jsonRes['integral']);
  }
}
