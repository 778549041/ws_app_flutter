import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/change_area_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ChangeAreaPage extends GetView<ChangeAreaController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '现居地',
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => controller.selectAddress(),
              child: Container(
                margin: const EdgeInsets.only(left: 60, right: 60, top: 60),
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Color(0xFFD6D6D6))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Obx(() => Text(
                            controller.area.value.length == 0
                                ? '请选择省市区'
                                : controller.area.value,
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Image.asset(
                      'assets/images/mine/icon_down_arrow.png',
                      width: 14,
                      height: 8,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Color(0xFFD6D6D6))),
              margin: const EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: TextField(
                controller: controller.controller,
                maxLines: 10,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 15),
                inputFormatters: [LengthLimitingTextInputFormatter(500)],
                decoration: InputDecoration(
                  hintText: '请输入具体地址',
                  hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 15),
                  contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide:
                        BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide:
                        BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
                  ),
                ),
                onChanged: (value) {
                  controller.address.value = value;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              backgroundColor: Color(0xFF1C7AF4),
              width: 140,
              height: 40,
              title: '保存',
              titleColor: Colors.white,
              radius: 20,
              onPressed: () => controller.submitted(),
            ),
          ],
        ),
      ),
    );
  }
}
