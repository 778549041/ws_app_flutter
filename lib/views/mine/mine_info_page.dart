import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/mine_info_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class MineInfoPage extends GetView<MineInfoController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '个人信息',
      bgColor: Colors.transparent,
      child: CustomScrollView(
        slivers: [
          Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  Map _item = controller.data[index];
                  if (index == 0) {
                    return _buildHeadRow();
                  }
                  return Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, bottom: 7),
                      height: 60,
                      color: Color(0xFFF3F3F3),
                      child: GestureDetector(
                          onTap: () => controller.listItemClick(index),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  _item['title'],
                                  style: TextStyle(fontSize: 15),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        _item['content'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/mine/mine_right_arrow.png',
                                      width: 7.5,
                                      height: 11,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )));
                }, childCount: controller.data.length),
              ))
        ],
      ),
    );
  }

  Widget _buildHeadRow() {
    return Stack(
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
                    onPressed: () => controller.clickAvatar(),
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
                Positioned(
                  bottom: 5.0,
                  right: 5.0,
                  child: Image.asset(
                    'assets/images/mine/vip_tag.png',
                    width: 18,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                )
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
                                    .uname
                                    .length >
                                11)
                            ? Get.find<UserController>()
                                .userInfo
                                .value
                                .member
                                .uname
                                .substring(0, 11)
                            : Get.find<UserController>()
                                .userInfo
                                .value
                                .member
                                .uname,
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
                      child: Obx(() => CustomButton(
                            backgroundColor: Colors.transparent,
                            width: 30,
                            height: 30,
                            image: Get.find<UserController>()
                                .userInfo
                                .value
                                .member
                                .memberInfo
                                .medalOrSaleImageName,
                            onPressed: () {
                              LogUtil.v('点击了个人信息勋章');
                            },
                          )),
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
              height: 10,
            ),
            CustomButton(
              backgroundColor: Colors.transparent,
              width: 80,
              imagePosition: XJImagePosition.XJImagePositionLeft,
              image: 'assets/images/mine/mine_info_bar.png',
              imageH: 11,
              imageW: 11,
              title: '我的二维码',
              titleColor: Color(0xFF1B7DF4),
              fontSize: 12,
              onPressed: () => controller.clickQR(),
            ),
            Container(
              height: 1.5,
              width: 75,
              color: Color(0xFF1B7DF4),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ],
    );
  }
}
