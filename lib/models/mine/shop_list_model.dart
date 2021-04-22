class ShopAddressListModel {
  List<ShopAddressModel> list;

  ShopAddressListModel() : list = <ShopAddressModel>[];

  ShopAddressListModel.fromJson(Map<String, dynamic> json) {
    list = <ShopAddressModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        list.add(ShopAddressModel.fromJson(element));
      });
    }
  }
}

class ShopAddressModel {
  String addr; //详细地址
  String addrId; //id
  String area; //省市区
  String day; //
  String email;
  bool isDefault; //是否默认地址
  String memberId;
  String mobile; //电话
  String name; //名字
  String province;
  String tel;
  String time;
  String updatetime;

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
    addr = json['addr'] ?? '';
    addrId = json['addr_id'] ?? '';
    area = json['area'] ?? '';
    day = json['day'] ?? '';
    email = json['email'] ?? '';
    isDefault = json['is_default'] == 'true';
    memberId = json['member_id'] ?? '';
    mobile = json['mobile'] ?? '';
    name = json['name'] ?? '';
    province = json['province'] ?? '';
    tel = json['tel'] ?? '';
    time = json['time'] ?? '';
    updatetime = json['updatetime'] ?? '';
  }
}
