import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class BasePage extends StatelessWidget {
  final Widget child; //body
  final String title; //标题
  final Widget titleWidget; //标题组件
  final double fontSize; //标题字体大小
  final Color titleColor; //标题字体颜色
  final Color navBackgroundColor; //导航栏背景色
  final Color bgColor; //整体界面背景色
  final bool showAppBar; //是否展示appbar
  final bool isBack; //左边是否是返回按钮
  final Widget leftItem; //左边组件
  final VoidCallback leftCallBack; //左边按钮事件
  final List<Widget> rightActions; //右边按钮集合

  BasePage(
      {@required this.child,
      this.title,
      this.titleWidget,
      this.fontSize = 22,
      this.titleColor = Colors.white,
      this.isBack = true,
      this.navBackgroundColor = Colors.transparent,
      this.bgColor = Colors.white,
      this.showAppBar = true,
      this.leftItem,
      this.leftCallBack,
      this.rightActions});

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
        Scaffold(
          //整体页面背景色
          backgroundColor: Colors.transparent,
          //根据是否展示appbar的标签来判断是否展示导航栏
          appBar: showAppBar
              ? AppBar(
                  //标题组件是否外部有定义，如果有，用外部传入的组件，如果没有判断是否有标题，有标题直接显示标题text组件，没有不显示
                  title: titleWidget != null
                      ? titleWidget
                      : (title != null
                          ? Text(title,
                              style: TextStyle(
                                  fontSize: fontSize, color: titleColor))
                          : null),
                  centerTitle: true,
                  //导航栏背景色
                  backgroundColor: navBackgroundColor,
                  //z轴高度，设置导航栏背景透明时需要设置此值为0
                  elevation: 0,
                  //根据isback标签判断左边是展示外部传入的自定义组件还是默认组件，默认为返回按钮
                  leading: isBack == false
                      ? leftItem
                      : CustomButton(
                          backgroundColor: Colors.transparent,
                          clickInterval: 0,
                          width: 57,
                          height: 40,
                          image: 'assets/images/common/nav_back_with_title.png',
                          imageW: 47,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                  actions: rightActions,
                )
              : null,
          body: Container(
            width: Get.width,
            height: showAppBar ? (Get.height -
                ScreenUtil.getInstance().appBarHeight -
                ScreenUtil.getInstance().statusBarHeight) : Get.height,
            margin: EdgeInsets.only(top: 0, bottom: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(showAppBar ? 10 : 0),
                    topRight: Radius.circular(showAppBar ? 10 : 0)),
                color: bgColor),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(showAppBar ? 10 : 0), topRight: Radius.circular(showAppBar ? 10 : 0)),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
