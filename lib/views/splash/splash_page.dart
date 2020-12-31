import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/splash/splash_controller.dart';
import 'package:ws_app_flutter/widgets/round_avatar.dart';

class SplashPage extends StatelessWidget {
  final List<String> _guideImageList = [
    'assets/images/wow_guide.jpg',
    'assets/images/circle_guide.jpg',
    'assets/images/car_guide.jpg',
    'assets/images/enjoy_guide.jpg',
    'assets/images/mine_guide.jpg',
  ];

  Widget _buildSplashBg() {
    return Image.asset(
      'assets/images/launch.png',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetX<SplashController>(
      init: SplashController(),
      builder: (controller) {
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
                controller.splashModel.value.data.url.length > 0
                    ? CachedNetworkImage(
                        imageUrl: controller.splashModel.value.data.url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (context, url) => _buildSplashBg(),
                      )
                    : _buildSplashBg(),
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
                        child: Text(
                          '跳过 ${controller.count}',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: (controller.splashModel.value.data.showType != '2')
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
                              RoundAvatar(
                                height: ScreenUtil.getInstance().getWidth(78),
                                borderWidth: 3,
                                imageUrl: '',
                              ),
                              Positioned(
                                bottom: 2.0,
                                right: 2.0,
                                child: Image.asset(
                                  'assets/images/vip_tag.png',
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          '叫我军锅锅',
                          style: TextStyle(color: Colors.white),
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
                                'assets/images/birth_bg.png',
                                fit: BoxFit.cover,
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
      },
    );
  }
}
