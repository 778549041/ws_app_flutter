import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class MineQRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的二维码',
      bgColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
          ),
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Obx(
                    () => RoundAvatar(
                      height: 90,
                      borderWidth: 3,
                      imageUrl: Get.find<UserController>()
                              .userInfo
                              .value
                              .member
                              .headImg ??
                          '',
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/mine/mine_info_camara.png',
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Obx(() => Text(
                          (Get.find<UserController>()
                                      .userInfo
                                      .value
                                      .member
                                      .showName
                                      .length >
                                  11)
                              ? Get.find<UserController>()
                                  .userInfo
                                  .value
                                  .member
                                  .showName
                                  .substring(0, 11)
                              : Get.find<UserController>()
                                  .userInfo
                                  .value
                                  .member
                                  .showName,
                          style: TextStyle(fontSize: 15),
                        )),
                    // 销售员或者勋章标签
                    if (Get.find<UserController>()
                        .userInfo
                        .value
                        .member
                        .memberInfo
                        .showTag)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: MedalWidget(
                          medalBtnImage: Get.find<UserController>()
                              .userInfo
                              .value
                              .member
                              .memberInfo
                              .medalOrSaleImageName,
                          medalToastImage: Get.find<UserController>()
                              .userInfo
                              .value
                              .member
                              .memberInfo
                              .medalOrSaleDescImageName,
                          isSales: Get.find<UserController>()
                                  .userInfo
                                  .value
                                  .member
                                  .memberInfo
                                  .isSales ==
                              1,
                        ),
                      ),
                    Obx(() => Offstage(
                          offstage: Get.find<UserController>()
                                  .userInfo
                                  .value
                                  .member
                                  .sex
                                  .length ==
                              0,
                          child: Image.asset(
                            Get.find<UserController>()
                                        .userInfo
                                        .value
                                        .member
                                        .sex ==
                                    '0'
                                ? 'assets/images/mine/woman.png'
                                : 'assets/images/mine/man.png',
                            width: 15,
                            height: 15,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              NetImageWidget(
                width: 250,
                height: 250,
                imageUrl: Get.find<UserController>()
                    .userInfo
                    .value
                    .member
                    .memberQrcode,
              )
            ],
          ),
        ],
      ),
    );
  }
}
