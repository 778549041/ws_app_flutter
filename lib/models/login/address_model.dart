class AddressListModel {
  List<AddressModel> list;
  AddressListModel({this.list});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = List<AddressModel>();
      (json['list'] as List).forEach((element) {
        list.add(AddressModel.fromJson(element));
      });
    }
  }
}

class AddressModel {
  String fItemId;
  String fParentId;
  String fName;

  AddressModel({this.fItemId,this.fParentId,this.fName});

  AddressModel.fromJson(Map<String, dynamic> json) {
    fItemId = json['FItemId'];
    fParentId = json['FParentId'];
    fName = json['FName'];
  }
}