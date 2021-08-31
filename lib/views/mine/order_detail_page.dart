import 'package:expandable_text/expandable_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/order_list_model.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderModel orderModel = Get.arguments['orderModel'];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '订单详情',
      bgColor: MainAppColor.mainSilverColor,
      child: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (orderModel.isVirtual!) {
      return Column(
        children: <Widget>[
          _buildImgRow(),
          _buildOrderInfoRow(),
          _buildExplainInfoRow(),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          _buildImgRow(),
          _buildAcceptInfo(),
          _buildOrderInfoRow(),
        ],
      );
    }
  }

  //商品图片、名称行
  Widget _buildImgRow() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    NetImageWidget(
                      imageUrl: orderModel.imageurl,
                      width: 100,
                      height: 100,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Offstage(
                        offstage: !orderModel.typeVip!,
                        child: Image.asset(
                          'assets/images/enjoy/icon_car_owner.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        orderModel.name!,
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          '积分${CommonUtil.formatDoubleComma3(orderModel.scoreU!)}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    '数量:${orderModel.quantity!}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '消耗积分总值:',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  '${CommonUtil.formatDoubleComma3(orderModel.scoreU!)}积分',
                  style: TextStyle(color: Color(0xFFBD1051), fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //订单信息行
  Widget _buildOrderInfoRow() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '订单信息',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '订单编号：${orderModel.orderId!}',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '兑换时间：${DateUtil.formatDateMs(orderModel.createtime! * 1000, format: DateFormats.full)}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  //使用信息行
  Widget _buildExplainInfoRow() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '使用信息',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '票券码：${orderModel.ticketCode!}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                CustomButton(
                  width: 40,
                  height: 20,
                  imageH: 14,
                  imageW: 36,
                  image: 'assets/images/mine/ticket_copy.png',
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: orderModel.ticketCode!));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '有效期：${DateUtil.formatDateMs(orderModel.startTime! * 1000, format: DateFormats.y_mo_d)} 至 ${DateUtil.formatDateMs(orderModel.endTime! * 1000, format: DateFormats.y_mo_d)}',
              style: TextStyle(fontSize: 12),
            ),
            ExpandableText(
              orderModel.explain == null ? '使用说明：暂无' : '使用说明：' + orderModel.explain!,
              style: TextStyle(fontSize: 12),
              expandText: '展开∨',
              collapseText: '收起∧',
              linkColor: Color(0xFF1B7DF4),
            )
          ],
        ),
      ),
    );
  }

  //收货信息行
  Widget _buildAcceptInfo() {
    String area = orderModel.consigneeArea!;
    if (area.contains('mainland')) {
      area = area.split(':')[1];
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '收货信息',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '收件人：${orderModel.consigneeName!} ${orderModel.consigneeMobile!.replaceFirst(RegExp(r'\d{4}'), '****', 2)}',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '收货地址：$area ${orderModel.consigneeAddress}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
