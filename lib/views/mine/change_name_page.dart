import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/change_name_cotroller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';

class ChangeNamePage extends GetView<ChangeNameController> {
  final bool isName = Get.arguments['isName']; //区分是修改昵称还是职业
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: isName ? '修改昵称' : '修改职业',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Container(
            width: 250,
            child: CustomTextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(isName ? 15 : 10)
              ],
              hintText: isName ? '1-15个字' : '',
              text: isName
                  ? Get.find<UserController>().userInfo.value.member!.showName!
                  : Get.find<UserController>().userInfo.value.member!.profession!,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              inputCallBack: (value) {
                controller.value = value;
              },
            ),
          ),
          SizedBox(
            height: 80,
          ),
          CustomButton(
            backgroundColor: Color(0xFF1C7AF4),
            width: 140,
            height: 40,
            title: '保存',
            titleColor: Colors.white,
            radius: 20,
            onPressed: () => controller.submmited(isName),
          ),
        ],
      ),
    );
  }
}
