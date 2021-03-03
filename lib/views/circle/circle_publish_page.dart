import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:ws_app_flutter/view_models/circle/circle_publish_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CirclePublishPage extends GetView<CirclePublishController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: '发圈子',
        isBack: false,
        leftItem: CustomButton(
          backgroundColor: Colors.transparent,
          width: 30,
          height: 30,
          title: '取消',
          titleColor: Colors.white,
          onPressed: () => Get.back(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomButton(
                title: '选择图片',
                onPressed: () async {
                  await AssetPicker.pickAssets(context);
                },
              ),
            ],
          ),
        ));
  }
}
