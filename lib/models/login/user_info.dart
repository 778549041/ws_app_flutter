import 'package:ws_app_flutter/models/common/common_member.dart';

class UserInfo {
  int huodongData;
  Member member;
  bool memberVip;

  UserInfo({this.huodongData = 0, this.memberVip = false}) : member = Member();

  UserInfo.fromJson(Map<String, dynamic> json) {
    huodongData = json['huodong_data'] ?? 0;
    member =
        json['member'] != null ? Member.fromJson(json['member']) : Member();
    memberVip = json['member_vip'] ?? false;
  }
}

class Member {
  String nextExperience;
  String unionid;
  String fcreateDate;
  String isVehicle;
  String memberQrcode;
  bool binding;
  String nextLvDiscount;
  String experience;
  String fName;
  String memberLv;
  String memberCur;
  String bMonth;
  String localUname;
  String fLicPlate;
  String bYear;
  String fVIN;
  String lvDiscount;
  String integral;
  String fPurchaseDate;
  String fCarColor;
  String addr;
  String levelname;
  String fPhoneNum;
  String email;
  String memberId;
  String profession;
  String area;
  String isReceive;
  String uname;
  String lvIngoreExperience;
  String openid;
  String sex;
  String headImg;
  String mobile;
  String avatar;
  String memberReceive;
  String loginAccount;
  String bDay;
  String name;
  String nextLevelname;
  String isDisplay;
  String lvChannelprice;
  List<dynamic> interest;
  String regtime;
  CommonMemberModel memberInfo;

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
      this.headImg = '',
      this.integral = '',
      this.isDisplay = '',
      this.isReceive = '',
      this.isVehicle = '',
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
      this.unionid = ''})
      : memberInfo = CommonMemberModel(),
        interest = List<dynamic>();

  Member.fromJson(Map<String, dynamic> json) {
    addr = json['addr'] ?? '';
    area = json['area'] ?? '';
    avatar = json['avatar'] ?? '';
    bDay = json['b_day'] ?? '';
    bMonth = json['b_month'] ?? '';
    bYear = json['b_year'] ?? '';
    binding = json['binding'] ?? false;
    email = json['email'] ?? '';
    experience = json['experience'] ?? '';
    fCarColor = json['FCarColor'] ?? '';
    fLicPlate = json['FLicPlate'] ?? '';
    fName = json['FName'] ?? '';
    fPhoneNum = json['FPhoneNum'] ?? '';
    fPurchaseDate = json['FPurchaseDate'] ?? '';
    fVIN = json['FVIN'] ?? '';
    fcreateDate = json['fcreateDate'] ?? '';
    headImg = json['head_img'] ?? '';
    integral = json['integral'] ?? '';
    interest = json['interest'] ?? List<dynamic>();
    isDisplay = json['is_display'] ?? '';
    isReceive = json['is_receive'] ?? '';
    isVehicle = json['is_vehicle'] ?? '';
    levelname = json['levelname'] ?? '';
    localUname = json['local_uname'] ?? '';
    loginAccount = json['login_account'] ?? '';
    lvChannelprice = json['lv_channelprice'] ?? '';
    lvDiscount = json['lv_discount'] ?? '';
    lvIngoreExperience = json['lv_ingore_experience'] ?? '';
    memberCur = json['member_cur'] ?? '';
    memberId = json['member_id'] ?? '';
    memberInfo = json['member_info'] != null
        ? CommonMemberModel.fromJson(json['member_info'])
        : CommonMemberModel();
    memberLv = json['member_lv'] ?? '';
    memberQrcode = json['member_qrcode'] ?? '';
    memberReceive = json['member_receive'] ?? '';
    mobile = json['mobile'] ?? '';
    nextExperience = json['next_experience'] ?? '';
    nextLevelname = json['next_levelname'] ?? '';
    nextLvDiscount = json['next_lv_discount'] ?? '';
    openid = json['openid'] ?? '';
    profession = json['profession'] ?? '';
    regtime = json['regtime'] ?? '';
    sex = json['sex'] ?? '';
    uname = json['uname'] ?? '';
    unionid = json['unionid'] ?? '';
  }
}