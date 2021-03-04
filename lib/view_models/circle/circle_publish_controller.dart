import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CirclePublishController extends GetxController {
  TextEditingController textEditingController;
  FocusNode focusNode;
  String publishText;
  var topicModel = TopicModel().obs;
  var selectedAssets = List<AssetEntity>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //点击发布按钮
  Future publishMoment() async {}

  //输入内容变化
  void onInputChange(String input) {
    publishText = input;
  }

  //点击选择的图片进行预览
  Future clickItem(int index, AssetEntity assetEntity) async {
    await AssetPickerViewer.pushToViewer(
      Get.context,
      currentIndex: index,
      assets: selectedAssets,
      themeData: AssetPicker.themeData(Colors.black),
      // previewThumbSize: previewThumbSize,
      specialPickerType: assetEntity.type == AssetType.video
          ? SpecialPickerType.wechatMoment
          : null,
    );
  }

  //删除当前话题
  void deleteCurrentTopic() {}

  //选择图片或者视频
  Future clickPickAsset() async {
    List<AssetEntity> result = await AssetPicker.pickAssets(Get.context,
        maxAssets: (9 - selectedAssets.length),
        specialPickerType: SpecialPickerType.wechatMoment,
        customItemBuilder: (context) {
      return CustomButton(
        backgroundColor: Colors.red,
        onPressed: () {},
      );
    }, customItemPosition: CustomItemPosition.append);
    selectedAssets.addAll(result);
  }

  //选择话题
  void clickSelectTopic() {
    Get.toNamed(Routes.TOPICLIST);
  }
}
