import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bubble/bubble_widget.dart';
import 'package:get/get.dart';

class MedalToastWidget extends StatelessWidget {
  final String imageName;
  final bool isSales;
  final Rect rect; //widget宽高
  final Offset offset; //widget在屏幕上的坐标

  MedalToastWidget({this.imageName, this.isSales, this.rect, this.offset});

  @override
  Widget build(BuildContext context) {
    double leftP, topP, arrowPadding,width,height;
    BubbleArrowDirection direction = BubbleArrowDirection.top;
    if (isSales) {
      leftP = (Get.width - 280) / 2;
      width = 280.0;
      height = 130.0;
    } else {
      leftP = (Get.width - ScreenUtil.getInstance().getWidth(295)) / 2;
      width = ScreenUtil.getInstance().getWidth(295);
      height = ScreenUtil.getInstance().getWidth(135);
    }
    arrowPadding = offset.dx + rect.size.width / 2 - leftP - 15;
    topP = offset.dy + rect.size.height / 2;
    if (offset.dy + rect.size.height / 2 > Get.height / 2) {
      direction = BubbleArrowDirection.bottom;
      arrowPadding = width + leftP - offset.dx + rect.size.width / 2 - leftP - 10;
      if (isSales) {
        topP = offset.dy - 120 - 20;
      } else {
        topP = offset.dy - ScreenUtil.getInstance().getWidth(135) - 20;
      }
    }
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
          ),
          Positioned(
            left: leftP,
            top: topP,
            child: BubbleWidget(
              width,
              height,
              Colors.red,
              direction,
              length: arrowPadding,
              innerPadding: 0.0,
              strokeWidth: 0.0,
              child: _buildChild(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild() {
    if (isSales) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 4,
                color: Color.fromARGB(20, 0, 0, 0))
          ],
        ),
        width: 280,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/mine/sales_tag_big.png',
                  width: 32.5,
                  height: 26.5,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Text(
                  '广汽Honda特约店销售顾问',
                  style: TextStyle(color: Color(0xFF1C7BF0), fontSize: 15),
                )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '售前咨询、售后服务及金融政策解答',
              style: TextStyle(color: Colors.black, fontSize: 11),
            ),
          ],
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              spreadRadius: 4,
              color: Color.fromARGB(20, 0, 0, 0))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imageName,
          fit: BoxFit.cover,
          width: ScreenUtil.getInstance().getWidth(295),
          height: ScreenUtil.getInstance().getWidth(135),
        ),
      ),
    );
  }
}
