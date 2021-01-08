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
  final double width; //按钮宽度
  final double height; //按钮高度
  final Color backgroundColor; //按钮背景色(与渐变背景只能设置一个)
  final Gradient gradient; //渐变背景色(与背景色只能设置一个)
  final double radius; //圆角
  final Color borderColor; //边框颜色
  final double borderWidth; //边框宽度
  final XJImagePosition imagePosition; //图片位置

  final String image; //图片
  final double imageW; //图片宽度
  final double imageH; //图片高度

  final String title; //标题
  final double fontSize; //标题字体大小
  final Color titleColor; //标题颜色

  final VoidCallback onPressed; //点击事件

  CustomButton(
      {Key key,
      this.disabled = false,
      this.width = 170,
      this.height = 40,
      this.backgroundColor = Colors.white,
      this.gradient,
      this.radius = 0,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0,
      this.imagePosition = XJImagePosition.XJImagePositionLeft,
      this.image,
      this.imageW,
      this.imageH,
      this.title,
      this.fontSize = 15,
      this.titleColor = Colors.black,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: disabled ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: borderWidth, color: borderColor),
          color: disabled ? Colors.grey : backgroundColor,
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
