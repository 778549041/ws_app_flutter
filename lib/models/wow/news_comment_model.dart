import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class NewsCommentListModel {
  List<NewsCommentModel> cmtList;
  int totalPage;

  NewsCommentListModel({this.cmtList, this.totalPage});

  NewsCommentListModel.fromJson(Map<String, dynamic> json) {
    cmtList = <NewsCommentModel>[];
    if (json['cmt_list'] != null) {
      (json['cmt_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            cmtList.add(
                NewsCommentModel.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
      });
    }
    totalPage = asT<int>(json['total_page']);
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
    id = asT<String>(json['id']);
    avatar = asT<String>(json['avatar']);
    content = asT<String>(json['content']);
    isSelf = asT<bool>(json['is_self']);
    isOfficial = asT<bool>(json['is_official']);
    nickname = asT<String>(json['nickname']);
    praiseNum = asT<String>(json['praise_num']);
    praiseStatus = asT<bool>(json['praise_status']);
    pubdate = asT<String>(json['pubdate']);
    userId = asT<String>(json['user_id']);
    isVehicle = asT<bool>(json['is_vehicle']);
    memberInfo = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['member_info'], Map<String, dynamic>()));
    replyData = <ReplyModel>[];
    if (json['reply_data'] != null) {
      (json['reply_data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            replyData
                .add(ReplyModel.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
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
    id = asT<String>(json['id']);
    plName = asT<String>(json['pl_name']);
    content = asT<String>(json['content']);
    replyName = asT<String>(json['reply_name']);
    pid = asT<String>(json['pid']);
    isOfficial = asT<bool>(json['is_official']);
  }
}
