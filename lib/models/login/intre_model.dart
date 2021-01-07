class IntresModel {
  List<IntresData> list;
  IntresModel({this.list});

  IntresModel.fromJson(Map<String, dynamic> json) {
    this.list = List<IntresData>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        this.list.add(IntresData.fromJson(element));
      });
    }
  }
}

class IntresData {
  String name;
  String interestId;
  bool selected;

  IntresData({this.name = '', this.interestId = '', this.selected = false});

  IntresData.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.interestId = json['interest_id'];
    this.selected = false;
  }
}
