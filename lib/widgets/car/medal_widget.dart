import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/car/medal_toast_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class MedalWidget extends StatelessWidget {
  final String tag;
  final String medalBtnImage;
  final String medalToastImage;
  final bool isSales;

  MedalWidget(
      {this.tag, this.medalBtnImage, this.medalToastImage, this.isSales});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      backgroundColor: Colors.transparent,
      width: 30,
      height: 30,
      image: medalBtnImage,
      onPressed: () {
        /// widget宽高。
        Rect rect = WidgetUtil.getWidgetBounds(context);
        print(rect);

        /// widget在屏幕上的坐标。
        Offset offset = WidgetUtil.getWidgetLocalToGlobal(context);
        print(offset);
        if (Get.find<UserController>()
                    .userInfo
                    .value
                    .member
                    .memberInfo
                    .isSales ==
                0 &&
            Get.find<UserController>().userInfo.value.member.memberInfo.isEnd !=
                1) {
          Get.toNamed(Routes.WEBVIEW, arguments: {
            'url': Get.find<UserController>()
                .userInfo
                .value
                .member
                .memberInfo
                .hrefUrl
          });
        } else {
          Get.dialog(
              MedalToastWidget(
                imageName: medalToastImage,
                isSales: isSales,
                rect: rect,
                offset: offset,
              ),
              barrierColor: Colors.transparent);
        }
      },
    );
  }
}
