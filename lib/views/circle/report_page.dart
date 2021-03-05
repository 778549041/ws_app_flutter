import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/report_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ReportPage extends GetView<ReportController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '举报',
      rightActions: <Widget>[
        CustomButton(
          backgroundColor: Colors.transparent,
          height: 30,
          title: '提交',
          titleColor: Colors.white,
          onPressed: () => controller.submit(),
        ),
        SizedBox(
          width: 10,
        ),
      ],
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 200,
                    child: TextField(
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      maxLength: 200,
                      maxLines: 10,
                      style: TextStyle(fontSize: 15),
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请填写举报原因(2-200字，必填)',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: MainAppColor.secondaryTextColor),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8)),
                      onChanged: (value) => controller.onInputChange(value),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Color(0xFFD6D6D6),
                    height: 0.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '请上传图片证据(选填)',
                    style: TextStyle(
                        color: MainAppColor.secondaryTextColor, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: controller.selectedAssets.length,
                      itemBuilder: (BuildContext context, int index) {
                        AssetEntity item = controller.selectedAssets[index];
                        final AssetEntityImageProvider imageProvider =
                            AssetEntityImageProvider(item, isOriginal: false);
                        return GestureDetector(
                          onTap: () => controller.clickItem(index, item),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8.5, right: 8.5, left: 0, bottom: 0),
                                child: Image(
                                  image: imageProvider,
                                  width: (Get.width - 40) / 3 - 8.5,
                                  height: (Get.width - 40) / 3 - 8.5,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CustomButton(
                                  backgroundColor: Colors.transparent,
                                  image:
                                      'assets/images/circle/circle_delete_image.png',
                                  imageH: 17,
                                  imageW: 17,
                                  onPressed: () =>
                                      controller.deleteAsset(index),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'WOWSTATION',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: MainAppColor.secondaryTextColor),
                          children: [
                            TextSpan(
                                text: '《举报须知》',
                                style: TextStyle(
                                    fontSize: 15.0, color: Color(0xFF1B7DF4)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => controller.pushReportKnow()),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 50,
              width: Get.width,
              color: Color(0xFFECECEC),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 17,
                  ),
                  CustomButton(
                    backgroundColor: Colors.transparent,
                    width: 30,
                    height: 30,
                    image: 'assets/images/circle/publish_select_pic.png',
                    imageW: 22,
                    imageH: 22,
                    onPressed: () => controller.clickPickAsset(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
