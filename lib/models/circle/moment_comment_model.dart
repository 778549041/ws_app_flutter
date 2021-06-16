import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class MomentCommentListModel {
  int totalPage;
  List<MomentCommentModel> data;

  MomentCommentListModel({this.totalPage, this.data});

  MomentCommentListModel.fromJson(Map<String, dynamic> json) {
    totalPage = asT<int>(json['total_page']);
    data = <MomentCommentModel>[];
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data.add(MomentCommentModel.fromJson(
                asT<Map<String, dynamic>>(element)));
          });
        }
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
    avatar = asT<String>(json['avatar']);
    cType = asT<String>(json['c_type']);
    content = asT<String>(json['content']);
    id = asT<String>(json['id']);
    isOfficial = asT<bool>(json['is_official']);
    isSelf = asT<bool>(json['is_self']);
    isVehicle = asT<bool>(json['is_vehicle']);
    nickname = asT<String>(json['nickname']);
    praiseNum = asT<String>(json['praise_num']);
    praiseStatus = asT<bool>(json['praise_status']);
    pubdate = asT<String>(json['pubdate']);
    userId = asT<String>(json['user_id']);
    memberInfo = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['member_info'], Map<String, dynamic>()));
    replyData = <MomentCommentReplyModel>[];
    if (json['reply_data'] != null) {
      (json['reply_data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            replyData.add(MomentCommentReplyModel.fromJson(
                asT<Map<String, dynamic>>(element)));
          });
        }
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
    cType = asT<String>(json['c_type']);
    content = asT<String>(json['content']);
    id = asT<String>(json['id']);
    isOfficial = asT<bool>(json['is_official']);
    plName = asT<String>(json['pl_name']);
    replyName = asT<String>(json['reply_name']);
    pid = asT<String>(json['pid']);
  }
}
