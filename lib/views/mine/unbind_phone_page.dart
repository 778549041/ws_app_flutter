import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/unbind_phone_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/count_down_btn.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/login_textfield.dart';

class UnbindPhonePage extends GetView<UnbindPhoneController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '解除绑定手机号',
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              '请先解除绑定当前手机号',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: 250,
              child: LoginTextField(
                enabled: false,
                text: Get.find<UserController>()
                    .userInfo
                    .value
                    .member!
                    .mobile!
                    .replaceFirst(RegExp(r'\d{4}'), '****', 3),
                maxLength: 11,
                keyboardType: TextInputType.phone,
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
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
              title: '下一步',
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
