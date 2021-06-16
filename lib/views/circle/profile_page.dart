import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/friend_circle_img_model.dart';
import 'package:ws_app_flutter/view_models/circle/profile_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '好友详情',
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Obx(
                  () => RoundAvatar(
                    imageUrl: controller.friendModel.value.member.avatar,
                    height: 80,
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Obx(
                              () => Text(
                                controller.friendModel.value.error != null
                                    ? '用户已注销'
                                    : controller.friendModel.value.member.name
                                                .length >
                                            0
                                        ? '昵称：${controller.friendModel.value.member.name.length > 11 ? controller.friendModel.value.member.name.substring(0, 10) : controller.friendModel.value.member.name}'
                                        : '无昵称',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          //销售员或者勋章标签
                          if (controller
                              .friendModel.value.member.memberInfo.showTag)
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: MedalWidget(
                                medalBtnImage: controller.friendModel.value
                                    .member.memberInfo.medalOrSaleImageName,
                                medalToastImage: controller.friendModel.value
                                    .member.memberInfo.medalOrSaleDescImageName,
                                isSales: controller.friendModel.value.member
                                        .memberInfo.isSales ==
                                    1,
                              ),
                            ),
                        ],
                      ),
                      Obx(
                        () => Text(
                          controller.friendModel.value.member.addr != null
                              ? '地区：${controller.friendModel.value.member.addr}'
                              : '地区：无',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color(0xFFD6D6D6),
              height: 0.5,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Text('感兴趣'),
                SizedBox(
                  width: 10,
                ),
                Obx(
                  () => Expanded(
                      child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                        controller.friendModel.value.member.interest.length,
                        (index) {
                      return Container(
                        width: 80,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MainAppColor.mainBlueBgColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          controller.friendModel.value.member.interest[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }),
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color(0xFFD6D6D6),
              height: 0.5,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: Text('圈   子'),
                ),
                SizedBox(
                  width: 10,
                ),
                Obx(
                  () => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => controller.buttonAction(1000),
                    child: Container(
                      height: 50,
                      width: Get.width - 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          FriendCircleImgModel item =
                              controller.friendCircleImgModel.value.list[index];
                          return Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 50,
                            height: 50,
                            child: Stack(
                              children: <Widget>[
                                NetImageWidget(
                                  imageUrl: item.type == '0'
                                      ? item.savepath
                                      : '${item.savepath}?vframe/jpg/offset/0',
                                  width: 50,
                                  height: 50,
                                ),
                                Positioned(
                                  left: 11.5,
                                  top: 11.5,
                                  child: Image.asset(
                                    'assets/images/circle/circle_play.png',
                                    width: 27,
                                    height: 27,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount:
                            controller.friendCircleImgModel.value.list.length,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/enjoy/enjoy_right_arrow.png',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Color(0xFFD6D6D6),
              height: 0.5,
            ),
            SizedBox(
              height: 100,
            ),
            Obx(
              () => Offstage(
                offstage: !controller.friendModel.value.member.isFriend,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: CustomButton(
                    backgroundColor: MainAppColor.secondaryTextColor,
                    title: '删除好友',
                    width: 200,
                    height: 40,
                    radius: 5,
                    titleColor: Colors.white,
                    onPressed: () => controller.buttonAction(1001),
                  ),
                ),
              ),
            ),
            Obx(
              () => Offstage(
                offstage: (controller.friendModel.value.error != null ||
                    controller.userId ==
                        controller.friendModel.value.member.memberId ||
                    controller.userId == '1'),
                child: CustomButton(
                  backgroundColor: MainAppColor.mainBlueBgColor,
                  title: controller.friendModel.value.member.isFriend
                      ? '发消息'
                      : '添加好友',
                  width: 200,
                  height: 40,
                  radius: 5,
                  titleColor: Colors.white,
                  onPressed: () => controller.buttonAction(1002),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
