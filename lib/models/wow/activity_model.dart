class ActivityListModel {
  List<ActivityModel> list;
  Pager pager;

  ActivityListModel()
      : list = List<ActivityModel>(),
        pager = Pager();

  ActivityListModel.fromJson(Map<String, dynamic> json) {
    list = List<ActivityModel>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(ActivityModel.fromJson(element));
      });
    }
    pager = json['pager'] != null ? Pager.fromJson(json['pager']) : Pager();
  }
}

class RecommendActivityListModel {
  List<ActivityModel> data;

  RecommendActivityListModel() : data = List<ActivityModel>();

  RecommendActivityListModel.fromJson(Map<String, dynamic> json) {
    data = List<ActivityModel>();
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        data.add(ActivityModel.fromJson(element));
      });
    }
  }
}

class ActivityModel {
  String id;
  bool ifpub;
  String memberLv;
  String introduce;
  String url;
  String imageUrl;
  String createtime;
  String updatetime;
  String fromTime;
  String toTime;
  String isHeader;
  String apply;
  String auth;
  String desc;
  String huodongId;
  String imgUrl;
  String isOnline;
  String imageId;
  int status;
  String isPub;
  String isVote;
  String lastModify;
  String limit;
  String name;
  String ordernum;
  String isCustom;
  ActivityAddress store;
  bool isBgClear;

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
    id = json['id'] ?? '';
    ifpub = json['ifpub'] ?? false;
    memberLv = json['member_lv'] ?? '';
    introduce = json['introduce'] ?? '';
    url = json['url'] ?? '';
    imageUrl = json['image_url'] ?? '';
    createtime = json['createtime'] ?? '';
    updatetime = json['updatetime'] ?? '';
    fromTime = json['from_time'] ?? '';
    toTime = json['to_time'] ?? '';
    isHeader = json['is_header'] ?? '';
    apply = json['apply'] ?? '';
    auth = json['auth'] ?? '';
    desc = json['desc'] ?? '';
    huodongId = json['huodong_id'] ?? '';
    imageId = json['image_id'] ?? '';
    imgUrl = json['img_url'] ?? '';
    isOnline = json['is_online'] ?? '';
    status = json['status'] ?? 0;
    isPub = json['is_pub'] ?? '';
    isVote = json['is_vote'] ?? '';
    lastModify = json['last_modify'] ?? '';
    limit = json['limit'] ?? '';
    name = json['name'] ?? '';
    ordernum = json['ordernum'] ?? '';
    isCustom = json['is_custom'] ?? '';
    // store =
    //     json['store'] != null ? ActivityAddress.fromJson(json['store']) : null;
    isBgClear = false;
  }
}

class Pager {
  int total;
  int current;
  String token;

  Pager({this.current, this.token, this.total});

  Pager.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    current = json['current'];
    total = json['total'];
  }
}

class ActivityAddress {
  String address;
  String region;
  String lat;
  String lng;

  ActivityAddress(
      {this.address = '', this.lat = '', this.lng = '', this.region = ''});

  ActivityAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'] ?? '';
    region = json['region'] ?? '';
    lat = json['lat'] ?? '';
    lng = json['lng'] ?? '';
  }
}
