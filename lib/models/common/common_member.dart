import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CommonMemberModel {
  String? avatar;
  String? isOfficial;
  int? isSales;
  String? isVehicle;
  String? memberLv;
  String? nickname;
  int? medal;
  int? userType;
  String? hrefUrl;
  int? isEnd;
  int? vehicleControlBind; //是否绑定车控功能
  int? vehicleControlPin; //是否设置了pin码
  int? isVehicleControl; //是否有车控功能
  String? memberIdStr; //加密的用户id字符串
  String? medalOrSaleImageName; //销售员或者勋章标签图标
  String? medalOrSaleDescImageName; //销售员或者勋章详情图片
  bool? showTag; //是否展示标签

  CommonMemberModel(
      {this.avatar = '',
      this.isOfficial = '',
      this.isSales = 0,
      this.isVehicle = '',
      this.memberLv = '',
      this.nickname = '',
      this.medal = 0,
      this.userType = 0,
      this.hrefUrl = '',
      this.isEnd = 0,
      this.vehicleControlBind = 0,
      this.vehicleControlPin = 0,
      this.isVehicleControl = 0,
      this.memberIdStr = '',
      this.medalOrSaleImageName = 'assets/images/mine/sales_tag_small.png',
      this.medalOrSaleDescImageName = 'assets/images/mine/sales_tag_big.png',
      this.showTag = false});

  CommonMemberModel.fromJson(Map<String, dynamic> json) {
    avatar = asT<String>(json['avatar'], '');
    isOfficial = asT<String>(json['is_official'], '');
    isSales = asT<int>(json['is_sales'], 0);
    isVehicle = asT<String>(json['is_vehicle'], '');
    memberLv = asT<String>(json['member_lv'], '');
    nickname = asT<String>(json['nickname'], '');
    medal = asT<int>(json['medal'], 0);
    userType = asT<int>(json['user_type'], 0);
    hrefUrl = asT<String>(json['href_url'], '');
    isEnd = asT<int>(json['is_end'], 0);
    vehicleControlBind = asT<int>(json['vehicle_control_bind'], 0);
    vehicleControlPin = asT<int>(json['vehicle_control_pin'], 0);
    isVehicleControl = asT<int>(json['is_vehicle_control'], 0);
    memberIdStr = asT<String>(json['member_id_str'], '');
    medalOrSaleImageName = _getMedalOrSaleImageName();
    medalOrSaleDescImageName = _getMedalOrSaleDescImageName();
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

  bool _getShowTag() {
    return (this.isSales == 1 || this.medal! > 0);
  }
}
