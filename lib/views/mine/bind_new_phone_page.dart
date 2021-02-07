import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/bind_new_phone_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/count_down_btn.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/login_textfield.dart';

class BindNewPhonePage extends GetView<BindNewPhoneController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '绑定新手机号',
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              '请绑定新的手机号',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: 250,
              child: LoginTextField(
                hintText: '请输入新的手机号',
                maxLength: 11,
                keyboardType: TextInputType.phone,
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
                inputCallBack: (value) {
                  controller.phone = value;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              child: LoginTextField(
                hintText: '请输入验证码',
                maxLength: 6,
                keyboardType: TextInputType.number,
                rightWidget: CountDownBtn(
                  textColor: Color(0xFF666666),
                  borderColor: Color(0xFFD6D6D6),
                  radius: 0,
                  getVCode: () => controller.sendCode(),
                ),
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
                inputCallBack: (value) {
                  controller.code = value;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Offstage(
                offstage: controller.tipMessage.value.length == 0,
                child: Text(
                  controller.tipMessage.value,
                  style: TextStyle(color: Color(0xFFFCA807), fontSize: 12),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            CustomButton(
              backgroundColor: Color(0xFF1C7AF4),
              width: 140,
              height: 40,
              title: '完成绑定',
              titleColor: Colors.white,
              radius: 20,
              onPressed: () => controller.nextStep(),
            ),
          ],
        ),
      ),
    );
  }
}
