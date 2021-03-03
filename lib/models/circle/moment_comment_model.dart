import 'package:ws_app_flutter/models/common/common_member.dart';

class MomentCommentListModel {
  int totalPage;
  List<MomentCommentModel> data;

  MomentCommentListModel({this.totalPage, this.data});

  MomentCommentListModel.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    data = List<MomentCommentModel>();
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        data.add(MomentCommentModel.fromJson(element));
      });
    }
  }
}

class MomentCommentModel {
  String avatar; //评论用户的头像
  String cType; //0 纯文本 1 图片 2 视频
  String content; //评论内容
  String id; //评论id
  bool isOfficial; //是否是官方
  bool isSelf; //判断是否为自己，true为是，false为否
  bool isVehicle; //是否是车主
  String nickname; //评论用户的昵称
  String praiseNum; //点赞数
  bool praiseStatus; //判断用户是否给评论点赞，true已点赞，false未点赞
  String pubdate; //评论时间
  String userId; //评论用户的id
  CommonMemberModel memberInfo;
  List<MomentCommentReplyModel> replyData; //评论回复数组

  MomentCommentModel(
      {this.avatar,
      this.cType,
      this.content,
      this.id,
      this.isOfficial,
      this.isSelf,
      this.isVehicle,
      this.nickname,
      this.praiseNum,
      this.praiseStatus,
      this.pubdate,
      this.userId,
      this.memberInfo,
      this.replyData});

  MomentCommentModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    cType = json['c_type'];
    content = json['content'];
    id = json['id'];
    isOfficial = json['is_official'] == 'true';
    isSelf = json['is_self'];
    isVehicle = json['is_vehicle'] == 'true';
    nickname = json['nickname'];
    praiseNum = json['praise_num'].toString();
    praiseStatus = json['praise_status'];
    pubdate = json['pubdate'];
    userId = json['user_id'];
    memberInfo = json['member_info'] != null
        ? CommonMemberModel.fromJson(json['member_info'])
        : null;
    replyData = List<MomentCommentReplyModel>();
    if (json['reply_data'] != null) {
      (json['reply_data'] as List).forEach((element) {
        replyData.add(MomentCommentReplyModel.fromJson(element));
      });
    }
  }
}

class MomentCommentReplyModel {
  String cType; //0 纯文本 1 图片 2 视频
  String content; //评论内容
  String id; //评论id
  bool isOfficial; //是否是官方
  String plName; //当前评论用户昵称
  String replyName; //被回复人昵称
  String pid; //当前圈子id

  MomentCommentReplyModel(
      {this.cType,
      this.content,
      this.id,
      this.isOfficial,
      this.plName,
      this.replyName,
      this.pid});

  MomentCommentReplyModel.fromJson(Map<String, dynamic> json) {
    cType = json['c_type'];
    content = json['content'];
    id = json['id'];
    isOfficial = json['is_official'] == 'true';
    plName = json['pl_name'];
    replyName = json['reply_name'];
    pid = json['pid'];
  }
}
