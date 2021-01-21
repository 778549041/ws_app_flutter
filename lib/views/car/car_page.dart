import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/widgets/car/own_car.dart';
import 'package:ws_app_flutter/widgets/car/unown_car.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CarPage extends GetView<CarController> {
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
        Positioned(
          top: ScreenUtil.getInstance().statusBarHeight + 60,
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
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight,
              left: 15,
              right: 15),
          width: Get.width,
          height: 60,
          child: _buildHeader(),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight + 60),
          width: Get.width,
          child: _buildBody(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    if (controller.userInfo.value.member.isVehicle == 'true') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                //头像
                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: <Widget>[
                      Obx(() => RoundAvatar(
                            imageUrl: controller.userInfo.value.member.headImg,
                            borderWidth: 0,
                            borderColor: Colors.transparent,
                            height: 40,
                          )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Offstage(
                            offstage:
                                !(controller.userInfo.value.member.isVehicle ==
                                    'true'),
                            child: Image.asset(
                              'assets/images/mine/vip_tag.png',
                              width: 18,
                              height: 18,
                              fit: BoxFit.cover,
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Obx(() => Text(
                        (controller.userInfo.value.member.uname.length > 11)
                            ? controller.userInfo.value.member.uname
                                .substring(0, 11)
                            : controller.userInfo.value.member.uname,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                ),
                //销售员或者勋章标签
                if (controller.userInfo.value.member.memberInfo.showTag)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Obx(() => CustomButton(
                          backgroundColor: Colors.transparent,
                          width: 30,
                          height: 30,
                          image: controller.userInfo.value.member.memberInfo
                              .medalOrSaleImageName,
                          onPressed: () {},
                        )),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Obx(() => CustomButton(
                  backgroundColor: Colors.transparent,
                  image: 'assets/images/circle/enjoy_point.png',
                  imageH: 18,
                  imageW: 18,
                  title: TextUtil.formatComma3(
                      controller.userInfo.value.member.integral),
                  titleColor: Colors.white,
                  fontSize: 12,
                  onPressed: () {},
                )),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildBody() {
    if (controller.userInfo.value.member.isVehicle == 'true') {
      return OwnCarWidget();
    } else {
      return UnOwnCarWidget();
    }
  }
}
