import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/splash/splash_controller.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class SplashPage extends GetView<SplashController> {
  final List<String> _guideImageList = [
    'assets/images/guide/wow_guide.jpg',
    'assets/images/guide/circle_guide.jpg',
    'assets/images/guide/car_guide.jpg',
    'assets/images/guide/enjoy_guide.jpg',
    'assets/images/guide/mine_guide.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    if (controller.firstLaunch.value) {
      return Scaffold(
        body: Swiper(
          itemCount: _guideImageList.length,
          autoplay: false,
          loop: false,
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Image.asset(
                  _guideImageList[index],
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Offstage(
                  offstage: index != _guideImageList.length - 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                        bottom: ScreenUtil.getInstance().getWidth(100)),
                    child: CupertinoButton(
                      color: Color(0xFFE80016),
                      borderRadius: BorderRadius.circular(5),
                      onPressed: () => controller.goMain(),
                      child: Text(
                        '立即体验',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Obx(() => NetImageWidget(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: controller.splashModel.value.data?.url,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/splash/launch.png',
                )),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => controller.goMain(),
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1.0, color: Colors.white),
                  ),
                  child: Center(
                    child: Obx(
                      () => Text(
                        '跳过 ${controller.count}',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Offstage(
                offstage: (controller.splashModel.value.data?.showType != '2')
                    ? true
                    : false,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Stack(
                          children: <Widget>[
                            Obx(
                              () => RoundAvatar(
                                height: 90,
                                borderWidth: 3,
                                imageUrl: Get.find<UserController>()
                                        .userInfo
                                        .value
                                        .member!
                                        .headImg ??
                                    '',
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
                      ),
                      Obx(
                        () => Text(
                          Get.find<UserController>()
                                  .userInfo
                                  .value
                                  .member!
                                  .name ??
                              '',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '祝您工作顺利，生日快乐！',
                              style: TextStyle(color: Colors.white),
                            ),
                            Image.asset(
                              'assets/images/splash/birth_bg.png',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
