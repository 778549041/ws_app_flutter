import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class TopicListModel {
  int? totalPage;
  List<TopicModel>? list;

  TopicListModel({this.totalPage = 0}) : list = <TopicModel>[];

  TopicListModel.fromJson(Map<String, dynamic> json) {
    list = <TopicModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(TopicModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    totalPage = asT<int>(json['total_page']);
  }
}

class SingleTopicodel {
  TopicModel? list;

  SingleTopicodel({this.list});

  SingleTopicodel.fromJson(Map<String, dynamic> json) {
    list = json['list'] == null
        ? null
        : TopicModel.fromJson(asT<Map<String, dynamic>>(json['list'])!);
  }
}

class TopicModel {
  String? topicId; //话题ID
  String? title; //话题标题
  String? content; //话题简介
  String? imageUrl; //封面图片地址
  String? adminUrl; //官方图片地址
  int? totalNum; //参与人数
  String? join; //圈子数量
  bool? showAll;
  bool? self; //是否是自己发的话题
  int? status; //0待审核 1通过 2拒绝
  String? follow_num; //关注数量
  int? access; //1不开放 2半开放 3全开放
  int? isJoin; //当前用户话题加入状态 0未申请 1待审核 2已通过 3已拒绝
  bool? is_follow; //当前用户是否关注 0否 1是;
  String? member_id;
  bool? hot; //是否最热
  bool? isNew; //是否最新 new
  String? pubtime; //发布时间
  String? create_time;//创建时间
  bool? can_edit; //是否可编辑
  int? examine; //话题状态,//0待审核 1审核通过 2审核不通过
  String? refuse_reason; //审核不通过理由
  CommonMemberModel? member_info; //创建者用户信息

  String? tagImg;
  bool? selected;//是否选中

  TopicModel({
    this.topicId,
    this.title,
    this.content,
    this.imageUrl,
    this.adminUrl,
    this.totalNum,
    this.join,
    this.self = false,
    this.status,
    this.follow_num,
    this.access,
    this.isJoin,
    this.is_follow,
    this.member_id,
    this.hot = false,
    this.isNew = false,
    this.pubtime,
    this.create_time,
    this.can_edit,
    this.examine,
    this.refuse_reason,
    this.member_info,
    this.showAll = false,
    this.tagImg = 'assets/images/circle/topic_mine.png',
    this.selected = false,
  });

  TopicModel.fromJson(Map<String, dynamic> json) {
    topicId = asT<String?>(json['topic_id']);
    title = asT<String?>(json['title']);
    content = asT<String?>(json['content']);
    imageUrl = asT<String?>(json['image_url']);
    adminUrl = asT<String?>(json['admin_url']);
    totalNum = asT<int?>(json['num']);
    join = asT<String?>(json['join']);
    self = json['self'] == null ? false : asT<bool?>(json['self'], false);
    status = asT<int?>(json['status']);
    follow_num = asT<String?>(json['follow_num']);
    access = asT<int?>(json['access']);
    isJoin = asT<int?>(json['isJoin']);
    is_follow = asT<bool?>(json['is_follow']);
    member_id = asT<String?>(json['member_id']);
    hot = json['hot'] == null ? false : asT<bool?>(json['hot'], false);
    isNew = json['new'] == null ? false : asT<bool?>(json['new'], false);
    pubtime = asT<String?>(json['pubtime']);
    create_time = asT<String?>(json['create_time']);
    can_edit = asT<bool?>(json['can_edit']);
    examine = asT<int?>(json['examine']);
    refuse_reason = asT<String?>(json['refuse_reason']);
    member_info = json['member_info'] == null
        ? null
        : CommonMemberModel.fromJson(
            asT<Map<String, dynamic>?>(json['member_info'])!);
    showAll = false;
    selected = false;
    if (hot!) {
      tagImg = 'assets/images/circle/topic_hot.png';
    } else if (isNew!) {
      tagImg = 'assets/images/circle/topic_new.png';
    } else {
      tagImg = 'assets/images/circle/topic_mine.png';
    }
  }
}
