class NearStoreListModel {
  List<NearStoreModel> data;

  NearStoreListModel() : data = <NearStoreModel>[];

  NearStoreListModel.fromJson(Map<String,dynamic> json){
    data = <NearStoreModel>[];
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        data.add(NearStoreModel.fromJson(element));
      });
    }
  }
}

class NearStoreModel {
  String fSalesPhone;
  String fShopAddr;
  String fShopName;
  String fShopLat;
  String fShopLng;
  String block;
  String slow;

  NearStoreModel(
      {this.fSalesPhone,
      this.fShopAddr,
      this.fShopName,
      this.fShopLat,
      this.fShopLng,
      this.block,
      this.slow});

  NearStoreModel.fromJson(Map<String, dynamic> json) {
    fSalesPhone = json['FSalesPhone'];
    fShopAddr = json['FShopAddr'];
    fShopName = json['FShopName'];
    fShopLat = json['FShopLat'];
    fShopLng = json['FShopLng'];
    block = json['block'];
    slow = json['slow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FSalesPhone'] = this.fSalesPhone;
    data['FShopAddr'] = this.fShopAddr;
    data['FShopName'] = this.fShopName;
    data['FShopLat'] = this.fShopLat;
    data['FShopLng'] = this.fShopLng;
    data['block'] = this.block;
    data['slow'] = this.slow;
    return data;
  }
}
