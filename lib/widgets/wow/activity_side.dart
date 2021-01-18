import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/wow/activity_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ActivitySideWidget extends GetView<ActivityController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:Get.width - 165),
      width: 165,
      height: Get.height,
      color: Color(0xFF4345E5).withOpacity(0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 15),
            child: CustomButton(
              backgroundColor: Colors.transparent,
              width: 62,
              height: 35,
              title: '收起',
              titleColor: Colors.white,
              image: 'assets/images/common/right_arrow_white.png',
              imageH: 15,
              imageW: 10,
              imagePosition: XJImagePosition.XJImagePositionRight,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/wow/slide_wow.png',
                      width: 59,
                      height: 27,
                    ),
                    Text(
                      '活动',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40,top: 5),
                  height: 4,
                  width: 100,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    String _title = '全部';
    String _condition = 'all';
    if (index == 1) {
      _title = '未开始';
      _condition = 'nostart';
    } else if (index == 2) {
      _title = '进行中';
      _condition = 'ing';
    } else if (index == 3) {
      _title = '已结束';
      _condition = 'over';
    }
    return GestureDetector(
      onTap: () async {
        Get.back();
        controller.requestData(1, _condition);
      },
      child: Container(
        height: 50,
        child: Column(
          children: <Widget>[
            Container(
              height: 0.5,
              color: Colors.white,
            ),
            Container(
              height: 49,
              child: Center(
                child: Text(
                  _title,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
