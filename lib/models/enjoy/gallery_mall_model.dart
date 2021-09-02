import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class GalleryMallModel {
  CarouselData? carousel;
  List<ShopModel>? data_list;
  DataScreen? data_screen;
  GalleryPager? pager;

  GalleryMallModel({
    this.carousel,
    this.data_list,
    this.data_screen,
    this.pager,
  });

  GalleryMallModel.fromJson(Map<String, dynamic> json) {
    carousel = (json['carousel'] != null && json['carousel'] != false)
        ? CarouselData.fromJson(asT<Map<String, dynamic>>(json['carousel'])!)
        : null;
    data_list = <ShopModel>[];
    if (json['data_list'] != null && json['data_list'] != false) {
      (json['data_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data_list
                ?.add(ShopModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    data_screen = (json['data_screen'] != null && json['data_screen'] != false)
        ? DataScreen.fromJson(asT<Map<String, dynamic>?>(json['data_screen'])!)
        : null;
    pager = (json['pager'] != null && json['pager'] != false)
        ? GalleryPager.fromJson(asT<Map<String, dynamic>?>(json['pager'])!)
        : null;
  }
}

class CarouselData {
  // String? carousel_id;
  // String? carousel_type;
  // int? createtime;
  // int? figure_type;
  List<CarouselItem>? items;
  // int? last_modify;
  // String? op_id;
  // String? op_name;
  // String? screen;
  // int? show_type;
  // int? status;

  CarouselData({
    // this.carousel_id,
    // this.carousel_type,
    // this.createtime,
    // this.figure_type,
    this.items,
    // this.last_modify,
    // this.op_id,
    // this.op_name,
    // this.screen,
    // this.show_type,
    // this.status,
  });

  CarouselData.fromJson(Map<String, dynamic> json) {
    // carousel_id = asT<String?>(json['carousel_id']);
    // carousel_type = asT<String?>(json['carousel_type']);
    // createtime = asT<int?>(json['createtime']);
    // figure_type = asT<int?>(json['figure_type']);
    items = <CarouselItem>[];
    if (json['items'] != null && json['items'] != false) {
      (json['items'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            items?.add(
                CarouselItem.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    // last_modify = asT<int?>(json['last_modify']);
    // op_id = asT<String?>(json['op_id']);
    // op_name = asT<String?>(json['op_name']);
    // screen = asT<String?>(json['screen']);
    // show_type = asT<int?>(json['show_type']);
    // status = asT<int?>(json['status']);
  }
}

class CarouselItem {
  // String? carousel_id;
  // String? href_type;
  // String? id;
  String? image_url;
  // String? is_header;
  bool? is_vip;
  // int? last_modify;
  // String? link;
  // String? name;
  // String? params;
  // String? title;

  CarouselItem({
    this.image_url,
    this.is_vip,
  });

  CarouselItem.fromJson(Map<String, dynamic> json) {
    image_url = asT<String?>(json['image_url']);
    is_vip = asT<bool?>(json['is_vip']);
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

class DataScreen {
  // List<ScreenBrand>? brand;
  List<ScreenCat>? cat;

  DataScreen({
    // this.brand,
    this.cat,
  });

  DataScreen.fromJson(Map<String, dynamic> json) {
    // brand = <ScreenBrand>[];
    // if (json['brand'] != null && json['brand'] != false) {
    //   (json['brand'] as List).forEach((element) {
    //     if (element != null) {
    //       tryCatch(() {
    //         brand?.add(
    //             ScreenBrand.fromJson(asT<Map<String, dynamic>>(element)!));
    //       });
    //     }
    //   });
    // }
    cat = <ScreenCat>[];
    if (json['cat'] != null && json['cat'] != false) {
      if (json['cat'] is Map) {
        (json['cat'] as Map).forEach((key, value) {
          if (value != null) {
            tryCatch(() {
              cat?.add(ScreenCat.fromJson(asT<Map<String, dynamic>>(value)!));
            });
          }
        });
      } else {
        (json['cat'] as List).forEach((element) {
          if (element != null) {
            tryCatch(() {
              cat?.add(ScreenCat.fromJson(asT<Map<String, dynamic>>(element)!));
            });
          }
        });
      }
    }
  }
}

class ScreenBrand {
  String? brand_id;
  String? brand_logo;
  String? brand_name;
  String? cat_id;
  String? goods_id;

  ScreenBrand({
    this.brand_id,
    this.brand_logo,
    this.brand_name,
    this.cat_id,
    this.goods_id,
  });
  ScreenBrand.fromJson(Map<String, dynamic> json) {
    brand_id = asT<String?>(json['brand_id']);
    brand_logo = asT<String?>(json['brand_logo']);
    brand_name = asT<String?>(json['brand_name']);
    cat_id = asT<String?>(json['cat_id']);
    goods_id = asT<String?>(json['goods_id']);
  }
}

class ScreenCat {
  String? cat_id;
  String? cat_name;

  ScreenCat({
    this.cat_id,
    this.cat_name,
  });

  ScreenCat.fromJson(Map<String, dynamic> json) {
    cat_id = asT<String?>(json['cat_id']);
    cat_name = asT<String?>(json['cat_name']);
  }
}

class GalleryPager {
  int? current;
  int? total;

  GalleryPager({this.current = 0, this.total = 0});

  GalleryPager.fromJson(Map<String, dynamic> json) {
    current = asT<int>(json['current']);
    total = asT<int>(json['total']);
  }
}
