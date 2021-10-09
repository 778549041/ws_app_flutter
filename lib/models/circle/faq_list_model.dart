import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class FAQListModel {
  bool? result;
  int? code;
  int? total_page;
  String? message;
  List<FAQModel>? data;

  FAQListModel(
      {this.result, this.code, this.total_page, this.message, this.data});

  FAQListModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    code = asT<int?>(json['code']);
    total_page = asT<int?>(json['total_page']);
    message = asT<String?>(json['message']);
    data = <FAQModel>[];
    if (json['data'] != null && json['data'] != false) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(FAQModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class SingleFAQModel {
  bool? result;
  int? code;
  String? message;
  FAQModel? data;

  SingleFAQModel({this.result, this.code, this.message, this.data});

  SingleFAQModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    code = asT<int?>(json['code']);
    message = asT<String?>(json['message']);
    data = FAQModel.fromJson(
        asT<Map<String, dynamic>>(json['data'], Map<String, dynamic>())!);
  }
}

class FAQModel {
  String? id; //问题id
  String? type_id; //所属标签id
  bool? is_praise; //当前用户是否已点赞
  String? content; //问题内容
  String? answers; //当前回答数
  String? praise; //点赞数
  String? member_id; //提问用户id
  String? pubtime; //提问发布时间
  bool? is_hots; //当前问题是否热门
  bool? is_oneself; //是否是自己的提问
  CommonMemberModel? member_info; //提问用户的信息
  AnswerModel? answers_info; //回答数据
  bool? answers_accept; //是否已采纳过回答

  FAQModel({
    this.id,
    this.type_id,
    this.is_praise,
    this.content,
    this.answers,
    this.praise,
    this.member_id,
    this.pubtime,
    this.is_hots,
    this.is_oneself,
    this.member_info,
    this.answers_info,
    this.answers_accept,
  });

  FAQModel.fromJson(Map<String, dynamic> json) {
    id = asT<String?>(json['id']);
    type_id = asT<String?>(json['type_id']);
    is_praise = asT<bool?>(json['is_praise']);
    content = asT<String?>(json['content']);
    answers = asT<String?>(json['answers']);
    praise = asT<String?>(json['praise']);
    member_id = asT<String?>(json['member_id']);
    pubtime = asT<String?>(json['pubtime']);
    is_hots = asT<bool?>(json['is_hots']);
    is_oneself = asT<bool?>(json['is_oneself']);
    member_info = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>?>(json['member_info'])!);
    answers_info = json['answers_info'] == null
        ? null
        : AnswerModel.fromJson(
            asT<Map<String, dynamic>?>(json['answers_info'])!);
    answers_accept = asT<bool?>(json['answers_accept']);
  }
}

class AnswerListModel {
  bool? result;
  int? code;
  int? total_page;
  String? message;
  List<AnswerModel>? data;

  AnswerListModel(
      {this.result, this.code, this.total_page, this.message, this.data});

  AnswerListModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool?>(json['result']);
    code = asT<int?>(json['code']);
    total_page = asT<int?>(json['total_page']);
    message = asT<String?>(json['message']);
    data = <AnswerModel>[];
    if (json['data'] != null && json['data'] != false) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(
                AnswerModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class AnswerModel {
  String? id; //回答id
  String? content; //回答内容
  bool? is_praise; //当前用户是否已点赞
  bool? is_accept; //回答是否被采纳
  String? praise; //回答点赞数
  String? pubtime; //回答发布时间
  String? member_id; //回答用户id
  bool? is_oneself; //是否是自己的回答
  CommonMemberModel? member_info; //回答用户信息
  bool? questionIsSelf; //该回答的提问是否是当前用户自己
  bool? questionHasAccept; //该回答的提问是否已采纳了回答

  AnswerModel({
    this.id,
    this.content,
    this.is_praise,
    this.is_accept,
    this.praise,
    this.pubtime,
    this.member_id,
    this.is_oneself,
    this.member_info,
    this.questionIsSelf,
    this.questionHasAccept,
  });

  AnswerModel.fromJson(Map<String, dynamic> json) {
    id = asT<String?>(json['id']);
    content = asT<String?>(json['content']);
    is_praise = asT<bool?>(json['is_praise']);
    is_accept = asT<bool?>(json['is_accept']);
    praise = asT<String?>(json['praise']);
    pubtime = asT<String?>(json['pubtime']);
    member_id = asT<String?>(json['member_id']);
    is_oneself = asT<bool?>(json['is_oneself']);
    member_info = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>?>(json['member_info'])!);
    questionIsSelf = false;
    questionHasAccept = false;
  }
}
