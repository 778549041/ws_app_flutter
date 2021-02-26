import 'package:ws_app_flutter/models/common/common_member.dart';

class NewsCommentListModel {
  List<NewsCommentModel> cmtList;
  int totalPage;

  NewsCommentListModel({this.cmtList, this.totalPage});

  NewsCommentListModel.fromJson(Map<String, dynamic> json) {
    cmtList = List<NewsCommentModel>();
    if (json['cmt_list'] != null) {
      (json['cmt_list'] as List).forEach((element) {
        cmtList.add(NewsCommentModel.fromJson(element));
      });
    }
    totalPage = json['total_page'];
  }
}

class NewsCommentModel {
  String id; //评论ID
  String avatar; //头像路径
  String content; //评论内容
  bool isSelf; //判断是否为自己的评论，true为是，false为否
  bool isOfficial; //是否官方
  String nickname; //昵称
  String praiseNum; //评论点赞数
  bool praiseStatus; //判断是否点赞，true为已点赞，false为未点赞
  String pubdate; //评论时间
  String userId; //用户ID
  bool isVehicle; //是否是车主
  CommonMemberModel memberInfo;
  List<ReplyModel> replyData; //评论回复

  NewsCommentModel(
      {this.id,
      this.avatar,
      this.content,
      this.isSelf,
      this.isOfficial,
      this.nickname,
      this.praiseNum,
      this.praiseStatus,
      this.pubdate,
      this.userId,
      this.isVehicle,
      this.memberInfo,
      this.replyData});

  NewsCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    content = json['content'];
    isSelf = json['is_self'];
    isOfficial = json['is_official'] == 'true';
    nickname = json['nickname'];
    praiseNum = json['praise_num'].toString();
    praiseStatus = json['praise_status'];
    pubdate = json['pubdate'];
    userId = json['user_id'];
    isVehicle = json['is_vehicle'] == 'true';
    memberInfo = json['member_info'] != null
        ? CommonMemberModel.fromJson(json['member_info'])
        : null;
    replyData = List<ReplyModel>();
    if (json['reply_data'] != null) {
      (json['reply_data'] as List).forEach((element) {
        replyData.add(ReplyModel.fromJson(element));
      });
    }
  }
}

class ReplyModel {
  String id; //当前评论id
  String plName; //当前评论用户昵称
  String content; //评论内容
  String replyName; //被回复人昵称
  String pid; //当前资讯id
  bool isOfficial; //是否官方

  ReplyModel(
      {this.id,
      this.plName,
      this.content,
      this.replyName,
      this.pid,
      this.isOfficial});

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plName = json['pl_name'];
    content = json['content'];
    replyName = json['reply_name'];
    pid = json['pid'];
    isOfficial = json['is_official'] == 'true';
  }
}
