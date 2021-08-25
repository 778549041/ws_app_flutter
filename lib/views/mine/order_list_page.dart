import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/order_list_model.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/order_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class OrderListPage extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '兑换订单',
      bgColor: MainAppColor.mainSilverColor,
      child: Obx(
        () {
          if (controller.isEmpty()) {
            return ViewStateEmptyWidget(
              image: 'assets/images/common/empty.png',
              message: '空空如也',
              buttonText: '重新加载',
              onPressed: () => controller.refresh(),
            );
          } else {
            return SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              onRefresh: () => controller.refresh(),
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildOrderItem(index);
                      },
                      childCount: controller.list.length,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildOrderItem(int index) {
    OrderModel model = controller.list[index];
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                  DateUtil.formatDateMs(model.createtime! * 1000,
                      format: DateFormats.y_mo_d),
                  style: TextStyle(
                      color: MainAppColor.secondaryTextColor, fontSize: 12))
              // Row(
              //   children: <Widget>[
              // Expanded(
              //   child: Text(
              //     DateUtil.formatDateMs(model.createtime! * 1000,
              //         format: DateFormats.y_mo_d),
              //     style: TextStyle(
              //         color: MainAppColor.secondaryTextColor, fontSize: 12),
              //   ),
              // ),
              // Row(
              //   children: <Widget>[
              //     Image.asset(
              //       'assets/images/mine/consumed.png',
              //       width: 15,
              //       height: 15,
              //     ),
              //     Text(
              //       '已核销',
              //       style: TextStyle(
              //           color: MainAppColor.secondaryTextColor, fontSize: 12),
              //     )
              //   ],
              // ),
              //   ],
              // ),
              ),
          Divider(
            color: MainAppColor.seperatorLineColor,
            height: 0.5,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Stack(
              children: <Widget>[
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: CustomButton(
                      title: '复制单号',
                      fontSize: 11,
                      titleColor: Colors.white,
                      width: 55,
                      height: 20,
                      radius: 10,
                      backgroundColor: Color(0xFF4245E5),
                      onPressed: () {},
                    )),
                Row(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        NetImageWidget(
                          imageUrl: model.imageurl,
                          width: 100,
                          height: 100,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Offstage(
                            offstage: !model.typeVip!,
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
                          model.name!,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: model.isVirtual! ? '票券码：' : '订单号：',
                            style: TextStyle(color: Colors.black, fontSize: 11),
                            children: [
                              TextSpan(
                                  text: model.isVirtual!
                                      ? model.ticketCode!
                                      : model.orderId!,
                                  style: (TextStyle(
                                      color: MainAppColor.secondaryTextColor,
                                      fontSize: 11))),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(right: 60),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       RichText(
                        //         text: TextSpan(
                        //           text: '规格：',
                        //           style: TextStyle(
                        //               color: Colors.black, fontSize: 11),
                        //           children: [
                        //             TextSpan(
                        //                 text: '蓝色款',
                        //                 style: (TextStyle(
                        //                     color:
                        //                         MainAppColor.secondaryTextColor,
                        //                     fontSize: 11))),
                        //           ],
                        //         ),
                        //       ),
                        //       RichText(
                        //         text: TextSpan(
                        //           text: '配送公司：',
                        //           style: TextStyle(
                        //               color: Colors.black, fontSize: 11),
                        //           children: [
                        //             TextSpan(
                        //                 text: '顺丰快递',
                        //                 style: (TextStyle(
                        //                     color:
                        //                         MainAppColor.secondaryTextColor,
                        //                     fontSize: 11))),
                        //           ],
                        //         ),
                        //       ),
                        //       RichText(
                        //         text: TextSpan(
                        //           text: '配送单号：',
                        //           style: TextStyle(
                        //               color: Colors.black, fontSize: 11),
                        //           children: [
                        //             TextSpan(
                        //                 text: model.isVirtual!
                        //                     ? model.ticketCode!
                        //                     : model.orderId!,
                        //                 style: (TextStyle(
                        //                     color:
                        //                         MainAppColor.secondaryTextColor,
                        //                     fontSize: 11))),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: MainAppColor.seperatorLineColor,
            height: 0.5,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  '共${model.quantity}件商品',
                  style: TextStyle(
                      color: MainAppColor.secondaryTextColor, fontSize: 12),
                )),
                RichText(
                  text: TextSpan(
                    text: '实付：',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                      TextSpan(
                          text:
                              '${CommonUtil.formatDoubleComma3(model.scoreU!)}积分',
                          style: (TextStyle(
                              color: Color(0xFFBD1051), fontSize: 12))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
