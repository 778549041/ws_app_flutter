import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class BasePage extends StatelessWidget {
  final Widget child; //body
  final String? title; //标题
  final Widget? titleWidget; //标题组件
  final double fontSize; //标题字号
  final Color titleColor; //标题字体颜色
  final Color navBgColor; //导航栏背景色
  final Color bgColor; //界面整体背景色
  final bool showAppBar; //是否展示导航栏
  final Widget? leftItem; //左边按钮组件
  final List<Widget>? rightItems; //右边按钮集合
  final SystemUiOverlayStyle overlayStyle; //状态栏颜色

  BasePage({
    required this.child,
    this.title,
    this.titleWidget,
    this.fontSize = 22,
    this.titleColor = Colors.white,
    this.navBgColor = Colors.transparent,
    this.bgColor = Colors.white,
    this.showAppBar = true,
    this.leftItem,
    this.rightItems,
    this.overlayStyle = SystemUiOverlayStyle.light,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: Stack(
        children: <Widget>[
          //从屏幕最顶部开始的背景图
          Image.asset(
            'assets/images/common/bg.png',
            width: Get.width,
            height: Get.height / 2,
            fit: BoxFit.cover,
          ),
          //页面脚手架
          Scaffold(
            //整体设置为透明色
            backgroundColor: Colors.transparent,
            //需要则显示导航栏，否则不显示
            appBar: showAppBar
                ? AppBar(
                    //标题组件是否外部有定义，如果有，用外部传入的组件，如果没有判断是否有标题，有标题直接显示标题text组件，没有不显示
                    title: titleWidget != null
                        ? titleWidget
                        : (title != null
                            ? Text(
                                title!,
                                style: TextStyle(
                                    fontSize: fontSize, color: titleColor),
                              )
                            : null),
                    centerTitle: true,
                    //导航栏背景色
                    backgroundColor: navBgColor,
                    //z轴高度，设置导航栏背景透明时需要设置此值为0
                    elevation: 0,
                    //返回按钮宽度
                    leadingWidth: 80,
                    //如果leftItem不为空则显示外部传入的自定义组件，否则显示默认返回按钮
                    leading: leftItem != null
                        ? leftItem
                        : CustomButton(
                            backgroundColor: Colors.transparent,
                            clickInterval: 0,
                            width: 57,
                            height: 40,
                            image:
                                'assets/images/common/nav_back_with_title.png',
                            imageW: 47,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                    actions: rightItems,
                  )
                : null,
            //body用ClipRRect包起来进行圆角并裁剪,宽度为屏幕宽度，高度从导航栏下面开始计算到屏幕底部
            body: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(showAppBar ? 10 : 0),
                  topRight: Radius.circular(showAppBar ? 10 : 0)),
              child: Container(
                width: Get.width,
                height: showAppBar
                    ? (Get.height -
                        ScreenUtil.getInstance().statusBarHeight -
                        ScreenUtil.getInstance().appBarHeight)
                    : Get.height,
                color: bgColor,
                child: child,
              ),
            ),
          ),
        ],
      ),
      value: overlayStyle,
    );
  }
}
