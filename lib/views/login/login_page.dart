import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/view_models/login/login_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/login/login_type_switch.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:
                'https://wsmedia.ghac.cn/production/ee/17/15e7568eaebf.gif?22017_OW750_OH1624',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => Image.network(
              'https://wsmedia.ghac.cn/production/fd/a5/acdb93b7920d.png?22119_OW750_OH1624',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: LoginTypeSwitchWidget(
                      width: Get.width - 40,
                      height: 40,
                      slideAction: (index, text) {
                        controller.switchLoginType(index);
                      },
                      list: [
                        '验证码登录',
                        '账号密码登录',
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Obx(
                      () => Offstage(
                        child: Text(
                          '未注册手机验证后即可完成注册',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 10),
                        ),
                        offstage: controller.loginType.value !=
                            LoginType.AuthCodeType,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    obscureText: false,
                    style: TextStyle(
                        fontSize: 18, color: Colors.white.withOpacity(0.6)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (value) {
                      Get.focusScope.requestFocus(controller.pwdFocus);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/images/login/login_phone.png',
                        scale: 3,
                        width: 16.5,
                        height: 25,
                      ),
                      hintText: '请输入手机号',
                      hintStyle: TextStyle(
                          fontSize: 18, color: Colors.white.withOpacity(0.6)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.6))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.6))),
                    ),
                  ),
                  Obx(
                    () => TextFormField(
                      controller: controller.pwdController,
                      obscureText: controller.pwdState(),
                      keyboardType: controller.pwdKBType.value,
                      style: TextStyle(
                          fontSize: 18, color: Colors.white.withOpacity(0.6)),
                      focusNode: controller.pwdFocus,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/images/login/login_pwd.png',
                          scale: 3,
                          width: 16.5,
                          height: 25,
                        ),
                        hintText: controller.placeholder.value,
                        hintStyle: TextStyle(
                            fontSize: 18, color: Colors.white.withOpacity(0.6)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.6))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.6))),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Offstage(
                              child: IconButton(
                                icon: Image.asset(
                                  controller.secureImageName.value,
                                  width: 21,
                                  height: 16,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                onPressed: () => controller.switchSecure(),
                              ),
                              offstage: !controller.showSecure.value,
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.white.withOpacity(0.6),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Offstage(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => controller.sendCode(),
                                child: Text(
                                  controller.pwdBtnTitle.value,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 15),
                                ),
                              ),
                              offstage: controller.showSecure.value,
                            ),
                            Offstage(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => controller.forgetPwdAction(),
                                child: Text(
                                  '忘记密码',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 15),
                                ),
                              ),
                              offstage: !controller.showSecure.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 145),
                    child: Center(
                      child: CustomButton(
                        width: 200,
                        height: 44,
                        radius: 22,
                        title: '登录',
                        onPressed: () => controller.loginAction(),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Obx(() => CustomButton(
                              width: 30,
                              height: 30,
                              backgroundColor: Colors.transparent,
                              imageW: 15,
                              imageH: 15,
                              image: controller.aggreeImageName.value,
                              onPressed: () => controller.changeAggreeState(),
                            )),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: '请仔细阅读',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              children: [
                                TextSpan(
                                    text: '《WOW STATION App隐私政策》',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.pushH5Page(args: {
                                          'url':
                                              'https://wsapp.ghac.cn/yszc.html',
                                          'hasNav': true,
                                        });
                                      }),
                                TextSpan(
                                  text: '及',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                TextSpan(
                                    text: '《广汽本田平台服务协议》',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.pushH5Page(args: {
                                          'url':
                                              'https://wsapp.ghac.cn/yhxy.html',
                                          'hasNav': true,
                                        });
                                      }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildThirdLogin(),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                          width: 70,
                          height: 40,
                          backgroundColor: Colors.transparent,
                          title: '了解VE-1',
                          titleColor: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                          onPressed: () => controller.pushH5Page(args: {
                            'url': CacheKey.SERVICE_URL_HOST +
                                HtmlUrls.UnderstandVEPage,
                            'hasNav': true,
                          }),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          width: 1.0,
                          height: 20,
                          color: Colors.white.withOpacity(0.6),
                        ),
                        CustomButton(
                          width: 70,
                          height: 40,
                          backgroundColor: Colors.transparent,
                          title: '爱车配件',
                          titleColor: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                          onPressed: () => controller.pushH5Page(args: {
                            'url': CacheKey.SERVICE_URL_HOST +
                                HtmlUrls.CarPartsPage,
                          }),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          width: 1.0,
                          height: 20,
                          color: Colors.white.withOpacity(0.6),
                        ),
                        CustomButton(
                          width: 70,
                          height: 40,
                          backgroundColor: Colors.transparent,
                          title: '预约试驾',
                          titleColor: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                          onPressed: () => controller.pushH5Page(args: {
                            'url': CacheKey.SERVICE_URL_HOST +
                                HtmlUrls.TestDrivePage,
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdLogin() {
    if (Platform.isIOS) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              backgroundColor: Colors.transparent,
              width: 36,
              height: 36,
              image: 'assets/images/login/login_wechat.png',
              imageH: 36,
              imageW: 36,
              onPressed: () => controller.wechatLogin(),
            ),
            SizedBox(
              width: 10,
            ),
            CustomButton(
              backgroundColor: Colors.transparent,
              width: 36,
              height: 36,
              image: 'assets/images/login/login_apple.png',
              imageH: 36,
              imageW: 36,
              onPressed: () => controller.appleLogin(),
            ),
          ],
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: CustomButton(
          backgroundColor: Colors.transparent,
          width: 36,
          height: 36,
          image: 'assets/images/login/login_wechat.png',
          imageH: 36,
          imageW: 36,
          onPressed: () => controller.wechatLogin(),
        ),
      ),
    );
  }
}
