class StoreListModel {
  List<StoreModel> list;
  StoreListModel({this.list});

  StoreListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <StoreModel>[];
      if (json['list'] == false) return;
      (json['list'] as List).forEach((element) {
        list.add(StoreModel.fromJson(element));
      });
    }
  }
}

class StoreModel {
  String fAppID;
  String fAdminShopName;
  StoreModel({this.fAppID, this.fAdminShopName});

  StoreModel.fromJson(Map<String, dynamic> json) {
    fAppID = json['FAppID'];
    fAdminShopName = json['FAdminShopName'];
  }
}
