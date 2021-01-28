class FUTCModel {
  FUTCData list;

  FUTCModel() : list = FUTCData();

  FUTCModel.fromJson(Map<String, dynamic> json) {
    list = json['list'] != null ? FUTCData.fromJson(json['list']) : FUTCData();
  }
}

class FUTCData {
  String imageUrl;
  String url;

  FUTCData({this.imageUrl = '', this.url = ''});

  FUTCData.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'] ?? '';
    url = json['url'] ?? '';
  }
}
