import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedalToastWidget extends StatelessWidget {
  final String imageName;
  final bool isSales;
  final Rect rect;//widget宽高
  final Offset offset;//widget在屏幕上的坐标

  MedalToastWidget({this.imageName, this.isSales, this.rect, this.offset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
          ),
          Positioned(
            left: 20,
            top: 100,
            child: _buildChild(),
          ),
        ],
      ),
    );
  }

  Widget _buildChild() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }
}
