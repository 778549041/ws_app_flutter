import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_sheet.dart';

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
  Future publishMoment() async {
    //TODO
  }

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
      specialPickerType: assetEntity.type == AssetType.video
          ? SpecialPickerType.wechatMoment
          : null,
    );
  }

  void deleteAsset(int index) {
    selectedAssets.removeAt(index);
  }

  //删除当前话题
  void deleteCurrentTopic() {
    topicModel.value = TopicModel();
  }

  //选择图片或者视频
  Future clickPickAsset() async {
    List<AssetEntity> result = await AssetPicker.pickAssets(Get.context,
        maxAssets: (9 - selectedAssets.length),
        specialPickerType: SpecialPickerType.wechatMoment,
        customItemBuilder: (context) {
      return CustomButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Get.bottomSheet(
            CustomSheet(
              dataArr: ['拍摄照片', '拍摄视频'],
              clickCallback: (selectIndex, selectText) async {
                if (selectIndex == 0) {
                  return;
                }
                if (selectIndex == 1) {
                  var _image =
                      await ImagePicker().getImage(source: ImageSource.camera);
                  if (_image == null) {
                    return;
                  }
                } else if (selectIndex == 2) {
                  var _image = await ImagePicker().getVideo(
                      source: ImageSource.camera,
                      maxDuration: Duration(seconds: 15));
                  if (_image == null) {
                    return;
                  }
                }
              },
            ), //设置圆角
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            // 抗锯齿
            clipBehavior: Clip.antiAlias,
          );
        },
      );
    }, customItemPosition: CustomItemPosition.append);
    if (result == null) {
      return;
    }
    selectedAssets.addAll(result);
  }

  //选择话题
  void clickSelectTopic() {
    Get.toNamed(Routes.TOPICLIST).then((value) {
      topicModel.value = value;
    });
  }
}
