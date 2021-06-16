import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:ws_app_flutter/global/color_key.dart';
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
      rightActions: <Widget>[
        CustomButton(
          backgroundColor: Colors.transparent,
          height: 30,
          title: '发布',
          titleColor: Colors.white,
          onPressed: () => controller.publishMoment(),
        ),
        SizedBox(
          width: 10,
        ),
      ],
      child: Stack(
        children: <Widget>[
          Obx(
            () => Container(
              margin: EdgeInsets.only(
                  bottom: controller.topicModel.value.topicId == '' ? 50 : 83),
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
                            hintText: '请输入您的动态信息...',
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: MainAppColor.secondaryTextColor),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8)),
                        onChanged: (value) => controller.onInputChange(value),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildChooseImageWidget(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(
                  () => Offstage(
                    offstage: controller.topicModel.value.topicId == '',
                    child: Container(
                      height: 23,
                      margin: const EdgeInsets.only(left: 15, bottom: 10),
                      padding: const EdgeInsets.only(left: 11.5, right: 11.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.5),
                        color: Color(0xFFECECEC),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            controller.topicModel.value.title,
                            style: TextStyle(
                                fontSize: 15, color: Color(0xFF7A7A7A)),
                          ),
                          CustomButton(
                            backgroundColor: Colors.transparent,
                            width: 20,
                            height: 20,
                            imageW: 11,
                            imageH: 11,
                            image: 'assets/images/common/icon_close.png',
                            onPressed: () => controller.deleteCurrentTopic(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
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
                      SizedBox(
                        width: 25,
                      ),
                      CustomButton(
                        backgroundColor: Colors.transparent,
                        width: 30,
                        height: 30,
                        image: 'assets/images/circle/publish_select_topic.png',
                        imageW: 22,
                        imageH: 22,
                        onPressed: () => controller.clickSelectTopic(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChooseImageWidget() {
    if (controller.isVideo.value) {
      AssetEntity item = controller.selectedAssets.first;
      final AssetEntityImageProvider imageProvider =
          AssetEntityImageProvider(item, isOriginal: false);
      String timeLength = '';
      if (item.duration < 10) {
        timeLength = '0:0${item.duration}';
      } else {
        timeLength = '0:${item.duration}';
      }
      return GestureDetector(
        onTap: () => controller.clickItem(0, item),
        behavior: HitTestBehavior.translucent,
        child: Container(
          width: Get.width - 30,
          height: 200,
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    top: 8.5, right: 8.5, left: 0, bottom: 0),
                child: Image(
                  image: imageProvider,
                  width: (Get.width - 30),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 70,
                left: (Get.width - 90) / 2,
                child: Image.asset(
                  'assets/images/circle/circle_play.png',
                  width: 60,
                  height: 60,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 5,
                child: Text(
                  timeLength,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CustomButton(
                  backgroundColor: Colors.transparent,
                  image: 'assets/images/circle/circle_delete_image.png',
                  imageH: 17,
                  imageW: 17,
                  onPressed: () => controller.deleteAsset(0),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GridView.builder(
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
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CustomButton(
                    backgroundColor: Colors.transparent,
                    image: 'assets/images/circle/circle_delete_image.png',
                    imageH: 17,
                    imageW: 17,
                    onPressed: () => controller.deleteAsset(index),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
