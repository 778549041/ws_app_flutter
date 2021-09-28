import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class MedalToastWidget extends StatelessWidget {
  final String? imageName;
  final bool? isSales;
  final VoidCallback? onpressed;

  MedalToastWidget({this.imageName, this.isSales, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    if (isSales!) {
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
          imageName!,
          fit: BoxFit.cover,
          width: ScreenUtil.getInstance().getWidth(295),
          height: ScreenUtil.getInstance().getWidth(135),
        ),
      ),
    );
  }
}
