import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/mine_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_cell.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class MinePage extends GetView<MineController> {
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
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight,
              left: 15,
              right: 15),
          width: Get.width,
          height: 40,
          child: _buildHeader(),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight + 40),
          width: Get.width,
          // color: MainAppColor.mainSilverColor,
          child: _buildBody(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: CustomButton(
            backgroundColor: Colors.transparent,
            width: 25,
            height: 25,
            image: 'assets/images/mine/mine_scan.png',
            imageW: 25,
            imageH: 25,
            onPressed: () => controller.pushAction(1000),
          ),
        ),
        Row(
          children: <Widget>[
            CustomButton(
              backgroundColor: Colors.transparent,
              width: 25,
              height: 25,
              image: 'assets/images/mine/mine_customer_service.png',
              imageW: 25,
              imageH: 25,
              onPressed: () => controller.pushAction(1001),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 22),
              child: CustomButton(
                backgroundColor: Colors.transparent,
                width: 25,
                height: 25,
                image: 'assets/images/mine/mine_message.png',
                imageW: 25,
                imageH: 25,
                onPressed: () => controller.pushAction(1002),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                Map _item = controller.data[index];
                if (index == 0) {
                  return _buildHeadRow();
                }
                return Container(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 7),
                  color: Color(0xFFF3F3F3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomCell(
                      leftImgPath: _item['imageName'],
                      title: _item['title'],
                      hiddenLine: true,
                      clickCallBack: () => controller.pushAction(index),
                    ),
                  ),
                );
              }, childCount: controller.data.length),
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
                    onPressed: () => controller.pushAction(1003),
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
                  child: Offstage(
                      offstage: !(Get.find<UserController>()
                          .userInfo
                          .value
                          .member!
                          .isVehicle!),
                      child: Image.asset(
                        'assets/images/mine/vip_tag.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      )),
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
                        tag: 'mine',
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
                            .isSales!,
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
            Container(
              margin: const EdgeInsets.only(
                  left: 25, top: 10, right: 25, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildFourBtn(
                      1005,
                      Obx(() => Text(
                            controller.favorModel.value.circleNum.toString(),
                            style: TextStyle(fontSize: 12),
                          )),
                      title: '圈子',
                      image: 'assets/images/mine/mine_circle_moment.png'),
                  _buildFourBtn(
                      1006,
                      Obx(() => Text(
                            controller.favorModel.value.collectionNum
                                .toString(),
                            style: TextStyle(fontSize: 12),
                          )),
                      title: '收藏',
                      image: 'assets/images/mine/mine_favor.png'),
                  _buildFourBtn(
                      1007,
                      Obx(() => Text(
                            Get.find<UserController>()
                                .userInfo
                                .value
                                .huodongData
                                .toString(),
                            style: TextStyle(fontSize: 12),
                          )),
                      title: '活动',
                      image: 'assets/images/mine/mine_activity.png'),
                  _buildFourBtn(
                      1008,
                      Obx(() => Text(
                            TextUtil.formatComma3(Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .integral!),
                            style: TextStyle(fontSize: 12),
                          )),
                      title: '积分',
                      image: 'assets/images/mine/mine_point.png'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFourBtn(int index, Widget child,
      {String? title, String? image}) {
    return GestureDetector(
      onTap: () => controller.pushAction(index),
      child: Container(
        width: (Get.width - 72.5) / 4,
        height: (Get.width - 72.5) * 2 / 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title!,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            Image.asset(
              image!,
              width: 36,
              height: 36,
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
