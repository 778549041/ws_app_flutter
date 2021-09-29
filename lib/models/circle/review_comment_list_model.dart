import 'package:ws_app_flutter/models/circle/moment_comment_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ReviewCommentListModel {
  bool? result;
  int? code;
  int? total_page;
  List<ReviewCommentModel>? data;

  ReviewCommentListModel({this.result, this.code, this.total_page, this.data});

  ReviewCommentListModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    code = asT<int?>(json['code']);
    total_page = asT<int?>(json['total_page']);
    data = <ReviewCommentModel>[];
    if (json['data'] != null && json['data'] != false) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(ReviewCommentModel.fromJson(
                asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class ReviewCommentModel {
  String? id; //评论审核评论id
  MomentModel? circleInfo;
  CommonMemberModel? memberInfo;
  MomentCommentReplyModel? replyData;

  ReviewCommentModel(
      {this.id, this.circleInfo, this.memberInfo, this.replyData});

  ReviewCommentModel.fromJson(Map<String, dynamic> json) {
    id = asT<String?>(json['id']);
    circleInfo = json['circleInfo'] == null
        ? null
        : MomentModel.fromJson(asT<Map<String, dynamic>>(json['circleInfo'])!);
    memberInfo = json['memberInfo'] == null
        ? null
        : CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['memberInfo'])!);
    replyData = json['replyData'] == null
        ? null
        : MomentCommentReplyModel.fromJson(
        asT<Map<String, dynamic>>(json['replyData'])!);
  }
}
