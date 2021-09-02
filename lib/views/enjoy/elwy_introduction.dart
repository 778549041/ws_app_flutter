import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/global/video_play_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class ElwyIntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'e路无忧简介',
      bgColor: MainAppColor.mainSilverColor,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.to(
                          () => VideoPalyPage(
                                videoUrl:
                                    'https://wsmedia.ghac.cn/eluwuyou.mp4',
                              ),
                          transition: Transition.fadeIn);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        NetImageWidget(
                          imageUrl:
                              'https://wsmedia.ghac.cn/eluwuyou.mp4?vframe/jpg/offset/3',
                          height: 194,
                          fit: BoxFit.cover,
                        ),
                        Image.asset('assets/images/circle/circle_play.png',
                            width: 100, height: 100, fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_1.jpg',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_2.gif',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_3.jpg',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_4.gif',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_5.jpg',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_6.jpg',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_7.gif',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_8.jpg',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_9.gif',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_10.jpg',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_11.gif',
                          width: double.infinity,
                        ),
                        Image.asset(
                          'assets/images/enjoy/elwy_intro_12.jpg',
                          width: double.infinity,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: (Get.width - 170) / 2,
            bottom: 30,
            child: CustomButton(
              width: 170,
              height: 40,
              radius: 20,
              backgroundColor: Color(0xFF4245E5),
              title: '去兑换',
              titleColor: Colors.white,
              onPressed: () {
                Get.toNamed(Routes.ELWYEXCHANGELIST);
              },
            ),
          )
        ],
      ),
    );
  }
}
