import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/widgets/global/base_alert_container.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class NotsetPaycodeAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseAlertContainer(
      Container(
        width: Get.width - 30,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: 10,
              right: 10,
              child: CustomButton(
                width: 30,
                height: 30,
                imageH: 15,
                imageW: 15,
                radius: 7.5,
                image: 'assets/images/common/icon_close.png',
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Text(
                  '您还没有设置\n支付密码哦！',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  title: '去设置',
                  titleColor: Colors.white,
                  backgroundColor: Color(0xFF4245E5),
                  width: 150,
                  height: 40,
                  radius: 20,
                  onPressed: () {
                    Get.back();
                    Get.toNamed(Routes.PAYAUTH);
                  },
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
