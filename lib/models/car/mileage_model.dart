import 'package:flutter/material.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class MileageListModel {
  List<MileageModel>? list;
  String? totalMileage; //总里程
  bool? receive;

  MileageListModel({this.list, this.totalMileage});

  MileageListModel.fromJson(Map<String, dynamic> json) {
    list = <MileageModel>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                MileageModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    totalMileage = asT<String?>(json['totalMileage']);
    receive = json['receive'] == null ? null : asT<bool?>(json['receive']);
  }
}

class MileageModel {
  String? addMileage; //新增里程
  String? createTime; //时间
  String? mileageDate;
  String? rewardPoints; //获取积分数
  String? status; //0待领取，1已领取，2已过期
  Color? statusColor;

  MileageModel(
      {this.addMileage,
      this.createTime,
      this.mileageDate,
      this.rewardPoints,
      this.status});

  MileageModel.fromJson(Map<String, dynamic> json) {
    addMileage = asT<String?>(json['addMileage']);
    createTime = asT<String?>(json['createTime']);
    mileageDate = asT<String?>(json['mileageDate']);
    rewardPoints = asT<String?>(json['rewardPoints']);
    var statu = asT<int?>(json['status']);
    if (statu == 0) {
      status = '待领取';
      statusColor = Color(0xFFAB2A52);
    } else if (statu == 1) {
      status = '已领取';
      statusColor = Color(0xFF84E473);
    } else if (statu == 2) {
      status = '已过期';
      statusColor = Color(0xFF999999);
    }
  }
}
