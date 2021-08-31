import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class WinListModel {
  List<WinModel>? wins_list;

  WinListModel({this.wins_list});

  WinListModel.fromJson(Map<String, dynamic> json) {
    wins_list = <WinModel>[];
    if (json['wins_list'] != null && json['wins_list'] != false) {
      (json['wins_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            wins_list
                ?.add(WinModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class WinModel {
  Activity? activity;
  String? activity_id;
  int? createtime;
  int? last_modify;
  String? member_id;
  String? order_id;
  Partin? partin;
  String? partin_id;
  PrizeDetail? prize_detail;
  String? prize_id;
  String? prize_type;//奖品类型
  String? win_id;

  WinModel({
    this.activity,
    this.activity_id,
    this.createtime,
    this.last_modify,
    this.member_id,
    this.order_id,
    this.partin,
    this.partin_id,
    this.prize_detail,
    this.prize_id,
    this.prize_type,
    this.win_id,
  });

  WinModel.fromJson(Map<String, dynamic> json) {
    activity = (json['activity'] != null && json['activity'] != false)
        ? Activity.fromJson(asT<Map<String, dynamic>>(json['activity'])!)
        : null;
    activity_id = asT<String?>(json['activity_id']);
    createtime = asT<int?>(json['createtime']);
    last_modify = asT<int?>(json['last_modify']);
    member_id = asT<String?>(json['member_id']);
    order_id = asT<String?>(json['order_id']);
    partin = (json['partin'] != null && json['partin'] != false)
        ? Partin.fromJson(asT<Map<String, dynamic>>(json['partin'])!)
        : null;
    partin_id = asT<String?>(json['partin_id']);
    prize_detail = (json['prize_detail'] != null &&
            json['prize_detail'] != false)
        ? PrizeDetail.fromJson(asT<Map<String, dynamic>>(json['prize_detail'])!)
        : null;
    prize_id = asT<String?>(json['prize_id']);
    prize_type = asT<String?>(json['prize_type']);
    win_id = asT<String?>(json['win_id']);
  }
}

class Activity {
  int? from_time;
  String? title;
  int? to_time;
  int? type;

  Activity({this.from_time, this.title, this.to_time, this.type});

  Activity.fromJson(Map<String, dynamic> json) {
    from_time = asT<int?>(json['from_time']);
    title = asT<String?>(json['title']);
    to_time = asT<int?>(json['to_time']);
    type = asT<int?>(json['type']);
  }
}

class Partin {
  bool? is_win;
  int? status;

  Partin({this.is_win, this.status});

  Partin.fromJson(Map<String, dynamic> json) {
    is_win = asT<bool?>(json['is_win']);
    status = asT<int?>(json['status']);
  }
}

class PrizeDetail {
  String? name;

  PrizeDetail({this.name});

  PrizeDetail.fromJson(Map<String, dynamic> json) {
    name = asT<String?>(json['name']);
  }
}
