import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/car/medal_toast_widget.dart';

class MedalWidget extends StatelessWidget {
  final String? tag;
  final String? medalBtnImage;
  final String? medalToastImage;
  final bool? isSales;

  MedalWidget({
    this.tag,
    this.medalBtnImage,
    this.medalToastImage,
    this.isSales,
  });

  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      child: Image.asset(
        medalBtnImage!,
        width: 30,
        height: 30,
        fit: BoxFit.contain,
      ),
      arrowSize: 15,
      arrowColor: MainAppColor.secondaryTextColor,
      verticalMargin: 0,
      menuBuilder: () => MedalToastWidget(
        imageName: medalToastImage,
        isSales: isSales,
        onpressed: () {
          _controller.hideMenu();
          if (Get.find<UserController>()
                  .userInfo
                  .value
                  .member!
                  .memberInfo!
                  .isSales! &&
              Get.find<UserController>()
                  .userInfo
                  .value
                  .member!
                  .memberInfo!
                  .isEnd!) {
            Get.toNamed(Routes.WEBVIEW, arguments: {
              'url': Get.find<UserController>()
                  .userInfo
                  .value
                  .member!
                  .memberInfo!
                  .hrefUrl
            });
          }
        },
      ),
      pressType: PressType.singleClick,
      controller: _controller,
    );
  }
}
