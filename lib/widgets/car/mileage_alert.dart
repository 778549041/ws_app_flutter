import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/widgets/global/base_alert_container.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class MileageAlert extends StatelessWidget {
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
                  height: 40,
                ),
                Text(
                  '积分规则说明',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        height: 0.5,
                        color: Color(0xFF999999),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '1.每公里行程产生',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: '10',
                              style: TextStyle(
                                  color: Color(0xFF4245E5), fontSize: 15),
                            ),
                            TextSpan(
                              text: '积分\n\n',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(
                              text: '2.认证',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(
                              text: '3年内',
                              style: TextStyle(
                                  color: Color(0xFF4245E5), fontSize: 15),
                            ),
                            TextSpan(
                              text:
                                  '用户可领取积分\n\n3.行驶54000公里内可领取积分\n\n4.每日凌晨更新积分信息\n\n5.所有行程产生的积分保留',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(
                              text: '24小时\n\n',
                              style: TextStyle(
                                  color: Color(0xFF4245E5), fontSize: 15),
                            ),
                            TextSpan(
                              text: '6.积分过期后不可再领取',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
