//自定义按钮
import 'package:flutter/material.dart';

enum XJImagePosition {
  XJImagePositionLeft,
  XJImagePositionRight,
  XJImagePositionTop,
  XJImagePositionBottom,
}

class CustomButton extends StatelessWidget {
  final bool disabled; //禁用点击
  final Color disabledColor; //禁用时背景色
  final double width; //按钮宽度
  final double height; //按钮高度
  final Color backgroundColor; //按钮背景色(与渐变背景只能设置一个)
  final Gradient gradient; //渐变背景色(与背景色只能设置一个)
  final double radius; //圆角
  final Color borderColor; //边框颜色
  final double borderWidth; //边框宽度
  final XJImagePosition imagePosition; //图片位置
  final double blurRadius; //设置阴影
  final double spreadRadius; //设置阴影
  final int shadowColorA; //设置阴影

  final String image; //图片
  final double imageW; //图片宽度
  final double imageH; //图片高度

  final String title; //标题
  final double fontSize; //标题字体大小
  final Color titleColor; //标题颜色

  final int clickInterval; //点击时间间隔
  final VoidCallback onPressed; //点击事件

  CustomButton(
      {Key key,
      this.disabled = false,
      this.disabledColor = const Color(0xFFCCCCCC),
      this.width,
      this.height,
      this.backgroundColor = Colors.white,
      this.gradient,
      this.radius = 0,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0,
      this.imagePosition = XJImagePosition.XJImagePositionLeft,
      this.blurRadius = 0,
      this.spreadRadius = 0,
      this.shadowColorA = 0,
      this.image,
      this.imageW,
      this.imageH,
      this.title,
      this.fontSize = 15,
      this.titleColor = Colors.black,
      this.clickInterval = 3,
      this.onPressed})
      : super(key: key);

  var lastClickTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: disabled
          ? null
          : () {
              // 防重复提交
              if (lastClickTime == null ||
                  DateTime.now().difference(lastClickTime) >
                      Duration(seconds: clickInterval)) {
                lastClickTime = DateTime.now();
                onPressed();
              } else {
                // lastClickTime = DateTime.now(); //如果不注释这行,则强制用户一定要间隔2s后才能成功点击. 而不是以上一次点击成功的时间开始计算.
              }
            },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                color: Color.fromARGB(shadowColorA, 0, 0, 0))
          ],
          border: Border.all(width: borderWidth, color: borderColor),
          color: disabled ? disabledColor : backgroundColor,
          gradient: gradient,
        ),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (imagePosition == XJImagePosition.XJImagePositionLeft) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (this.image != null) _buildIcon(),
          if (this.title != null) _buildTitle(),
        ],
      );
    } else if (imagePosition == XJImagePosition.XJImagePositionRight) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (this.title != null) _buildTitle(),
          if (this.image != null) _buildIcon(),
        ],
      );
    } else if (imagePosition == XJImagePosition.XJImagePositionTop) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (this.image != null) _buildIcon(),
          if (this.title != null) _buildTitle(),
        ],
      );
    } else if (imagePosition == XJImagePosition.XJImagePositionBottom) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (this.title != null) _buildTitle(),
          if (this.image != null) _buildIcon(),
        ],
      );
    }
    return Container(
      width: 0,
      height: 0,
    );
  }

  //图标
  Widget _buildIcon() {
    return Image.asset(
      image,
      fit: BoxFit.contain,
      width: imageW,
      height: imageH,
    );
  }

  //标题
  Widget _buildTitle() {
    return Text(
      title,
      style: TextStyle(fontSize: fontSize, color: titleColor),
    );
  }
}
