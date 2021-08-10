import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/feedback_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class FeedBackPage extends GetView<FeedBackController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '意见反馈',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '请输入您要反馈的内容',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.msgController,
              maxLines: 10,
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 15),
              inputFormatters: [LengthLimitingTextInputFormatter(500)],
              onSubmitted: (value) {
                Get.focusScope?.requestFocus(controller.mobileFocusNode);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '请输入您的手机号',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.mobileController,
              style: TextStyle(fontSize: 15, color: Color(0xFFD6D6D6)),
              inputFormatters: [LengthLimitingTextInputFormatter(11)],
              focusNode: controller.mobileFocusNode,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: Get.find<UserController>().userInfo.value.member!.mobile!.replaceRange(3, 7, '****'),
                hintStyle: TextStyle(color: Color(0xFFD6D6D6)),
                contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: CustomButton(
                backgroundColor: Color(0xFF1C7AF4),
                width: 140,
                height: 40,
                title: '提交',
                titleColor: Colors.white,
                radius: 20,
                onPressed: () => controller.submitted(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
