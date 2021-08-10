import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ShopAddressListModel {
  List<ShopAddressModel>? list;

  ShopAddressListModel() : list = <ShopAddressModel>[];

  ShopAddressListModel.fromJson(Map<String, dynamic> json) {
    list = <ShopAddressModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                ShopAddressModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class ShopAddressModel {
  String? addr; //详细地址
  String? addrId; //id
  String? area; //省市区
  String? day; //
  String? email;
  bool? isDefault; //是否默认地址
  String? memberId;
  String? mobile; //电话
  String? name; //名字
  String? province;
  String? tel;
  String? time;
  String? updatetime;

  ShopAddressModel(
      {this.addr = '',
      this.addrId = '',
      this.area = '',
      this.day = '',
      this.email = '',
      this.isDefault = false,
      this.memberId = '',
      this.mobile = '',
      this.name = '',
      this.province = '',
      this.tel = '',
      this.time = '',
      this.updatetime = ''});

  ShopAddressModel.fromJson(Map<String, dynamic> json) {
    addr = asT<String>(json['addr'], '');
    addrId = asT<String>(json['addr_id'], '');
    area = asT<String>(json['area'], '');
    day = asT<String>(json['day'], '');
    email = asT<String>(json['email'], '');
    isDefault = asT<bool>(json['is_default']);
    memberId = asT<String>(json['member_id'], '');
    mobile = asT<String>(json['mobile'], '');
    name = asT<String>(json['name'], '');
    province = asT<String>(json['province'], '');
    tel = asT<String>(json['tel'], '');
    time = asT<String>(json['time'], '');
    updatetime = asT<String>(json['updatetime'], '');
  }
}
