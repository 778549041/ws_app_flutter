import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/enjoy/exchange_product_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/cart_add_reduce.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class ExchangeProductPage extends GetView<ExchangeProductController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '确认积分兑换',
      child: Obx(
        () => controller.model.value.goods == null
            ? Container()
            : Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _buildAddress(),
                          _buildProduct(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    height: 40,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '消耗积分：${controller.model.value.relgoods?.deduction == null ? '' : TextUtil.formatComma3(controller.model.value.relgoods!.deduction! * controller.count.value) + '积分'}',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          title: '立即兑换',
                          titleColor: Colors.white,
                          backgroundColor: Color(0xFF4245E5),
                          width: 150,
                          height: 40,
                          onPressed: () => controller.exchangeProduct(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _buildAddress() {
    if (controller.currentAddress.value.addrId == '') {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: CustomButton(
          title: '添加地址',
          titleColor: Colors.white,
          width: 170,
          height: 40,
          radius: 20,
          backgroundColor: Color(0xFF4245E5),
          onPressed: () {},
        ),
      );
    } else {
      var _address = controller.currentAddress.value.area;
      if (_address != null && _address.contains('mainland')) {
        _address = _address.split(':')[1];
      }
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => controller.pushAddressList(),
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/mine/mine_shop_addre_addr.png',
                    width: 24,
                    height: 29,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                controller.currentAddress.value.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.currentAddress.value.mobile!
                                  .replaceFirst(RegExp(r'\d{4}'), '****', 3),
                              style: TextStyle(
                                  color: Color(0xFFADADAD), fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Offstage(
                              offstage:
                                  !controller.currentAddress.value.isDefault!,
                              child: Image.asset(
                                'assets/images/mine/mine_shop_addre_default.png',
                                width: 32,
                                height: 16,
                              ),
                            )
                          ],
                        ),
                        Text(
                          _address! +
                              ' ' +
                              controller.currentAddress.value.addr!,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/images/mine/mine_right_arrow.png',
                    width: 7.5,
                    height: 11,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Color(0xFFD6D6D6),
                height: 0.5,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildProduct() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: <Widget>[
          NetImageWidget(
            imageUrl: controller.model.value.goods?.product?.imagePath,
            width: 105,
            height: 105,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  controller.model.value.goods?.name == null
                      ? ''
                      : controller.model.value.goods!.name!,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '规格：无',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              text: '消耗积分：',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              children: [
                                TextSpan(
                                  text: controller.model.value.relgoods
                                              ?.deduction ==
                                          null
                                      ? ''
                                      : TextUtil.formatComma3(controller.model
                                              .value.relgoods!.deduction!) +
                                          '积分',
                                  style: TextStyle(
                                      color: Color(0xFFAB2A52), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CartAddReduceWidget(
                      onCountChanged: (count) {
                        controller.count.value = count;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
