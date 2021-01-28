class FavorModel {
  int circleNum;
  int collectionNum;

  FavorModel({this.circleNum = 0, this.collectionNum = 0});

  FavorModel.fromJson(Map<String, dynamic> json) {
    circleNum = json['circle_num'] ?? 0;
    collectionNum = json['collection_num'] ?? 0;
  }
}
