import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/faq_publish_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class FAQPublishPage extends GetView<FAQPublishController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '发圈子',
      rightItems: <Widget>[
        CustomButton(
          backgroundColor: Colors.transparent,
          height: 30,
          title: '发布',
          titleColor: Colors.white,
          onPressed: () => controller.publishQuestion(),
        ),
        SizedBox(
          width: 10,
        ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 200,
              child: TextField(
                controller: controller.textEditingController,
                focusNode: controller.focusNode,
                maxLength: 5000,
                maxLines: 10,
                style: TextStyle(fontSize: 15),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入您的问题...',
                    hintStyle: TextStyle(
                        fontSize: 15, color: MainAppColor.secondaryTextColor),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 8)),
                onChanged: (value) => controller.onInputChange(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
