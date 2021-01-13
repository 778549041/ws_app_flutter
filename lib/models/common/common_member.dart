class CommonMemberModel {
  String avatar;
  String isOfficial;
  int isSales;
  String isVehicle;
  String memberLv;
  String nickname;
  int medal;
  int userType;
  String hrefUrl;
  bool isEnd;

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
      this.isEnd = false});

  CommonMemberModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'] ?? '';
    isOfficial = json['is_official'] ?? '';
    isSales = json['is_sales'] ?? 0;
    isVehicle = json['is_vehicle'] ?? '';
    memberLv = json['member_lv'] ?? '';
    nickname = json['nickname'] ?? '';
    medal = json['medal'] ?? 0;
    userType = json['user_type'] ?? 0;
    hrefUrl = json['href_url'] ?? '';
    isEnd = json['is_end'] ?? false;
  }
}
