import 'dart:convert';

import 'package:azlistview/azlistview.dart';
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

class AddFriendListModel {
  List<FriendMember> list;

  AddFriendListModel() : list = List<FriendMember>();

  AddFriendListModel.fromJson(Map<String, dynamic> json) {
    list = List<FriendMember>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(FriendMember.fromJson(element));
      });
    }
  }
}

class FriendListModel {
  List<FriendMember> memberList;

  FriendListModel() : memberList = List<FriendMember>();

  FriendListModel.fromJson(Map<String, dynamic> json) {
    memberList = List<FriendMember>();
    if (json['memberList'] != null) {
      (json['memberList'] as List).forEach((element) {
        memberList.add(FriendMember.fromJson(element));
      });
    }
  }
}

class FriendMember extends ISuspensionBean {
  String addr;
  String avatar;
  List<String> interest;
  bool isFriend;
  String name;
  String sex;
  String memberId;
  CommonMemberModel memberInfo;
  int friendsRelation;
  String mobile;
  String nickname;
  String groupName;

  FriendMember(
      {this.addr = '',
      this.avatar = '',
      this.isFriend = false,
      this.name = '',
      this.sex = '',
      this.memberId = '',
      this.friendsRelation = 0,
      this.mobile = '',
      this.nickname = '',
      this.groupName = ''})
      : interest = List<String>(),
        memberInfo = CommonMemberModel();

  FriendMember.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    avatar = json['avatar'] ?? '';
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
    friendsRelation = json['friends_relation'];
    mobile = json['mobile'];
    nickname = json['nickname'];
    groupName = json['init'];
  }

  @override
  String getSuspensionTag() => groupName;

  @override
  String toString() {
    return json.encode(this);
  }
}
