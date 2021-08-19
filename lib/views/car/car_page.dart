import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/car/control_loading_view.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
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
        Positioned(
          left: 20,
          top: 100,
          right: 20,
          child: ControlLoadingView(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    if (Get.find<UserController>().userInfo.value.member!.isVehicle!) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                //头像
                GestureDetector(
                  onTap: () => controller.buttonAction(1004),
                  child: Stack(
                    children: <Widget>[
                      Obx(() => RoundAvatar(
                            imageUrl: Get.find<UserController>()
                                .userInfo
                                .value
                                .member
                                ?.headImg,
                            borderWidth: 0,
                            borderColor: Colors.transparent,
                            height: 40,
                          )),
                      Positioned(
                        bottom: 0,
                        right: 0,
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
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Obx(() => Text(
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
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                )),
                //销售员或者勋章标签
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
                              .isSales! ==
                          1,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Obx(() => CustomButton(
                  backgroundColor: Colors.transparent,
                  image: 'assets/images/circle/enjoy_point.png',
                  imageH: 18,
                  imageW: 18,
                  title: TextUtil.formatComma3(Get.find<UserController>()
                      .userInfo
                      .value
                      .member!
                      .integral!),
                  titleColor: Colors.white,
                  fontSize: 12,
                  onPressed: () => controller.buttonAction(1006),
                )),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '您还未认证车主信息',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                CustomButton(
                  backgroundColor: Colors.transparent,
                  width: 80,
                  height: 34,
                  image: 'assets/images/car/car_icon_unstand_ve.png',
                  imageW: 80,
                  imageH: 34,
                  onPressed: () => controller.buttonAction(1007),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomButton(
                    backgroundColor: Colors.transparent,
                    width: 80,
                    height: 34,
                    image: 'assets/images/car/car_icon_certify_now.png',
                    imageW: 80,
                    imageH: 34,
                    onPressed: () => controller.buttonAction(1008),
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _buildBody() {
    if (Get.find<UserController>().userInfo.value.member!.isVehicle!) {
      return OwnCarWidget();
    } else {
      return UnOwnCarWidget();
    }
  }
}
