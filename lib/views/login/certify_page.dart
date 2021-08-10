import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/login/certify_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/form_Input_cell.dart';
import 'package:ws_app_flutter/widgets/global/form_select_cell.dart';

class CertifyPage extends GetView<CertifyController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '车主认证',
      child: CustomScrollView(
        slivers: [
          Obx(() => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (index == 5) {
                  return _buildSubmitButton();
                } else if (index == 0 || index == 1 || index == 2) {
                  return _buildSelectRow(index);
                } else {
                  return _buildInputRow(index);
                }
              }, childCount: controller.data.length + 1))),
        ],
      ),
    );
  }

  Widget _buildSelectRow(int index) {
    return FormSelectCell(
      title: controller.data[index]['title'],
      hintText: '',
      hintTextStyle: TextStyle(fontSize: 15),
      hiddenArrow: true,
      textAlign: TextAlign.right,
      rightWidget: Row(
        children: <Widget>[
          Text(
            controller.data[index]['content'],
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            width: 5,
          ),
          Image.asset(
            'assets/images/mine/icon_down_arrow.png',
            width: 10.5,
            height: 19.5,
          ),
        ],
      ),
      clickCallBack: () => controller.selectData(index),
    );
  }

  Widget _buildInputRow(int index) {
    return FormInputCell(
      maxLength: index == 4 ? 17 : 0,
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
          title: '确定提交',
          titleColor: Colors.white,
          radius: 20,
          onPressed: () => controller.submitAction(),
        ),
      ),
    );
  }
}
