import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class AddressListModel {
  List<AddressModel> list;
  AddressListModel({this.list});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    list = <AddressModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list.add(AddressModel.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
      });
    }
  }
}

class AddressModel {
  String fItemId;
  String fParentId;
  String fName;

  AddressModel({this.fItemId, this.fParentId, this.fName});

  AddressModel.fromJson(Map<String, dynamic> json) {
    fItemId = asT<String>(json['FItemId']);
    fParentId = asT<String>(json['FParentId']);
    fName = asT<String>(json['FName']);
  }
}
