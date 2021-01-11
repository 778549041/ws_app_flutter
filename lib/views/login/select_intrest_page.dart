import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/select_intrest_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class SelectIntrestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/common/bg.png',
              width: Get.width,
              height: Get.height / 2,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: ScreenUtil.getInstance().statusBarHeight + 32,
              right: 10,
              child: CustomButton(
                width: 60,
                height: 30,
                backgroundColor: Colors.transparent,
                title: '跳过',
                titleColor: Colors.white,
                imagePosition: XJImagePosition.XJImagePositionRight,
                image: 'assets/images/common/right_arrow_white.png',
                imageH: 30,
                imageW: 10,
                onPressed: () {
                  Get.find<SelectIntreController>().jumpToNext();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight + 72),
              width: Get.width,
              height: Get.height - (ScreenUtil.getInstance().statusBarHeight + 72),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        '选择您喜欢的内容',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '至少选择两个，不多于五个',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    GetBuilder<SelectIntreController>(
                      builder: (controller) {
                        return Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 30,
                          children: List.generate(controller.allIntres.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectItem(index);
                              },
                              child: Container(
                                width: 80,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.allIntres[index].selected
                                      ? Color(0xFF4245E5)
                                      : Colors.transparent,
                                  border: Border.all(
                                      width:
                                          controller.allIntres[index].selected
                                              ? 0
                                              : 1,
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  controller.allIntres[index].name,
                                  style: TextStyle(
                                    color: controller.allIntres[index].selected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    CustomButton(
                      backgroundColor: Color(0xFF4245E5),
                      width: 200,
                      height: 44,
                      radius: 22,
                      title: '保存',
                      titleColor: Colors.white,
                      onPressed: () {
                        Get.find<SelectIntreController>().saveIntres();
                      },
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
