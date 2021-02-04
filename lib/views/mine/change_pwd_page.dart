import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/change_pwd_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/count_down_btn.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/login_textfield.dart';

class ChangePwdPage extends GetView<ChangePwdController> {
  final bool isForget = Get.arguments == null
      ? false
      : Get.arguments['isForget']; //区分是忘记密码还是修改密码，修改密码不能输入手机号
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '修改密码',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LoginTextField(
              enabled: isForget ? true : false,
              text: controller.phone,
              hintText: '请输入手机号',
              maxLength: 11,
              keyboardType: TextInputType.phone,
              leftWidget: Image.asset(
                'assets/images/mine/pwd_phone.png',
                width: 15.5,
                height: 21.5,
                scale: 2.0,
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              inputCallBack: (value) {
                controller.phone = value;
              },
            ),
            LoginTextField(
              hintText: '请输入验证码',
              maxLength: 6,
              keyboardType: TextInputType.number,
              leftWidget: Image.asset(
                'assets/images/mine/pwd_code.png',
                width: 15.5,
                height: 21.5,
                scale: 2.0,
              ),
              rightWidget: CountDownBtn(
                bgColor: Color(0xFF1B7DF4),
                borderColor: Colors.transparent,
                radius: 17,
                getVCode: () => controller.sendCode(isForget),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              inputCallBack: (value) {
                controller.code = value;
              },
            ),
            LoginTextField(
              hintText: '请输入新密码',
              isShowDeleteBtn: true,
              isPwd: true,
              leftWidget: Image.asset(
                'assets/images/mine/pwd_lock.png',
                width: 15.5,
                height: 21.5,
                scale: 2.0,
              ),
              pwdClose: 'assets/images/mine/pwd_not_visiable.png',
              pwdOpen: 'assets/images/mine/pwd_visiable.png',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              inputCallBack: (value) {
                controller.pwd = value;
              },
            ),
            LoginTextField(
              hintText: '请再次输入新密码',
              isShowDeleteBtn: true,
              isPwd: true,
              leftWidget: Image.asset(
                'assets/images/mine/pwd_lock.png',
                width: 15.5,
                height: 21.5,
                scale: 2.0,
              ),
              pwdClose: 'assets/images/mine/pwd_not_visiable.png',
              pwdOpen: 'assets/images/mine/pwd_visiable.png',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              inputCallBack: (value) {
                controller.confirmPwd = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Text(
                '密码格式为6-12位字母和数字的结合',
                style: TextStyle(color: Color(0xFF1B7DF4), fontSize: 11),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: CustomButton(
                backgroundColor: Color(0xFF1C7AF4),
                width: 140,
                height: 40,
                title: '确定修改',
                titleColor: Colors.white,
                radius: 20,
                onPressed: () => controller.submitted(isForget),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
