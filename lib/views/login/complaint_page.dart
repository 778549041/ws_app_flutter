import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/login/complaint_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ComplaintPage extends GetView<ComplaintController> {
  final String province = Get.arguments['province'];
  final String city = Get.arguments['city'];
  final String store = Get.arguments['store'];
  final String name = Get.arguments['name'];
  final String vincode = Get.arguments['vincode'];

  @override
  Widget build(BuildContext context) {
    controller.province = province;
    controller.city = city;
    controller.store = store;
    controller.name = name;
    controller.vincode = vincode;

    return BasePage(
      title: '车主申述',
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  '请确认您的车主信息',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else if (index == 8) {
              return _buildSubmitButton();
            } else if (index == 7) {
              return Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '申诉说明',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 200,
                      child: TextField(
                        maxLength: 200,
                        maxLengthEnforced: true,
                        maxLines: 20,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        onChanged: (String input) {
                          controller.inputStr = input;
                        },
                        decoration: InputDecoration(
                          hintText: '请输入申述内容，最多200字',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return _buildCommonRow(index);
            }
          },
        ),
      ),
    );
  }

  Widget _buildCommonRow(int index) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            child: Text(
              controller.data[index]['title'],
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          Container(
            width: ScreenUtil.getInstance().screenWidth - 140,
            height: 40,
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.data[index]['content'],
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 50),
      child: Center(
        child: CustomButton(
          backgroundColor: MainAppColor.mainBlueBgColor,
          width: 180,
          height: 40,
          title: '确定提交',
          titleColor: Colors.white,
          radius: 20,
          onPressed: () => controller.submitAction(),
        ),
      ),
    );
  }
}
