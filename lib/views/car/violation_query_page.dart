import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/car/violation_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/form_Input_cell.dart';

class ViolationQueryPage extends GetView<ViolationController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '违章查询',
      child: CustomScrollView(
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == controller.data.length) {
                  return _buildBtnRow();
                } else {
                  return _buildItem(index);
                }
              }, childCount: controller.data.length + 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    return FormInputCell(
      enabled: index == 0 ? false : true,
      title: controller.data[index]['title'],
      text: controller.data[index]['content'],
      hintText: controller.data[index]['placeholder'],
      textAlign: TextAlign.right,
      inputCallBack: (value) => controller.inputAction(index, value),
    );
  }

  Widget _buildBtnRow() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Center(
        child: CustomButton(
          backgroundColor: Color(0xFF4245E5),
          width: 180,
          height: 40,
          title: '查询',
          titleColor: Colors.white,
          radius: 20,
          onPressed: () => controller.submitAction(),
        ),
      ),
    );
  }
}
