import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class IntegralModel {
  Map? integral_list;

  IntegralModel({this.integral_list});

  IntegralModel.fromJson(Map<String, dynamic> json) {
    integral_list =
        (json['integral_list'] != null && json['integral_list'] != false)
            ? json['integral_list']
            : null;
  }
}

class IntegralList {
  List<Integral>? list;

  IntegralList({this.list});

  IntegralList.fromJson(Map<String, dynamic> json) {
    list = <Integral>[];
    if (json['list'] != null && json['list'] != false) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(Integral.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class Integral {
  String? balance; //积分总额
  String? change; //积分变更额度
  String? change_expire; //
  String? change_reason; //积分变更原因
  int? change_time; //积分变更时间
  String? id; //
  String? member_id; //用户id
  String? op_id; //
  String? op_model; //
  String? order_id; //兑换商品订单号
  String? remark; //标注

  Integral({
    this.balance,
    this.change,
    this.change_expire,
    this.change_reason,
    this.change_time,
    this.id,
    this.member_id,
    this.op_id,
    this.op_model,
    this.order_id,
    this.remark,
  });

  Integral.fromJson(Map<String, dynamic> json) {
    balance = asT<String?>(json['balance']);
    change = asT<String?>(json['change']);
    change_expire = asT<String?>(json['change_expire']);
    change_reason = asT<String?>(json['change_reason']);
    change_time = asT<int?>(json['change_time']);
    id = asT<String?>(json['id']);
    member_id = asT<String?>(json['member_id']);
    op_id = asT<String?>(json['op_id']);
    op_model = asT<String?>(json['op_model']);
    order_id = asT<String?>(json['order_id']);
    remark = asT<String?>(json['remark']);
  }
}
