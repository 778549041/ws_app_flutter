import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class MomentListModel {
  bool isLogin;
  List<MomentModel> list;
  int totalPage;

  MomentListModel({this.isLogin, this.totalPage}) : list = <MomentModel>[];

  MomentListModel.fromJson(Map<String, dynamic> json) {
    isLogin = asT<bool>(json['is_login']);
    list = <MomentModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list.add(MomentModel.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
      });
    }
    totalPage = asT<int>(json['total_page']);
  }
}

class SingleMomentModel {
  MomentModel list;

  SingleMomentModel() : list = MomentModel();

  SingleMomentModel.fromJson(Map<String, dynamic> json) {
    list = MomentModel.fromJson(
        asT<Map<String, dynamic>>(json['list'], Map<String, dynamic>()));
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
  String examine;
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
  bool onlyBottomRadius;
  String source;
  bool isInTopicPage;
  bool isDetail;

  MomentModel(
      {this.circleId,
      this.userType = 0,
      this.visitsNum = '0',
      this.hrefType = '',
      this.isGood = 'false',
      this.classify = '0',
      this.topicId = '',
      this.topicTitle = '',
      this.memberId = '',
      this.content = '',
      this.type = '',
      this.comment = '0',
      this.examine = '',
      this.praise = '0',
      this.praiseStatus = false,
      this.avatar = '',
      this.nickname = '',
      this.isSelf = false,
      this.pubtime = '',
      this.friendsRelation = 0,
      this.showAll,
      this.showAllComment,
      this.onlyBottomRadius,
      this.source,
      this.isInTopicPage,
      this.isDetail})
      : params = MomentParams(),
        memberInfo = CommonMemberModel(),
        fileList = <FileModel>[];

  MomentModel.fromJson(Map<String, dynamic> json) {
    circleId = asT<String>(json['circle_id']);
    userType = asT<int>(json['user_type']);
    visitsNum = asT<String>(json['visits_num']);
    hrefType = asT<String>(json['href_type']);
    isGood = asT<String>(json['is_good']);
    params = MomentParams.fromJson(
        asT<Map<String, dynamic>>(json['params'], Map<String, dynamic>()));
    memberInfo = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['member_info'], Map<String, dynamic>()));
    classify = asT<String>(json['classify']);
    topicId = asT<String>(json['topic_id']);
    topicTitle = asT<String>(json['topic_title'], '');
    memberId = asT<String>(json['member_id']);
    content = asT<String>(json['content'], '');
    type = asT<String>(json['type']);
    comment = asT<String>(json['comment']);
    examine = asT<String>(json['examine']);
    praise = asT<String>(json['praise'], '0');
    praiseStatus = asT<bool>(json['praise_status']);
    avatar = asT<String>(json['avatar'], '');
    nickname = asT<String>(json['nickname']);
    isSelf = asT<bool>(json['is_self']);
    fileList = <FileModel>[];
    if (json['file_list'] != null) {
      (json['file_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            fileList
                .add(FileModel.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
      });
    }
    pubtime = asT<String>(json['pubtime']);
    friendsRelation = asT<int>(json['friends_relation']);
  }
}

class MomentParams {
  String name;
  String type;
  String url;
  String detailId;

  MomentParams({this.name = '', this.type, this.url, this.detailId});

  MomentParams.fromJson(Map<String, dynamic> json) {
    name = asT<String>(json['name'], '');
    type = asT<String>(json['type']);
    url = asT<String>(json['url']);
    detailId = asT<String>(json['detail_id']);
  }
}

class FileModel {
  String savepath;

  FileModel({this.savepath});

  FileModel.fromJson(Map<String, dynamic> json) {
    savepath = asT<String>(json['savepath']);
  }
}
