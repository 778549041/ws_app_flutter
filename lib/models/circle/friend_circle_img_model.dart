class FriendCircleImgListModel {
  List<FriendCircleImgModel> list;

  FriendCircleImgListModel() : list = List<FriendCircleImgModel>();

  FriendCircleImgListModel.fromJson(Map<String, dynamic> json) {
    list = List<FriendCircleImgModel>();
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        list.add(FriendCircleImgModel.fromJson(element));
      });
    }
  }
}

class FriendCircleImgModel {
  String savepath; //图片路径
  String type; //0:图片 1：视频

  FriendCircleImgModel(this.savepath, this.type);

  FriendCircleImgModel.fromJson(Map<String, dynamic> json) {
    savepath = json['savepath'];
    type = json['type'];
  }
}
