import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class PhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '手机号',
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '您当前绑定的手机号码为：',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                TextUtil.formatDigitPatternEnd(
                    Get.find<UserController>().userInfo.value.member.mobile),
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: CustomButton(
                backgroundColor: Color(0xFF1C7AF4),
                width: 180,
                height: 40,
                title: '更换绑定手机号',
                titleColor: Colors.white,
                radius: 20,
                onPressed: () => Get.toNamed(Routes.MINEUNBINDPHONE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
