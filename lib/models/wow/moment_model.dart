import 'package:ws_app_flutter/models/common/common_member.dart';

class MomentListModel {
  bool isLogin;
  List<MomentModel> list;
  int totalPage;

  MomentListModel({this.isLogin, this.totalPage}) : list = List<MomentModel>();

  MomentListModel.fromJson(Map<String, dynamic> json) {
    isLogin = json['is_login'];
    list = List<MomentModel>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(MomentModel.fromJson(element));
      });
    }
    totalPage = json['total_page'];
  }
}

class SingleMomentModel {
  MomentModel list;

  SingleMomentModel() : list = MomentModel();

  SingleMomentModel.fromJson(Map<String, dynamic> json) {
    list = json['list'] != null
        ? MomentModel.fromJson(json['list'])
        : MomentModel();
  }
}

class MomentModel {
  String circleId;
  int userType;
  String visitsNum;
  String hrefType;
  String isGood;
  MomentParams params;
  CommonMemberModel memberInfo;
  String classify;
  String topicId;
  String topicTitle;
  String memberId;
  String content;
  String type;
  String comment;
  int examine;
  String praise;
  bool praiseStatus;
  String avatar;
  String nickname;
  bool isSelf;
  List<FileModel> fileList;
  String pubtime;
  int friendsRelation;

  bool showAll;
  bool showAllComment;
  // double rowHeight;
  // double detailRowHeight;
  // double contentHeight;
  // double imageVHeight;
  bool onlyBottomRadius;
  String source;
  bool isInTopicPage;
  bool isDetail;

  MomentModel(
      {this.circleId,
      this.userType,
      this.visitsNum,
      this.hrefType,
      this.isGood,
      this.classify,
      this.topicId,
      this.topicTitle,
      this.memberId,
      this.content,
      this.type,
      this.comment,
      this.examine,
      this.praise,
      this.praiseStatus,
      this.avatar,
      this.nickname,
      this.isSelf,
      this.pubtime,
      this.friendsRelation,
      this.showAll,
      this.showAllComment,
      this.onlyBottomRadius,
      this.source,
      this.isInTopicPage,
      this.isDetail})
      : params = MomentParams(),
        memberInfo = CommonMemberModel(),
        fileList = List<FileModel>();

  MomentModel.fromJson(Map<String, dynamic> json) {
    circleId = json['circle_id'];
    userType = json['user_type'];
    visitsNum = json['visits_num'];
    hrefType = json['href_type'];
    isGood = json['is_good'];
    params = json['params'] != null
        ? MomentParams.fromJson(json['params'])
        : MomentParams();
    memberInfo = json['member_info'] != null
        ? CommonMemberModel.fromJson(json['member_info'])
        : CommonMemberModel();
    classify = json['classify'];
    topicId = json['topic_id'];
    topicTitle = json['topic_title'];
    memberId = json['member_id'];
    content = json['content'];
    type = json['type'];
    comment = json['comment'];
    examine = json['examine'];
    praise = json['praise'];
    praiseStatus = json['praise_status'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    isSelf = json['is_self'];
    fileList = List<FileModel>();
    if (json['file_list'] != null) {
      (json['file_list'] as List).forEach((element) {
        fileList.add(FileModel.fromJson(element));
      });
    }
    pubtime = json['pubtime'];
    friendsRelation = json['friends_relation'];
  }
}

class MomentParams {
  String name;
  String type;
  String url;
  String detailId;

  MomentParams({this.name, this.type, this.url, this.detailId});

  MomentParams.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    url = json['url'];
    detailId = json['detail_id'];
  }
}

class FileModel {
  String savepath;

  FileModel({this.savepath});

  FileModel.fromJson(Map<String, dynamic> json) {
    savepath = json['savepath'];
  }
}
