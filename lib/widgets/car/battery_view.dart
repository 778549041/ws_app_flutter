import 'package:flutter/material.dart';

class BatteryView extends StatelessWidget {
  final double percent;
  final double width;
  final double height;
  final bool isCharging;

  BatteryView(
      {this.percent = 100,
      this.width = 40,
      this.height = 15,
      this.isCharging = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: CustomPaint(
            size: Size(width, height),
            painter:
                BatteryViewPainter(percent: percent, isCharging: isCharging),
          ),
        ),
      ],
    );
  }
}

class BatteryViewPainter extends CustomPainter {
  final double percent;
  final Paint mPaint;
  final double mStrokeWidth;
  final double mPaintStrokeWidth;
  final bool isCharging;

  BatteryViewPainter(
      {this.percent = 100,
      this.mStrokeWidth = 1.0,
      this.mPaintStrokeWidth = 1.5,
      this.isCharging = false})
      : mPaint = Paint()..strokeWidth = mPaintStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    // 电池框位置
    double batteryLeft = 0;
    double batteryTop = 0;
    double batteryRight = size.width - mStrokeWidth;
    double batteryBottom = size.height;

    //电池头位置
    double batteryHeadLeft = batteryRight;
    double batteryHeadTop = size.height / 4;
    double batteryHeadRight = size.width;
    double batteryHeadBottom = batteryHeadTop + (size.height / 2);

    //电量位置
    double electricQuantityTotalWidth = size.width - 5 * mStrokeWidth;
    double electricQuantityLeft = batteryLeft + 2 * mStrokeWidth;
    double electricQuantityTop = batteryTop + 2 * mStrokeWidth;
    double electricQuantityRight =
        electricQuantityLeft + electricQuantityTotalWidth * percent;
    double electricQuantityBottom = size.height - 2 * mStrokeWidth;

    mPaint.style = PaintingStyle.stroke;
    mPaint.color = Colors.blue;

    //画电池框
    canvas.drawRRect(
        RRect.fromLTRBR(batteryLeft, batteryTop, batteryRight, batteryBottom,
            Radius.circular(mStrokeWidth)),
        mPaint);

    //画电池头
    canvas.drawRRect(
        RRect.fromLTRBR(batteryHeadLeft, batteryHeadTop, batteryHeadRight,
            batteryHeadBottom, Radius.circular(mStrokeWidth)),
        mPaint);

    mPaint.style = PaintingStyle.fill;
    mPaint.color = Colors.green;
    //画电池电量
    canvas.drawRRect(
        RRect.fromLTRBR(
            electricQuantityLeft,
            electricQuantityTop,
            electricQuantityRight,
            electricQuantityBottom,
            Radius.circular(mStrokeWidth)),
        mPaint);

    //画充电中闪电图标
    if (isCharging) {
      mPaint.style = PaintingStyle.fill;
      mPaint.color = Colors.white;
      canvas.drawPath(
          Path()
            ..moveTo(size.width / 2 + 2, 0) //顶点
            ..lineTo(size.width / 2 - 6, size.height / 2 + 1) //左边第一个点
            ..lineTo(size.width / 2 - 2, size.height / 2 + 1) //左边第二个点
            ..lineTo(size.width / 2 - 2, size.height) //底点
            ..lineTo(size.width / 2 + 6, size.height / 2 - 1) //右边第一个点
            ..lineTo(size.width / 2 + 2, size.height / 2 - 1) //右边第二个点
            ..lineTo(size.width / 2 + 2, 0), //顶点
          mPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
