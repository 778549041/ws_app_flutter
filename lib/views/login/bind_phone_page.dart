import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/bind_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class BindPhonePage extends GetView<BindController> {
  final bool appleLogin = Get.arguments['appleLogin'] ?? false;
  final String openid = Get.arguments['openid'] ?? '';
  final String memberId = Get.arguments['memberId'] ?? '';
  final String unionid = Get.arguments['unionid'] ?? '';
  final String clientUser = Get.arguments['clientUser'] ?? '';
  final String identityToken = Get.arguments['identityToken'] ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/common/bg.png',
              width: Get.width,
              height: Get.height / 2,
              fit: BoxFit.cover,
            ),
            Container(
                margin: EdgeInsets.only(top: Get.statusBarHeight + 72),
                width: Get.width,
                height: Get.height - (Get.statusBarHeight + 72),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Text(
                          '欢迎您!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '请绑定您的手机号码',
                        style: TextStyle(
                            fontSize: 16, color: Colors.black.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: controller.nameController,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (value) {
                          Get.focusScope.requestFocus(controller.pwdFocus);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Image.asset(
                            'assets/images/mine/pwd_phone.png',
                            scale: 1.5,
                            width: 16.5,
                            height: 25,
                          ),
                          hintText: '请输入手机号',
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xFFD6D6D6)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF333333))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF333333))),
                        ),
                      ),
                      TextFormField(
                        controller: controller.pwdController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        focusNode: controller.pwdFocus,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset(
                            'assets/images/mine/pwd_code.png',
                            scale: 1.5,
                            width: 16.5,
                            height: 25,
                          ),
                          hintText: '请输入验证码',
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xFFD6D6D6)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF333333))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF333333))),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 20,
                                width: 1,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => controller.sendCode(),
                                child: Obx(
                                  () => Text(
                                    controller.pwdBtnTitle.value,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Offstage(
                            child: Obx(
                              () => Text(
                                controller.errorMsg.value,
                                style: TextStyle(
                                    color: Color(0xFFFCA807), fontSize: 12),
                              ),
                            ),
                            offstage: controller.errorMsg.value.length == 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Center(
                          child: CustomButton(
                            backgroundColor: Color(0xFF4245E5),
                            width: 200,
                            height: 44,
                            radius: 22,
                            title: '绑定',
                            titleColor: Colors.white,
                            onPressed: () => controller.bindAction(appleLogin,
                                openid: openid,
                                memberId: memberId,
                                unionid: unionid,
                                clientUser: clientUser,
                                identityToken: identityToken),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
