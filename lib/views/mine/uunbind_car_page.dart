import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/unbind_car_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/count_down_btn.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/login_textfield.dart';

class UnBindCarPage extends GetView<UnBindCarController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '提供身份信息',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(
              '为确保用车过程中的服务体验和车辆信息安全，请提供必要的身份信息。',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 40,
            ),
            LoginTextField(
              enabled: false,
              text: controller.phone!,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              inputCallBack: (value) {
                controller.phone = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            LoginTextField(
              hintText: '验证码',
              maxLength: 6,
              keyboardType: TextInputType.number,
              rightWidget: CountDownBtn(
                bgColor: Color(0xFF1B7DF4),
                borderColor: Colors.transparent,
                radius: 17,
                getVCode: () => controller.sendCode(),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              inputCallBack: (value) {
                controller.code = value;
              },
            ),
            SizedBox(
              height: 100,
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