import 'package:flustars/flustars.dart';
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
  String?
      change_reason; //积分变更原因,mileage里程奖励，else其他，like评论点赞，charge充电，sign签到奖励，circle发布动态，counselShare分享，endurance_challenge活动奖励，media赠送，recharge充值，grant赠予，wsparty活动签到，newpeople新人礼包，information完善资料，carer车主认证，wechat微信绑定，register注册，order商品兑换，deduction抵扣，luckybag集五福赢大奖，
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
    int? point = asT<int?>(json['change']);
    if (point! > 0) {
      change = '+' + TextUtil.formatComma3(point);
    } else {
      change = '-' + TextUtil.formatComma3(point.abs());
    }
    change_expire = asT<String?>(json['change_expire']);
    String? change_type = asT<String?>(json['change_reason']);
    change_reason = convertReason(change_type!);
    change_time = asT<int?>(json['change_time']);
    id = asT<String?>(json['id']);
    member_id = asT<String?>(json['member_id']);
    op_id = asT<String?>(json['op_id']);
    op_model = asT<String?>(json['op_model']);
    order_id = asT<String?>(json['order_id']);
    remark = asT<String?>(json['remark']);
  }

  String convertReason(String type) {
    if (type == 'mileage') {
      return '里程奖励';
    } else if (type == 'else') {
      return '其他';
    } else if (type == 'like') {
      return '评论点赞';
    } else if (type == 'charge') {
      return '充电';
    } else if (type == 'sign') {
      return '签到奖励';
    } else if (type == 'circle') {
      return '发布动态';
    } else if (type == 'counselShare') {
      return '分享';
    } else if (type == 'endurance_challenge') {
      return '活动奖励';
    } else if (type == 'media') {
      return '赠送';
    } else if (type == 'recharge') {
      return '充值';
    } else if (type == 'grant') {
      return '赠予';
    } else if (type == 'wsparty') {
      return '活动签到';
    } else if (type == 'newpeople') {
      return '新人礼包';
    } else if (type == 'information') {
      return '完善资料';
    } else if (type == 'carer') {
      return '车主认证';
    } else if (type == 'wechat') {
      return '微信绑定';
    } else if (type == 'register') {
      return '注册';
    } else if (type == 'order') {
      return '商品兑换';
    } else if (type == 'deduction') {
      return '抵扣';
    } else if (type == 'luckybag') {
      return '集五福赢大奖';
    } else {
      return '';
    }
  }
}
