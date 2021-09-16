import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class MomentListModel {
  bool? isLogin;
  List<MomentModel>? list;
  int? totalPage;

  MomentListModel({this.isLogin, this.totalPage}) : list = <MomentModel>[];

  MomentListModel.fromJson(Map<String, dynamic> json) {
    isLogin = asT<bool>(json['is_login']);
    list = <MomentModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                MomentModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    totalPage = asT<int>(json['total_page']);
  }
}

class SingleMomentModel {
  MomentModel? list;

  SingleMomentModel() : list = MomentModel();

  SingleMomentModel.fromJson(Map<String, dynamic> json) {
    list = MomentModel.fromJson(
        asT<Map<String, dynamic>>(json['list'], Map<String, dynamic>())!);
  }
}

class MomentModel {
  String? circleId; //圈子ID
  int? userType; //用户账号类型,官方账号1，认证车主2，普通用户3
  String? visitsNum; //浏览量
  String? hrefType; //外连跳转方式 null：无跳转 1：h5 2：原生
  String? isGood; //是否是优质圈子
  MomentParams? params; //跳转携带参数
  CommonMemberModel? memberInfo; //用户信息
  String? classify; //是否官方 0：否 1：是
  String? topicId; //话题id
  String? topicTitle; //话题标题
  String? memberId; //发圈用户ID
  String? content; //正文内容
  String? type; //0 纯文本 1 图片 2 视频
  String? comment; //评论数
  String? examine; //是否审核通过
  String? praise; //点赞数
  bool? praiseStatus; //判断用户是否给圈子点赞，true已点赞，false未点赞
  String? avatar; //发圈用户头像
  String? nickname; //发圈用户昵称
  bool? isSelf; //判断是否为自己，true为是，false为否
  List<FileModel>? fileList; //图片路径数组
  String? pubtime; //圈子发布时间
  int? friendsRelation; //好友关系：1：未登录 2：是好友关系 3：非好友关系

  int? access; //1不开放 2半开放 3全开放
  bool? isJoin; //当前用户是否加入话题 0否 1是
  String? image_url; //官方动态封面图
  bool? canExamine; //是否有审核功能，当前用户为主理人且该圈子所属话题是当前用户创建，则显示底部审核视图
  bool? top; //是否置顶 true置顶 false未置顶
  bool? front_top; //是否前台申请置顶 0否 1是
  bool? front_good; //是否前台申请加优 0否 1是

  bool? showAll;
  bool? showAllComment;
  bool? onlyBottomRadius;
  String? source;
  bool? isInTopicPage;
  bool? isDetail;

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
      this.avatar,
      this.nickname = '',
      this.isSelf = false,
      this.pubtime = '',
      this.friendsRelation = 0,
      this.access,
      this.isJoin,
      this.image_url,
      this.canExamine,
      this.top,
      this.front_top,
      this.front_good,
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
        asT<Map<String, dynamic>>(json['params'], Map<String, dynamic>())!);
    memberInfo = CommonMemberModel.fromJson(asT<Map<String, dynamic>>(
        json['member_info'], Map<String, dynamic>())!);
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
    avatar = asT<String?>(json['avatar']);
    nickname = asT<String>(json['nickname']);
    isSelf = asT<bool>(json['is_self']);
    fileList = <FileModel>[];
    if (json['file_list'] != null) {
      (json['file_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            fileList
                ?.add(FileModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    pubtime = asT<String>(json['pubtime']);
    friendsRelation = asT<int>(json['friends_relation']);

    access = asT<int?>(json['access']);
    isJoin = asT<bool?>(json['isJoin']);
    image_url = asT<String?>(json['image_url']);
    canExamine = asT<bool?>(json['canExamine']);
    top = asT<bool?>(json['top']);
    front_top = asT<bool?>(json['front_top']);
    front_good = asT<bool?>(json['front_good']);
  }
}

class MomentParams {
  String? name;
  String? type;
  String? url;
  String? detailId;

  MomentParams({this.name = '', this.type, this.url, this.detailId});

  MomentParams.fromJson(Map<String, dynamic> json) {
    name = asT<String>(json['name'], '');
    type = asT<String>(json['type']);
    url = asT<String>(json['url']);
    detailId = asT<String>(json['detail_id']);
  }
}

class FileModel {
  String? savepath;

  FileModel({this.savepath});

  FileModel.fromJson(Map<String, dynamic> json) {
    savepath = asT<String>(json['savepath']);
  }
}
