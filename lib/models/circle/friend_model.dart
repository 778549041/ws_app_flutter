import 'package:ws_app_flutter/models/common/common_member.dart';

class FriendModel {
  String error;
  FriendMember member;

  FriendModel({this.error}) : member = FriendMember();

  FriendModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    member = json['member'] != null
        ? FriendMember.fromJson(json['member'])
        : FriendMember();
  }
}

class FriendMember {
  String addr;
  String avatar;
  List<String> interest;
  bool isFriend;
  String name;
  String sex;
  String memberId;
  CommonMemberModel memberInfo;

  FriendMember(
      {this.addr = '',
      this.avatar = '',
      this.isFriend = false,
      this.name = '',
      this.sex = '',
      this.memberId = ''})
      : interest = List<String>(),
        memberInfo = CommonMemberModel();

  FriendMember.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    avatar = json['avatar'];
    interest = List<String>();
    if (json['interest'] != null) {
      (json['interest'] as List).forEach((element) {
        interest.add(element);
      });
    }
    isFriend = json['isFriend'];
    name = json['name'];
    sex = json['sex'];
    memberId = json['member_id'];
    memberInfo = json['member_info'] != null
        ? CommonMemberModel.fromJson(json['member_info'])
        : CommonMemberModel();
  }
}
