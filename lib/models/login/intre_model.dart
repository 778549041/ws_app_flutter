class IntresModel {
  List<IntresData> list;
  IntresModel() : list = List<IntresData>();

  IntresModel.fromJson(Map<String, dynamic> json) {
    list = List<IntresData>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(IntresData.fromJson(element));
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
    name = json['name'] ?? '';
    interestId = json['interest_id'] ?? '';
    selected = false;
  }
}
