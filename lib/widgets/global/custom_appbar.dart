import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final double height;
  final List<Widget> leftButtons;
  final Widget title;
  final List<Widget> rightButtons;

  CustomAppBar({this.height, this.leftButtons, this.title, this.rightButtons});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? ScreenUtil.getInstance().appBarHeight,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
              child: Row(
            children: List.generate(
              leftButtons.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: leftButtons[index],
              ),
            ),
          )),
          Flexible(
            flex: 2,
            child: title,
          ),
          Flexible(
              child: Row(
            children: List.generate(
              rightButtons.length,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 5),
                child: rightButtons[index],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
