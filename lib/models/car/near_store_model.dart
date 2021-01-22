class NearStoreListModel {
  List<NearStoreModel> data;

  NearStoreListModel() : data = List<NearStoreModel>();

  NearStoreListModel.fromJson(Map<String,dynamic> json){
    data = List<NearStoreModel>();
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
}