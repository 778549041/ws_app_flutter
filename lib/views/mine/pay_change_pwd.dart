import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:ws_app_flutter/view_models/mine/pay_changepwd_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class PayChangePwdPage extends GetView<PayChangePwdController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '设置服务安全密码',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              onDone: (text) => controller.nextStep(text),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '服务安全密码不能是连续、重复的数字',
              style: TextStyle(color: Color(0xFF1B7DF4), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
