import 'package:flustars/flustars.dart';
import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class UserInfo {
  int? huodongData;
  Member? member;
  bool? memberVip;

  UserInfo({this.huodongData = 0, this.memberVip = false,this.member});

  UserInfo.fromJson(Map<String, dynamic> json) {
    huodongData = asT<int?>(json['huodong_data']);
    member = json['member'] == null ? null : Member.fromJson(
        asT<Map<String, dynamic>>(json['member'])!);
    memberVip = asT<bool?>(json['member_vip']);
  }
}

class Member {
  String? nextExperience;
  String? unionid;
  String? fcreateDate;
  bool? isVehicle;
  String? memberQrcode;
  bool? binding;
  String? nextLvDiscount;
  String? experience;
  String? fName;
  String? memberLv;
  String? memberCur;
  String? bMonth;
  String? localUname;
  String? fLicPlate;
  String? bYear;
  String? fVIN;
  String? lvDiscount;
  String? integral;
  String? fPurchaseDate;
  String? fCarColor;
  String? addr;
  String? levelname;
  String? fPhoneNum;
  String? email;
  String? memberId;
  String? profession;
  String? area;
  String? isReceive;
  String? uname;
  String? lvIngoreExperience;
  String? openid;
  String? sex;
  String? headImg;
  String? mobile;
  String? avatar;
  String? memberReceive;
  String? loginAccount;
  String? bDay;
  String? name;
  String? nextLevelname;
  String? isDisplay;
  String? lvChannelprice;
  List<String>? interest;
  String? regtime;
  CommonMemberModel? memberInfo;
  String? showName;

  Member(
      {this.addr = '',
      this.area = '',
      this.avatar = '',
      this.bDay = '',
      this.bMonth = '',
      this.bYear = '',
      this.binding = false,
      this.email = '',
      this.experience = '',
      this.fCarColor = '',
      this.fLicPlate = '',
      this.fName = '',
      this.fPhoneNum = '',
      this.fPurchaseDate = '',
      this.fVIN = '',
      this.fcreateDate = '',
      this.headImg,
      this.integral = '',
      this.isDisplay = '',
      this.isReceive = '',
      this.isVehicle = false,
      this.levelname = '',
      this.localUname = '',
      this.loginAccount = '',
      this.lvChannelprice = '',
      this.lvDiscount = '',
      this.lvIngoreExperience = '',
      this.memberCur = '',
      this.memberId = '',
      this.memberLv = '',
      this.memberQrcode = '',
      this.memberReceive = '',
      this.mobile = '',
      this.name = '',
      this.nextExperience = '',
      this.nextLevelname = '',
      this.nextLvDiscount = '',
      this.openid = '',
      this.profession = '',
      this.regtime = '',
      this.sex = '',
      this.uname = '',
      this.unionid = '',
      this.showName = ''})
      : memberInfo = CommonMemberModel(),
        interest = <String>[];

  Member.fromJson(Map<String, dynamic> json) {
    addr = asT<String?>(json['addr']);
    area = asT<String?>(json['area']);
    avatar = asT<String?>(json['avatar']);
    bDay = asT<String?>(json['b_day']);
    bMonth = asT<String?>(json['b_month']);
    bYear = asT<String?>(json['b_year']);
    binding = asT<bool?>(json['binding'], false);
    email = asT<String?>(json['email']);
    experience = asT<String?>(json['experience']);
    fCarColor = asT<String?>(json['FCarColor']);
    fLicPlate = asT<String?>(json['FLicPlate']);
    fName = asT<String?>(json['FName']);
    fPhoneNum = asT<String?>(json['FPhoneNum']);
    fPurchaseDate = asT<String?>(json['FPurchaseDate']);
    fVIN = asT<String?>(json['FVIN']);
    fcreateDate = asT<String?>(json['fcreateDate']);
    headImg = asT<String?>(json['head_img']);
    integral = asT<String?>(json['integral']);
    interest = <String>[];
    if (json['interest'] != null) {
      (json['interest'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            interest?.add(asT<String>(element)!);
          });
        }
      });
    }
    isDisplay = asT<String?>(json['is_display']);
    isReceive = asT<String?>(json['is_receive']);
    isVehicle = asT<bool?>(json['is_vehicle']);
    levelname = asT<String?>(json['levelname']);
    localUname = asT<String?>(json['local_uname']);
    loginAccount = asT<String?>(json['login_account']);
    lvChannelprice = asT<String?>(json['lv_channelprice']);
    lvDiscount = asT<String?>(json['lv_discount']);
    lvIngoreExperience = asT<String?>(json['lv_ingore_experience']);
    memberCur = asT<String?>(json['member_cur']);
    memberId = asT<String?>(json['member_id']);
    memberInfo = CommonMemberModel.fromJson(asT<Map<String, dynamic>>(
        json['member_info'], Map<String, dynamic>())!);
    memberLv = asT<String?>(json['member_lv']);
    memberQrcode = asT<String?>(json['member_qrcode']);
    memberReceive = asT<String?>(json['member_receive']);
    mobile = asT<String?>(json['mobile']);
    nextExperience = asT<String?>(json['next_experience']);
    nextLevelname = asT<String?>(json['next_levelname']);
    nextLvDiscount = asT<String?>(json['next_lv_discount']);
    openid = asT<String?>(json['openid']);
    profession = asT<String?>(json['profession']);
    regtime = asT<String?>(json['regtime']);
    sex = asT<String?>(json['sex']);
    uname = asT<String?>(json['uname']);
    name = asT<String?>(json['name']);
    unionid = asT<String?>(json['unionid']);
    showName = _showName();
  }

  String _showName() {
    String _showName = (name != null && name!.length > 0)
        ? name!
        : (mobile != null && mobile!.length > 0)
            ? mobile!
            : '';
    if (RegexUtil.isMobileExact(_showName)) {
      _showName = _showName.replaceFirst(RegExp(r'\d{4}'), '****', 3);
    }
    return _showName;
  }
}
