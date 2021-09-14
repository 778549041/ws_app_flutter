import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flustars/flustars.dart';
import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class UserInfo {
  int? huodongData;
  Member? member;
  bool? memberVip;
  bool? isLogin; //是否登录

  UserInfo(
      {this.huodongData = 0,
      this.memberVip,
      this.member,
      this.isLogin = false});

  UserInfo.fromJson(Map<String, dynamic> json) {
    huodongData = asT<int?>(json['huodong_data'], 0);
    isLogin = (json['member'] == null) ? false : true;
    member = json['member'] == null
        ? null
        : Member.fromJson(asT<Map<String, dynamic>>(json['member'])!);
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

  Member.fromJson(Map<String, dynamic> jsonStr) {
    final encrypter =
        Encrypter(AES(Key.fromUtf8('98IN1S8UN3A8D951'), mode: AESMode.ecb));

    String? encryAddr = asT<String?>(jsonStr['addr']);
    addr = (encryAddr == null || encryAddr.length == 0)
        ? ''
        : encrypter.decrypt(
            Encrypted.fromBase64(Uri.decodeComponent(encryAddr)),
            iv: IV.fromLength(0));

    String? encryArea = asT<String?>(jsonStr['area']);
    area = (encryArea == null || encryArea.length == 0)
        ? ''
        : encrypter.decrypt(
            Encrypted.fromBase64(Uri.decodeComponent(encryArea)),
            iv: IV.fromLength(0));

    avatar = asT<String?>(jsonStr['avatar']);
    bDay = asT<String?>(jsonStr['b_day']);
    bMonth = asT<String?>(jsonStr['b_month']);
    bYear = asT<String?>(jsonStr['b_year']);
    binding = asT<bool?>(jsonStr['binding'], false);
    email = asT<String?>(jsonStr['email']);
    experience = asT<String?>(jsonStr['experience']);
    fCarColor = asT<String?>(jsonStr['FCarColor']);

    String? encryFLicPlate = asT<String?>(jsonStr['FLicPlate']);
    fLicPlate = (encryFLicPlate == null || encryFLicPlate.length == 0)
        ? ''
        : encrypter.decrypt(
            Encrypted.fromBase64(Uri.decodeComponent(encryFLicPlate)),
            iv: IV.fromLength(0));

    String? encryFName = asT<String?>(jsonStr['FName']);
    fName = (encryFName == null || encryFName.length == 0)
        ? ''
        : encrypter.decrypt(
            Encrypted.fromBase64(Uri.decodeComponent(encryFName)),
            iv: IV.fromLength(0));

    String? encryFPhoneNum = asT<String?>(jsonStr['FPhoneNum']);
    fPhoneNum = (encryFPhoneNum == null || encryFPhoneNum.length == 0)
        ? ''
        : encrypter.decrypt(
            Encrypted.fromBase64(Uri.decodeComponent(encryFPhoneNum)),
            iv: IV.fromLength(0));

    fPurchaseDate = asT<String?>(jsonStr['FPurchaseDate']);

    String? encryVin = asT<String?>(jsonStr['FVIN']);
    fVIN = (encryVin == null || encryVin.length == 0)
        ? ''
        : encrypter.decrypt(Encrypted.fromBase64(Uri.decodeComponent(encryVin)),
            iv: IV.fromLength(0));

    fcreateDate = asT<String?>(jsonStr['fcreateDate']);
    headImg = asT<String?>(jsonStr['head_img']);
    integral = asT<String?>(jsonStr['integral']);
    interest = <String>[];
    if (jsonStr['interest'] != null && jsonStr['interest'] != false) {
      String? encryInterest = asT<String?>(jsonStr['interest']);
      List? inteList = (encryInterest == null || encryInterest.length == 0)
          ? null
          : json.decode(encrypter.decrypt(
              Encrypted.fromBase64(Uri.decodeComponent(encryInterest)),
              iv: IV.fromLength(0)));
      if (inteList != null) {
        inteList.forEach((element) {
          tryCatch(() {
            interest?.add(asT<String>(element)!);
          });
        });
      }
    }
    isDisplay = asT<String?>(jsonStr['is_display']);
    isReceive = asT<String?>(jsonStr['is_receive']);
    isVehicle = asT<bool?>(jsonStr['is_vehicle']);
    levelname = asT<String?>(jsonStr['levelname']);
    localUname = asT<String?>(jsonStr['local_uname']);
    loginAccount = asT<String?>(jsonStr['login_account']);
    lvChannelprice = asT<String?>(jsonStr['lv_channelprice']);
    lvDiscount = asT<String?>(jsonStr['lv_discount']);
    lvIngoreExperience = asT<String?>(jsonStr['lv_ingore_experience']);
    memberCur = asT<String?>(jsonStr['member_cur']);
    memberId = asT<String?>(jsonStr['member_id']);
    memberInfo = CommonMemberModel.fromJson(asT<Map<String, dynamic>>(
        jsonStr['member_info'], Map<String, dynamic>())!);
    memberLv = asT<String?>(jsonStr['member_lv']);
    memberQrcode = asT<String?>(jsonStr['member_qrcode']);
    memberReceive = asT<String?>(jsonStr['member_receive']);

    String? encryMobile = asT<String?>(jsonStr['mobile']);
    mobile = (encryMobile == null || encryMobile.length == 0)
        ? null
        : encrypter.decrypt(
            Encrypted.fromBase64(Uri.decodeComponent(encryMobile)),
            iv: IV.fromLength(0));

    nextExperience = asT<String?>(jsonStr['next_experience']);
    nextLevelname = asT<String?>(jsonStr['next_levelname']);
    nextLvDiscount = asT<String?>(jsonStr['next_lv_discount']);
    openid = asT<String?>(jsonStr['openid']);

    String? encryProfession = asT<String?>(jsonStr['profession']);
    profession = (encryProfession == null || encryProfession.length == 0)
        ? ''
        : encrypter.decrypt(
            Encrypted.fromBase64(Uri.decodeComponent(encryProfession)),
            iv: IV.fromLength(0));

    regtime = asT<String?>(jsonStr['regtime']);
    sex = asT<String?>(jsonStr['sex']);
    uname = asT<String?>(jsonStr['uname']);
    name = asT<String?>(jsonStr['name'],'');
    unionid = asT<String?>(jsonStr['unionid']);
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
