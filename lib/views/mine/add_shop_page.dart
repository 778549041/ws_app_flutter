import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/add_shop_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/form_Input_cell.dart';
import 'package:ws_app_flutter/widgets/global/form_select_cell.dart';

class AddShopPage extends GetView<AddShopController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: controller.model.value == null ? '新增地址' : '编辑地址',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: <Widget>[
            FormInputCell(
              title: '姓名',
              text: controller.model.value.name,
              hintText: '请输入姓名',
              textAlign: TextAlign.right,
              inputCallBack: (value) {
                controller.model.value.name = value;
              },
            ),
            FormInputCell(
              title: '手机号',
              text: controller.model.value.mobile,
              hintText: '请输入手机号码',
              keyboardType: TextInputType.phone,
              maxLength: 11,
              textAlign: TextAlign.right,
              inputCallBack: (value) {
                controller.model.value.mobile = value;
              },
            ),
            FormSelectCell(
              title: '所在区域',
              hintText: '',
              hintTextStyle: TextStyle(fontSize: 15),
              hiddenArrow: true,
              textAlign: TextAlign.right,
              rightWidget: Row(
                children: <Widget>[
                  Obx(() => Text(
                        controller.area.value,
                        style: TextStyle(fontSize: 15),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/images/mine/mine_setting_right_arrow.png',
                    width: 10.5,
                    height: 19.5,
                  ),
                ],
              ),
              clickCallBack: () => controller.selectAddress(),
            ),
            FormInputCell(
              text: controller.model.value.addr,
              hintText: '详细地址如街道、门牌号等',
              textAlign: TextAlign.right,
              inputCallBack: (value) {
                controller.model.value.addr = value;
              },
            ),
            FormSelectCell(
              title: '设为默认地址',
              space: 120,
              hintText: '',
              hiddenArrow: true,
              rightWidget: Obx(() => CupertinoSwitch(
                    value: controller.isDefault.value,
                    onChanged: (value) async {
                      controller.isDefault.value = value;
                    },
                  )),
            ),
            SizedBox(
              height: 100,
            ),
            CustomButton(
              backgroundColor: Color(0xFF1C7AF4),
              width: 140,
              height: 40,
              title: '保存',
              titleColor: Colors.white,
              radius: 20,
              onPressed: () => controller.submitted(),
            )
          ],
        ),
      ),
    );
  }
}
