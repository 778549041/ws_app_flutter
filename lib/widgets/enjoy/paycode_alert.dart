import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/enjoy/exchange_product_controller.dart';
import 'package:ws_app_flutter/widgets/global/base_alert_container.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class PayCodeAlert extends GetView<ExchangeProductController> {
  final int deduction;

  PayCodeAlert(this.deduction);

  @override
  Widget build(BuildContext context) {
    return BaseAlertContainer(
      Container(
        width: Get.width - 30,
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '请输入支付密码',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: '消耗积分：',
                style: TextStyle(color: Colors.black, fontSize: 15),
                children: [
                  TextSpan(
                    text: TextUtil.formatComma3(deduction) + '积分',
                    style: TextStyle(color: Color(0xFFAB2A52), fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            PinCodeTextField(
              pinBoxHeight: (Get.width - 100) / 6,
              pinBoxWidth: (Get.width - 100) / 6,
              maxLength: 6,
              autofocus: false,
              hideCharacter: true,
              maskCharacter: "*",
              pinBoxDecoration: (borderColor, pinBoxColor,
                  {borderWidth = 0, radius = 0}) {
                return BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFADADAD),
                      width: 0.5,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0));
              },
              onDone: (value) {
                controller.paycode = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Column(
                  children: <Widget>[
                    CustomButton(
                      backgroundColor: Colors.transparent,
                      imagePosition: XJImagePosition.XJImagePositionLeft,
                      title: '忘记密码',
                      titleColor: Color(0xFF4245E5),
                      fontSize: 12,
                      onPressed: () {
                        Get.back();
                        Get.toNamed(Routes.PAYAUTH);
                      },
                    ),
                    Container(
                      height: 1.5,
                      width: 50,
                      color: Color(0xFF4245E5),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              title: '确认支付',
              titleColor: Colors.white,
              backgroundColor: Color(0xFF4245E5),
              width: 150,
              height: 40,
              radius: 20,
              onPressed: () => controller.confirmExchange(),
            ),
          ],
        ),
      ),
    );
  }
}
