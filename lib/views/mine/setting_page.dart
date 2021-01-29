import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/setting_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_appbar.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class SettingPage extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/common/bg.png',
          width: Get.width,
          height: Get.height / 2,
          fit: BoxFit.cover,
        ),
        Container(
          margin:
              EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
          width: Get.width,
          height: 40,
          child: CustomAppBar(
            height: 40,
            leftButtons: <Widget>[
              CustomButton(
                backgroundColor: Colors.transparent,
                clickInterval: 0,
                width: 47,
                height: 40,
                image: 'assets/images/common/nav_back_with_title.png',
                imageW: 47,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
            title: Text(
              '我的设置',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            rightButtons: <Widget>[],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight + 60, bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: CustomScrollView(
              slivers: <Widget>[
                Obx(() => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        Map _item = controller.data[index];
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => controller.listItemClick(index),
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 59,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        _item['title'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              _item['content'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFFADADAD)),
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
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 0),
                                  height: 0.5,
                                  color: Color(0xFFD6D6D6),
                                )
                              ],
                            ),
                          ),
                        );
                      }, childCount: controller.data.length),
                    )),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: <Widget>[
                        CustomButton(
                          backgroundColor: Color(0xFF1C7AF4),
                          width: 140,
                          height: 40,
                          title: '退出登录',
                          titleColor: Colors.white,
                          radius: 20,
                          onPressed: () => Get.find<UserController>().logout(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: CustomButton(
                            backgroundColor: Colors.transparent,
                            width: 140,
                            height: 40,
                            title: '账号注销',
                            titleColor: Color(0xFF1C7AF4),
                            borderColor: Color(0xFF1C7AF4),
                            borderWidth: 1.0,
                            radius: 20,
                            onPressed: () {
                              Get.dialog(CupertinoAlertDialog(
                                title: Text('提示'),
                                content: Text('账号注销后您将无法正常登陆与使用该应用，是否确定注销？'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('取消'),
                                    onPressed: () => Get.back(),
                                  ),
                                  FlatButton(
                                    child: Text('确认'),
                                    onPressed: () async {
                                      Get.back();
                                      await controller.deleteUser();
                                    },
                                  )
                                ],
                              ));
                            },
                          ),
                        ),
                        CustomButton(
                          backgroundColor: Colors.transparent,
                          title: '联系我们',
                          titleColor: Color(0xFF666666),
                          fontSize: 12,
                          onPressed: () => controller.callPhoneNumber(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
