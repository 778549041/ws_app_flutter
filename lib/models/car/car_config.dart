import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CarConfigListModel {
  List<CarConfigModel>? data;

  CarConfigListModel() : data = <CarConfigModel>[];

  CarConfigListModel.fromJson(Map<String, dynamic> json) {
    data = <CarConfigModel>[];
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(
                CarConfigModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class CarConfigModel {
  String? conf;
  String? price;
  String? version;

  CarConfigModel(
      {this.conf = '', this.price = '', this.version = ''});

  CarConfigModel.fromJson(Map<String, dynamic> json) {
    conf = asT<String>(json['conf'], '');
    price = asT<String>(json['price'], '');
    version = asT<String>(json['version'], '');
  }
}
