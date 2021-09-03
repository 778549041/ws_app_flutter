import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/enjoy/product_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '商品详情',
      child: Obx(
        () => Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        NetImageWidget(
                          imageUrl: controller
                              .model.value.dataDetail?.product?.imagePath,
                          width: Get.width,
                          height: Get.width,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Offstage(
                            offstage: controller
                                        .model.value.dataDetail?.typeVip ==
                                    null
                                ? true
                                : !controller.model.value.dataDetail!.typeVip!,
                            child: Image.asset(
                              'assets/images/enjoy/icon_car_owner.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Text(
                        controller.model.value.dataDetail?.name == null
                            ? ''
                            : controller.model.value.dataDetail!.name!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Offstage(
                      offstage: controller.model.value.relgoods?.deduction ==
                              null
                          ? true
                          : controller.model.value.relgoods!.deduction! == 0,
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, top: 15),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/enjoy/enjoy_price_point_red.png',
                              width: 15,
                              height: 16,
                            ),
                            Flexible(
                              child: Text(
                                TextUtil.formatComma3(controller
                                            .model.value.relgoods?.deduction ==
                                        null
                                    ? ''
                                    : controller
                                        .model.value.relgoods!.deduction!),
                                style: TextStyle(
                                    color: Color(0xFFE30052), fontSize: 15),
                              ),
                            ),
                            Image.asset(
                              'assets/images/enjoy/car_owner_tag.png',
                              width: 40,
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Offstage(
                      offstage:
                          controller.model.value.relgoods?.integral == null
                              ? true
                              : controller.model.value.relgoods!.integral! == 0,
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, top: 15),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/enjoy/enjoy_price_point.png',
                              width: 15,
                              height: 16,
                            ),
                            Flexible(
                              child: Text(
                                TextUtil.formatComma3(
                                    controller.model.value.relgoods?.integral ==
                                            null
                                        ? true
                                        : controller
                                            .model.value.relgoods!.integral!),
                                style: TextStyle(
                                    color: Color(0xFFBBBBBB), fontSize: 15),
                              ),
                            ),
                            Image.asset(
                              'assets/images/enjoy/normal_user_tag.png',
                              width: 40,
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Divider(
                        color: MainAppColor.seperatorLineColor,
                        height: 0.5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            color: MainAppColor.seperatorLineColor,
                            height: 0.5,
                            width: (Get.width - 130) / 2,
                          ),
                          Center(
                            child: Text(
                              '商品详情',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            color: MainAppColor.seperatorLineColor,
                            height: 0.5,
                            width: (Get.width - 130) / 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Divider(
                        color: MainAppColor.seperatorLineColor,
                        height: 0.5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                      child: Html(
                        data: controller.model.value.dataDetail?.description ==
                                null
                            ? ''
                            : controller.model.value.dataDetail!.description!,
                        onImageError: (exception, stackTrace) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.model.value.dataDetail?.product?.stock != null
                ? controller.model.value.dataDetail!.product!.stock! == 0
                    ? Container(
                        width: Get.width,
                        height: 40,
                        color: MainAppColor.mainSilverColor,
                        child: Center(
                          child: Text(
                            '来迟一步',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    : CustomButton(
                        title: '兑换商品',
                        titleColor: Colors.white,
                        backgroundColor: Color(0xFF4245E5),
                        width: Get.width,
                        height: 40,
                        onPressed: () => controller.clickExchange(),
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}
