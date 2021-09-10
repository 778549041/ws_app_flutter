import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/common_question_model.dart';
import 'package:ws_app_flutter/view_models/mine/common_question_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CommonQuestionPage extends GetView<CommonQuController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '常见问题',
      child: Obx(
        () => ListView.builder(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            itemCount: controller.list.length > 0
                ? controller.list.length + 2
                : controller.list.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    '亲，您是遇到什么困难的地方了吗？让我来猜猜您遇到的问题是什么吧...',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else if (index == controller.list.length + 1) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    '如果未能解决您的问题\n您可以发邮件到我们的邮箱反馈:VE-1@ghac.cn',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                return _buildQuestionRow(index);
              }
            }),
      ),
    );
  }

  Widget _buildQuestionRow(int index) {
    SingleQuestion question = controller.list[index - 1];
    late String indexStr;
    if (index > 10) {
      indexStr = index.toString();
    } else {
      indexStr = '0' + index.toString();
    }
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: false,
          ),
          header: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/mine/question.png',
                width: 18,
                height: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  indexStr + '.' + question.questions!,
                  style: TextStyle(color: Color(0xFF4245E5)),
                ),
              ),
              ExpandableIcon(
                theme: const ExpandableThemeData(
                  expandIcon: Icons.arrow_drop_down,
                  collapseIcon: Icons.arrow_drop_up,
                  iconColor: Color(0xFF4245E5),
                  iconSize: 30,
                  iconRotationAngle: math.pi / 2,
                  iconPadding: EdgeInsets.only(left: 5, right: 5),
                  hasIcon: false,
                ),
              ),
              Offstage(
                offstage: question.filePath == null,
                child: CustomButton(
                  title: 'docx',
                  width: 40,
                  height: 20,
                  onPressed: () => controller.pushH5Page(args: {
                    'url': question.filePath,
                    'hasNav': true,
                  }),
                ),
              ),
            ],
          ),
          collapsed: Container(),
          expanded: Container(
            margin: const EdgeInsets.only(left: 30),
            child: Text(question.answer!),
          ),
        ),
      ),
    );
  }
}
