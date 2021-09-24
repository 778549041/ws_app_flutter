import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CreateTopicSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '创建话题',
      leftItem: Container(),
      child: WillPopScope(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 165,),
                Image.asset(
                  'assets/images/circle/create_topic_success.png',
                  width: 87,
                  height: 87,
                ),
                SizedBox(height: 40,),
                Text(
                  '您的话题提交成功\n请耐心等待管理员的审核',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF1B7DF4), fontSize: 15),
                ),
                SizedBox(height: 189,),
                CustomButton(
                  title: '返回',
                  titleColor: Colors.white,
                  backgroundColor: Color(0xFF1B7DF4),
                  width: 140,
                  height: 40,
                  radius: 20,
                  onPressed: () {
                    Get.close(2);
                  },
                ),
              ],
            ),
          ),
          onWillPop: () async {
            return false;
          }),
    );
  }
}
