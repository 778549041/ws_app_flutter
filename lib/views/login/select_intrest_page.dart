import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/select_intrest_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class SelectIntrestPage extends GetView<SelectIntreController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      leftItem: controller.fromComplete ? Container() : null,
      title: !controller.fromComplete ? '设置标签' : '',
      rightItems: controller.fromComplete ? [_buildCompleteNextButton()] : null,
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
                  children: List.generate(controller.allIntres.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectItem(index);
                      },
                      child: Container(
                        width: 80,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.allIntres[index].selected!
                              ? Color(0xFF4245E5)
                              : Colors.transparent,
                          border: Border.all(
                              width:
                                  controller.allIntres[index].selected! ? 0 : 1,
                              color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          controller.allIntres[index].name!,
                          style: TextStyle(
                            color: controller.allIntres[index].selected!
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
    );
  }

  Widget _buildCompleteNextButton() {
    return CustomButton(
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
    );
  }
}
