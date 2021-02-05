import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeNamePage extends StatelessWidget {
  final bool isName = Get.arguments == null
      ? false
      : Get.arguments['isName']; //区分是忘记密码还是修改密码，修改密码不能输入手机号
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}
