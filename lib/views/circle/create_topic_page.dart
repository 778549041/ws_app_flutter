import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/view_models/circle/create_topic_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';

class CreateTopicPage extends GetView<CreateTopicController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '创建话题',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '话题名称',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                    color: MainAppColor.seperatorLineColor, width: 0.5),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      inputFormatters: [LengthLimitingTextInputFormatter(15)],
                      decoration: InputDecoration(
                        hintText: '请输入话题名称',
                        hintStyle: TextStyle(
                          color: MainAppColor.secondaryTextColor,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Text(
                    '0/15',
                    style: TextStyle(
                      color: MainAppColor.secondaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '话题描述',
              style: TextStyle(fontSize: 15),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(
                    color: MainAppColor.seperatorLineColor, width: 0.5),
              ),
              child: CustomTextField(
                hintText: '请输入话题描述',
                showMaxLength: true,
                maxLength: 100,
                maxLines: 10,
                hintTextStyle: TextStyle(
                  color: MainAppColor.secondaryTextColor,
                  fontSize: 12,
                ),
                counterStyle: TextStyle(
                  color: MainAppColor.secondaryTextColor,
                  fontSize: 12,
                ),
                inputCallBack: (value) {},
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '选择话题标签',
              style: TextStyle(fontSize: 15),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: GetBuilder<CreateTopicController>(
                id: 'tagList',
                builder: (ctl) {
                  return Wrap(
                    spacing: 5,
                    runSpacing: 7,
                    children: List.generate(ctl.tagList.length, (index) {
                      CircleTagModel model = ctl.tagList[index];
                      return GestureDetector(
                        onTap: () {
                          ctl.selectTag(model);
                        },
                        child: Container(
                          width: (Get.width - 55) / 6,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: model.selected!
                                ? Color(0xFF1B7DF4)
                                : Colors.transparent,
                            border: model.selected!
                                ? null
                                : Border.all(
                                    width: 0.5,
                                    color: MainAppColor.seperatorLineColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            model.title!,
                            style: TextStyle(
                              color:
                                  model.selected! ? Colors.white : Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
