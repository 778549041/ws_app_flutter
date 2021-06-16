import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:ws_app_flutter/view_models/mine/pay_confirm_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class PayPwdConfirmPage extends GetView<PayConfirmController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '请再次输入一次',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(
              '为确保你的信息安全，请设置6位数的服务密码',
              style: TextStyle(color: Color(0xFF1B7DF4), fontSize: 13),
            ),
            SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              pinBoxHeight: (Get.width - 70) / 6,
              pinBoxWidth: (Get.width - 70) / 6,
              maxLength: 6,
              autofocus: true,
              hideCharacter: true,
              maskCharacter: "*",
              pinBoxDecoration: (borderColor, pinBoxColor,
                  {borderWidth, radius}) {
                return BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFADADAD),
                      width: 0.5,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0));
              },
              onDone: (text) {
                controller.input = text;
              },
            ),
            SizedBox(
              height: 200,
            ),
            CustomButton(
              backgroundColor: Color(0xFF1C7AF4),
              width: 140,
              height: 40,
              title: '提交',
              titleColor: Colors.white,
              radius: 20,
              onPressed: () => controller.submitted(),
            ),
          ],
        ),
      ),
    );
  }
}
