import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class AddressListModel {
  List<AddressModel>? list;
  AddressListModel({this.list});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    list = <AddressModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(AddressModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class AddressModel {
  String? fItemId;
  String? fParentId;
  String? fName;
  String? provinceCode;//预约试驾参数
  String? provinceName;//预约试驾参数
  String? cityCode;//预约试驾参数
  String? cityName;//预约试驾参数

  AddressModel({this.fItemId, this.fParentId, this.fName});

  AddressModel.fromJson(Map<String, dynamic> json) {
    fItemId = asT<String>(json['FItemId']);
    fParentId = asT<String>(json['FParentId']);
    fName = asT<String>(json['FName']);
    provinceCode = asT<String>(json['provinceCode']);
    provinceName = asT<String>(json['provinceName']);
    cityCode = asT<String>(json['cityCode']);
    cityName = asT<String>(json['cityName']);
  }
}
