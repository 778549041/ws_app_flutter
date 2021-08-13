import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class FriendModel {
  String? error;
  FriendMember? member;

  FriendModel({this.error}) : member = FriendMember();

  FriendModel.fromJson(Map<String, dynamic> json) {
    error = asT<String?>(json['error']);
    member = FriendMember.fromJson(
        asT<Map<String, dynamic>>(json['member'], Map<String, dynamic>())!);
  }
}

class AddFriendListModel {
  List<FriendMember>? list;

  AddFriendListModel() : list = <FriendMember>[];

  AddFriendListModel.fromJson(Map<String, dynamic> json) {
    list = <FriendMember>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                FriendMember.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class FriendListModel {
  List<FriendMember>? memberList;

  FriendListModel(this.memberList);

  FriendListModel.fromJson(Map<String, dynamic> json) {
    if (json['memberList'] != null) {
      memberList = <FriendMember>[];
      (json['memberList'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            memberList?.add(
                FriendMember.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class FriendMember extends ISuspensionBean {
  String? addr;
  String? avatar;
  List<String>? interest;
  bool? isFriend;
  String? name;
  String? sex;
  String? memberId;
  CommonMemberModel? memberInfo;
  int? friendsRelation;
  String? mobile;
  String? nickname;
  String? groupName;

  FriendMember(
      {this.addr,
      this.avatar,
      this.isFriend = false,
      this.name,
      this.sex,
      this.memberId,
      this.friendsRelation,
      this.mobile,
      this.nickname,
      this.groupName})
      : interest = <String>[],
        memberInfo = CommonMemberModel();

  FriendMember.fromJson(Map<String, dynamic> json) {
    addr = asT<String?>(json['addr']);
    avatar = asT<String?>(json['avatar']);
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
    isFriend = asT<bool?>(json['isFriend']);
    name = asT<String?>(json['name']);
    sex = asT<String?>(json['sex']);
    memberId = asT<String?>(json['member_id']);
    memberInfo = CommonMemberModel.fromJson(
        asT<Map<String, dynamic>>(json['member_info'], Map<String, dynamic>())!);
    friendsRelation = asT<int?>(json['friends_relation']);
    mobile = asT<String?>(json['mobile']);
    nickname = asT<String?>(json['nickname']);
    groupName = asT<String?>(json['init']);
  }

  @override
  String getSuspensionTag() => groupName!;

  @override
  String toString() {
    return json.encode(this);
  }
}
