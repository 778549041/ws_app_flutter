import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class OrderListModel {
  Map? orderItemsGroup;
  List<OrderModel>? orderList;

  OrderListModel({this.orderItemsGroup, this.orderList});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    orderItemsGroup = json['order_items_group'];
    orderList = <OrderModel>[];
    if (json['order_list'] != null && json['order_list'] != false) {
      (json['order_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            orderList
                ?.add(OrderModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class OrderModel {
  int? createtime; //订单创建时间
  bool? isVirtual; //是否是虚拟商品
  String? orderId; //订单id
  String? scoreU; //实付积分
  String? quantity; //商品数量
  bool? typeVip; //商品是否是车主专属
  String? ticketCode; //虚拟商品票券码
  String? name; //商品名称
  String? imageurl; //商品图片

  OrderModel({
    this.createtime,
    this.isVirtual,
    this.orderId,
    this.scoreU,
    this.quantity,
    this.typeVip,
    this.ticketCode,
    this.name,
    this.imageurl,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    createtime = asT<int?>(json['createtime']);
    isVirtual = asT<bool?>(json['is_virtual']);
    orderId = asT<String?>(json['order_id']);
    scoreU = asT<String?>(json['score_u']);
    quantity = asT<String?>(json['quantity']);
    typeVip = asT<bool?>(json['type_vip']);
  }
}
