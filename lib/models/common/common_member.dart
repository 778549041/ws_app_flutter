import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CommonMemberModel {
  String? avatar; //头像
  bool? isOfficial; //是否官方 0：否 1：是
  bool? isSales; //是否销售员 0：否 1：是
  bool? isVehicle; //是否车主 0：否 1：是
  String? memberLv; //用户等级
  String? memberId; //用户id
  String? nickname; //用户昵称
  String? name;
  int? medal; //勋章
  int? userType; //用户账号类型,官方账号1，认证车主2，普通用户3
  String? hrefUrl; //老友记地址
  bool? isEnd; //活动是否结束 1为结束
  bool? vehicleControlBind; //是否绑定车控功能
  bool? vehicleControlPin; //是否设置了pin码
  bool? isVehicleControl; //是否有车控功能
  String? memberIdStr; //加密的用户id字符串
  String? FVINStr; //加密车架号
  String? mobileStr; //加密手机号
  int? goldenFootMedal; //黄金右脚勋章
  bool? isLeader; //是否是主理人

  String? medalOrSaleImageName; //销售员或者勋章标签图标
  String? medalOrSaleDescImageName; //销售员或者勋章详情图片
  bool? showTag; //是否展示标签

  String? xhMdealImgName; //黄金右脚勋章标签图标
  String? xhMedalDescImgName; //黄金右脚弹框图片

  CommonMemberModel({
    this.avatar = '',
    this.isOfficial = false,
    this.isSales = false,
    this.isVehicle = false,
    this.memberLv = '',
    this.memberId = '',
    this.nickname = '',
    this.name = '',
    this.medal = 0,
    this.userType = 0,
    this.hrefUrl = '',
    this.isEnd = false,
    this.vehicleControlBind = false,
    this.vehicleControlPin = false,
    this.isVehicleControl = false,
    this.memberIdStr = '',
    this.FVINStr = '',
    this.mobileStr = '',
    this.goldenFootMedal = 0,
    this.isLeader = false,
    this.medalOrSaleImageName = 'assets/images/mine/sales_tag_small.png',
    this.medalOrSaleDescImageName = 'assets/images/mine/sales_tag_big.png',
    this.showTag = false,
    this.xhMdealImgName = '',
    this.xhMedalDescImgName = '',
  });

  CommonMemberModel.fromJson(Map<String, dynamic> json) {
    avatar = asT<String?>(json['avatar']);
    isOfficial = asT<bool?>(json['is_official']);
    isSales = asT<bool?>(json['is_sales']);
    isVehicle = asT<bool?>(json['is_vehicle']);
    memberLv = asT<String?>(json['member_lv']);
    memberId = asT<String?>(json['member_id']);
    nickname = asT<String?>(json['nickname']);
    name = asT<String?>(json['name']);
    medal = asT<int?>(json['medal'],0);
    userType = asT<int?>(json['user_type']);
    hrefUrl = asT<String?>(json['href_url']);
    isEnd = asT<bool?>(json['is_end']);
    vehicleControlBind = asT<bool?>(json['vehicle_control_bind']);
    vehicleControlPin = asT<bool?>(json['vehicle_control_pin']);
    isVehicleControl = asT<bool?>(json['is_vehicle_control']);
    memberIdStr = asT<String?>(json['member_id_str']);
    FVINStr = asT<String?>(json['FVIN_str']);
    mobileStr = asT<String?>(json['mobile_str']);
    goldenFootMedal = asT<int?>(json['golden_foot_medal']);
    isLeader = asT<bool?>(json['is_leader']);
    medalOrSaleImageName = _getMedalOrSaleImageName();
    medalOrSaleDescImageName = _getMedalOrSaleDescImageName();
    xhMdealImgName = _getXHMedalImgName();
    xhMedalDescImgName = _getXHMedalDescImgName();
    showTag = _getShowTag();
  }

  String _getMedalOrSaleImageName() {
    String _imageName = '';
    if (this.isSales == 1) {
      _imageName = 'assets/images/mine/sales_tag_small.png';
    } else if (this.medal == 1) {
      _imageName = 'assets/images/mine/icon_medal_normal.png';
    } else if (this.medal == 2) {
      _imageName = 'assets/images/mine/icon_medal_gold.png';
    } else if (this.medal == 3) {
      _imageName = 'assets/images/mine/icon_medal_platina.png';
    } else if (this.medal == 4) {
      _imageName = 'assets/images/mine/icon_medal_diamond.png';
    }
    return _imageName;
  }

  String _getMedalOrSaleDescImageName() {
    String medalOrSaleDescImageName = '';
    if (this.isSales == 1) {
      medalOrSaleDescImageName = "assets/images/mine/sales_tag_big.png";
    } else if (this.medal == 1) {
      medalOrSaleDescImageName = "assets/images/mine/medal_normal_desc.jpg";
    } else if (this.medal == 2) {
      medalOrSaleDescImageName = "assets/images/mine/medal_gold_desc.jpg";
    } else if (this.medal == 3) {
      medalOrSaleDescImageName = "assets/images/mine/medal_platina_desc.jpg";
    } else if (this.medal == 4) {
      medalOrSaleDescImageName = "assets/images/mine/medal_diamond_desc.jpg";
    }
    return medalOrSaleDescImageName;
  }

  String _getXHMedalImgName() {
    String img = '';
    if (this.goldenFootMedal == 1) {
        img = 'assets/images/mine/gold_foot_first.png';
    } else if (this.goldenFootMedal == 2) {
        img = 'assets/images/mine/gold_foot_second.png';
    } else if (this.goldenFootMedal == 3) {
        img = 'gold_foot_third';
    }
    return img;
  }

  String _getXHMedalDescImgName() {
    String img = '';
    if (this.goldenFootMedal == 1) {
        img = 'assets/images/mine/gold_foot_desc_first.png';
    } else if (this.goldenFootMedal == 2) {
        img = 'assets/images/mine/gold_foot_desc_second.png';
    } else if (this.goldenFootMedal == 3) {
        img = 'assets/images/mine/gold_foot_desc_third.png';
    }
    return img;
  }

  bool _getShowTag() {
    return (this.isSales == 1 || (this.medal != null && this.medal! > 0));
  }
}
