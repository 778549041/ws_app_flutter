import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/car_info_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CarInfoPage extends GetView<CarInfoController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '车辆绑定',
      bgColor: Colors.transparent,
      child: Obx(
        () => Column(
          children: <Widget>[
            _buildHeadRow(),
            Expanded(
              child: Container(
                color: MainAppColor.mainSilverColor,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    Map _item = controller.data[index];
                    if (index == controller.data.length - 1) {
                      return _buildSubmitButton();
                    }
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, bottom: 7),
                      height: 60,
                      color: Color(0xFFF3F3F3),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Row(
                          children: <Widget>[
                            Text(
                              _item['title'],
                              style: TextStyle(fontSize: 15),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        _item['content'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/mine/mine_right_arrow.png',
                                    width: 7.5,
                                    height: 11,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
          bottom: -5,
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
                        ?.headImg,
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
                                    .member!
                                    .showName!
                                    .length >
                                11)
                            ? Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .showName!
                                .substring(0, 11)
                            : Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .showName!,
                        style: TextStyle(fontSize: 15),
                      )),
                  // 销售员或者勋章标签
                  if (Get.find<UserController>()
                      .userInfo
                      .value
                      .member!
                      .memberInfo!
                      .showTag!)
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: MedalWidget(
                        medalBtnImage: Get.find<UserController>()
                            .userInfo
                            .value
                            .member!
                            .memberInfo!
                            .medalOrSaleImageName!,
                        medalToastImage: Get.find<UserController>()
                            .userInfo
                            .value
                            .member!
                            .memberInfo!
                            .medalOrSaleDescImageName!,
                        isSales: Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .memberInfo!
                                .isSales ==
                            1,
                      ),
                    ),
                  Obx(() => Offstage(
                        offstage: Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .sex!
                                .length ==
                            0,
                        child: Image.asset(
                          Get.find<UserController>()
                                      .userInfo
                                      .value
                                      .member!
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
              height: 30,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Center(
        child: CustomButton(
          backgroundColor: MainAppColor.mainBlueBgColor,
          width: 180,
          height: 40,
          title: '解绑车辆',
          titleColor: Colors.white,
          radius: 20,
          onPressed: () => controller.submitAction(),
        ),
      ),
    );
  }
}
