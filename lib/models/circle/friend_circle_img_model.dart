import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class FriendCircleImgListModel {
  List<FriendCircleImgModel> list;

  FriendCircleImgListModel() : list = <FriendCircleImgModel>[];

  FriendCircleImgListModel.fromJson(Map<String, dynamic> json) {
    list = <FriendCircleImgModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        tryCatch(() {
          list.add(FriendCircleImgModel.fromJson(
              asT<Map<String, dynamic>>(element)));
        });
      });
    }
  }
}

class FriendCircleImgModel {
  String savepath; //图片路径
  String type; //0:图片 1：视频

  FriendCircleImgModel(this.savepath, this.type);

  FriendCircleImgModel.fromJson(Map<String, dynamic> json) {
    savepath = asT<String>(json['savepath'], '');
    type = asT<String>(json['type'], '');
  }
}
