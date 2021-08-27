import 'dart:convert';

import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class SignEventResult {
  SignEventResult({
    this.data,
    this.redirect,
    this.success,
    this.error,
  });

  factory SignEventResult.fromJson(Map<String, dynamic> jsonRes) => SignEventResult(
        data: jsonRes['data'] == null
            ? null
            : SignData.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])!),
        redirect: asT<Object?>(jsonRes['redirect']),
        success: asT<String?>(jsonRes['success']),
        error: asT<String?>(jsonRes['error']),
      );

  SignData? data;
  Object? redirect;
  String? success;
  String? error;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'redirect': redirect,
        'success': success,
      };

  SignEventResult clone() =>
      SignEventResult.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class SignData {
  SignData({
    this.signinLogs,
    this.hasSignin,
  });

  factory SignData.fromJson(Map<String, dynamic> jsonRes) {
    final List<Signin_logs>? signinLogs =
        jsonRes['signin_logs'] is List ? <Signin_logs>[] : null;
    if (signinLogs != null) {
      for (final dynamic item in jsonRes['signin_logs']!) {
        if (item != null) {
          tryCatch(() {
            signinLogs
                .add(Signin_logs.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return SignData(
      signinLogs: signinLogs,
      hasSignin: asT<bool>(jsonRes['has_signin'], false),
    );
  }
  List<Signin_logs>? signinLogs;
  bool? hasSignin;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'signin_logs': signinLogs,
      };

  SignData clone() =>
      SignData.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Signin_logs {
  Signin_logs({
    this.currentDay,//当前签到日期
    this.currentMonth,
    this.currentYear,
    this.day,
    this.extfield,
    this.id,
    this.lastModify,
    this.memberId,
    this.remark,
    this.rewardsTitle,
    this.rewardsType,
    this.signTime,
    this.totalDay,
  });

  factory Signin_logs.fromJson(Map<String, dynamic> jsonRes) => Signin_logs(
        currentDay: asT<String?>(jsonRes['current_day']),
        currentMonth: asT<String?>(jsonRes['current_month']),
        currentYear: asT<String?>(jsonRes['current_year']),
        day: asT<String?>(jsonRes['day']),
        extfield: asT<String?>(jsonRes['extfield']),
        id: asT<String?>(jsonRes['id']),
        lastModify: asT<String?>(jsonRes['last_modify']),
        memberId: asT<String?>(jsonRes['member_id']),
        remark: asT<String?>(jsonRes['remark']),
        rewardsTitle: asT<String?>(jsonRes['rewards_title']),
        rewardsType: asT<String?>(jsonRes['rewards_type']),
        signTime: asT<String?>(jsonRes['sign_time']),
        totalDay: asT<String?>(jsonRes['total_day']),
      );

  String? currentDay;
  String? currentMonth;
  String? currentYear;
  String? day;
  String? extfield;
  String? id;
  String? lastModify;
  String? memberId;
  String? remark;
  String? rewardsTitle;
  String? rewardsType;
  String? signTime;
  String? totalDay;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'current_day': currentDay,
        'current_month': currentMonth,
        'current_year': currentYear,
        'day': day,
        'extfield': extfield,
        'id': id,
        'last_modify': lastModify,
        'member_id': memberId,
        'remark': remark,
        'rewards_title': rewardsTitle,
        'rewards_type': rewardsType,
        'sign_time': signTime,
        'total_day': totalDay,
      };

  Signin_logs clone() => Signin_logs.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}