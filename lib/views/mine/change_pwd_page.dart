import 'package:flutter/material.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/count_down_btn.dart';

class ChangePwdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '修改密码',
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CountDownBtn(textColor: Color(0xFF1B7DF4),borderColor: Color(0xFF1B7DF4),radius: 0,)
          ],
        ),
      ),
    );
  }
}
