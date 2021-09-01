import 'package:flutter/material.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class IntegralStrategyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '积分攻略',
      bgColor: MainAppColor.mainSilverColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/mine/integral_stragegy_1.jpeg',
              width: double.infinity,
            ),
            Image.asset(
              'assets/images/mine/integral_stragegy_2.jpeg',
              width: double.infinity,
            ),
            Image.asset(
              'assets/images/mine/integral_stragegy_3.jpeg',
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
