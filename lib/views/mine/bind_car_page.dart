import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/bind_car_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/form_Input_cell.dart';

class BindCarPage extends GetView<BindCarController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '车辆绑定',
      child: CustomScrollView(
        slivers: [
          Obx(() => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (index == 5) {
                  return _buildSubmitButton();
                } else {
                  return _buildInputRow(index);
                }
              }, childCount: controller.data.length + 1))),
        ],
      ),
    );
  }

  Widget _buildInputRow(int index) {
    return FormInputCell(
      enabled: index != 4,
      title: controller.data[index]['title'],
      text: controller.data[index]['content'],
      hintText: controller.data[index]['placeholder'],
      textAlign: TextAlign.right,
      inputCallBack: (value) => controller.inputAction(index, value),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Center(
        child: CustomButton(
          backgroundColor: MainAppColor.mainBlueBgColor,
          width: 180,
          height: 40,
          title: '提交',
          titleColor: Colors.white,
          radius: 20,
          onPressed: () => controller.submitAction(),
        ),
      ),
    );
  }
}
