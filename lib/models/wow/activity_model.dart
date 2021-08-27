import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ActivityListModel {
  List<ActivityModel>? list;
  Pager? pager;

  ActivityListModel()
      : list = <ActivityModel>[],
        pager = Pager();

  ActivityListModel.fromJson(Map<String, dynamic> json) {
    list = <ActivityModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                ActivityModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    pager = Pager.fromJson(
        asT<Map<String, dynamic>>(json['pager'], Map<String, dynamic>())!);
  }
}

class RecommendActivityListModel {
  List<ActivityModel>? data;

  RecommendActivityListModel() : data = <ActivityModel>[];

  RecommendActivityListModel.fromJson(Map<String, dynamic> json) {
    data = <ActivityModel>[];
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data?.add(
                ActivityModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class ActivityModel {
  String? id;
  bool? ifpub;
  String? memberLv;
  String? introduce;
  String? url;
  String? imageUrl;
  String? createtime;
  String? updatetime;
  String? fromTime;
  String? toTime;
  String? isHeader;
  String? apply;
  String? auth;
  String? desc;
  String? huodongId;
  String? imgUrl;
  String? isOnline;
  String? imageId;
  int? status;
  String? isPub;
  String? isVote;
  String? lastModify;
  String? limit;
  String? name;
  String? ordernum;
  String? isCustom;
  ActivityAddress? store;
  bool? isBgClear;

  ActivityModel(
      {this.apply = '',
      this.auth = '',
      this.createtime = '',
      this.desc = '',
      this.fromTime = '',
      this.huodongId = '',
      this.id = '',
      this.ifpub = false,
      this.imageId = '',
      this.imageUrl = '',
      this.imgUrl = '',
      this.introduce = '',
      this.isBgClear = false,
      this.isCustom = '',
      this.isHeader = '',
      this.isOnline = '',
      this.isPub = '',
      this.isVote = '',
      this.lastModify = '',
      this.limit = '',
      this.memberLv = '',
      this.name = '',
      this.ordernum = '',
      this.status = 0,
      this.toTime = '',
      this.updatetime = '',
      this.url = ''})
      : store = ActivityAddress();

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = asT<String>(json['id'], '');
    ifpub = asT<bool>(json['ifpub'], false);
    memberLv = asT<String>(json['member_lv'], '');
    introduce = asT<String>(json['introduce'], '');
    url = asT<String>(json['url'], '');
    imageUrl = asT<String>(json['image_url'], '');
    createtime = asT<String>(json['createtime'], '');
    updatetime = asT<String>(json['updatetime'], '');
    fromTime = asT<String>(json['from_time'], '');
    toTime = asT<String>(json['to_time'], '');
    isHeader = asT<String>(json['is_header'], '');
    apply = asT<String>(json['apply'], '');
    auth = asT<String>(json['auth'], '');
    desc = asT<String>(json['desc'], '');
    huodongId = asT<String>(json['huodong_id'], '');
    imageId = asT<String>(json['image_id'], '');
    imgUrl = asT<String>(json['img_url'], '');
    isOnline = asT<String>(json['is_online'], '');
    status = asT<int>(json['status'], 0);
    isPub = asT<String>(json['is_pub'], '');
    isVote = asT<String>(json['is_vote'], '');
    lastModify = asT<String>(json['last_modify'], '');
    limit = asT<String>(json['limit'], '');
    name = asT<String>(json['name'], '');
    ordernum = asT<String>(json['ordernum'], '');
    isCustom = asT<String>(json['is_custom'], '');
    store = (json['store'] != null && json['store'] is Map)
        ? ActivityAddress.fromJson(json['store'])
        : ActivityAddress();
    isBgClear = false;
  }
}

class Pager {
  int? total;
  String? current;
  int? token;

  Pager({this.current, this.token, this.total});

  Pager.fromJson(Map<String, dynamic> json) {
    token = asT<int>(json['token']);
    current = asT<String>(json['current']);
    total = asT<int>(json['total']);
  }
}

class ActivityAddress {
  String? address;
  String? region;
  String? lat;
  String? lng;

  ActivityAddress(
      {this.address = '', this.lat = '', this.lng = '', this.region = ''});

  ActivityAddress.fromJson(Map<String, dynamic> json) {
    address = asT<String>(json['address'], '');
    region = asT<String>(json['region'], '');
    lat = asT<String>(json['lat'], '');
    lng = asT<String>(json['lng'], '');
  }
}
