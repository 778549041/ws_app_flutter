class UserInfo {
  int huodongData;
  Member member;
  bool memberVip;

  UserInfo({this.huodongData = 0, this.member, this.memberVip = false});

  UserInfo.fromJson(Map<String, dynamic> json) {
    huodongData = json['huodong_data'];
    member =
        json['member'] != null ? Member.fromJson(json['member']) : Member();
    memberVip = json['member_vip'];
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
  String interest;
  String regtime;
  MemberInfo memberInfo;

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
      this.interest = '',
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
      this.memberInfo,
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
      this.unionid = ''});

  Member.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    area = json['area'];
    avatar = json['avatar'];
    bDay = json['b_day'];
    bMonth = json['b_month'];
    bYear = json['b_year'];
    binding = json['binding'];
    email = json['email'];
    experience = json['experience'];
    fCarColor = json['FCarColor'];
    fLicPlate = json['FLicPlate'];
    fName = json['FName'];
    fPhoneNum = json['FPhoneNum'];
    fPurchaseDate = json['FPurchaseDate'];
    fVIN = json['FVIN'];
    fcreateDate = json['fcreateDate'];
    headImg = json['head_img'];
    integral = json['integral'];
    interest = json['interest'];
    isDisplay = json['is_display'];
    isReceive = json['is_receive'];
    isVehicle = json['is_vehicle'];
    levelname = json['levelname'];
    localUname = json['local_uname'];
    loginAccount = json['login_account'];
    lvChannelprice = json['lv_channelprice'];
    lvDiscount = json['lv_discount'];
    lvIngoreExperience = json['lv_ingore_experience'];
    memberCur = json['member_cur'];
    memberId = json['member_id'];
    memberInfo = json['member_nfo'] != null
        ? MemberInfo.fromJson(json['member_nfo'])
        : MemberInfo();
    memberLv = json['member_lv'];
    memberQrcode = json['member_qrcode'];
    memberReceive = json['member_receive'];
    mobile = json['mobile'];
    nextExperience = json['next_experience'];
    nextLevelname = json['next_levelname'];
    nextLvDiscount = json['next_lv_discount'];
    openid = json['openid'];
    profession = json['profession'];
    regtime = json['regtime'];
    sex = json['sex'];
    uname = json['uname'];
    unionid = json['unionid'];
  }
}

class MemberInfo {
  String memberId;
  String memberLv;
  String sex;
  String avatar;
  String nickname;
  String isVehicle;
  String isSales;
  String isOfficial;
  String userType;
  String medal;
  String isEnd;
  String hrefUrl;

  MemberInfo(
      {this.avatar = '',
      this.hrefUrl = '',
      this.isEnd = '',
      this.isOfficial = '',
      this.isSales = '',
      this.isVehicle = '',
      this.medal = '',
      this.memberId = '',
      this.memberLv = '',
      this.nickname = '',
      this.sex = '',
      this.userType = ''});

  MemberInfo.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    hrefUrl = json['href_url'];
    isEnd = json['is_end'];
    isOfficial = json['is_official'];
    isSales = json['is_sales'];
    isVehicle = json['is_vehicle'];
    medal = json['medal'];
    memberId = json['member_id'];
    memberLv = json['member_lv'];
    nickname = json['nickname'];
    sex = json['sex'];
    userType = json['user_type'];
  }
}
