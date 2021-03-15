import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qiniu_sdk_base/qiniu_sdk_base.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_sheet.dart';
// ignore: implementation_imports
import 'package:photo_manager/src/plugin.dart';

class CirclePublishController extends GetxController {
  TextEditingController textEditingController;
  FocusNode focusNode;
  String publishText;
  var topicModel = TopicModel().obs;
  var selectedAssets = List<AssetEntity>().obs;
  var isVideo = false.obs;

  @override
  void onInit() {
    publishText = '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //点击发布按钮
  Future publishMoment() async {
    Get.focusScope.unfocus();
    if ((selectedAssets == null || selectedAssets.length == 0) &&
        publishText.length == 0) {
      //无任何内容
      EasyLoading.showToast('发布内容不能为空',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (publishText.length > 0 && CommonUtil.isBlank(publishText)) {
      textEditingController.text = '';
      return;
    }
    if (publishText.length > 0) {
      publishContentIsLegal();
    } else {
      if (isVideo.value) {
        //发布视频
        publishVideo();
      } else {
        //发布图片
        publishImage();
      }
    }
  }

  //检查发布文本内容是否合法
  Future publishContentIsLegal() async {
    if (CommonUtil.containsLink(publishText)) {
      EasyLoading.showToast('发布内容中不能包含URL链接或网址',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circlePublishContentValidateUrl,
        params: {'content': publishText});
    if (model.result) {
      if (selectedAssets == null || selectedAssets.length == 0) {
        //发布纯文本
        publishOnlyText();
      } else if (isVideo.value) {
        //发布视频
        publishVideo();
      } else {
        //发布图片
        publishImage();
      }
    } else {
      EasyLoading.showToast(model.message,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //发布纯文本
  Future publishOnlyText() async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '0';
    params['content'] = publishText;
    if (topicModel.value != null) {
      params['topic_id'] = topicModel.value.topicId;
    }
    await publishNetWork(params);
  }

  //发布图片
  Future publishImage() async {
    var imgUrlList = await uploadAssets();
    String imgIDStr = await CommonUtil.getCoveridsString(imgUrlList, '0');

    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '1';
    params['content'] = publishText;
    params['cover_id'] = imgIDStr;
    if (topicModel.value != null) {
      params['topic_id'] = topicModel.value.topicId;
    }

    await publishNetWork(params);
  }

  //上传资源文件
  Future uploadAssets() async {
    EasyLoading.show(status: '文件上传中...');
    List<String> imgUrlList = [];
    for (var item in selectedAssets) {
      File file = await item.file;
      var result = await Storage().putFile(
          file,
          Auth(
                  accessKey: CacheKey.QINIU_ACCESS_KEY,
                  secretKey: CacheKey.QINIU_SECRET_KEY)
              .generateUploadToken(
                  putPolicy: PutPolicy(
                      scope: CacheKey.QINIU_SPACE_NAME,
                      deadline: DateUtil.getNowDateMs() + 3600)),
          options: PutOptions(controller: PutController()));
      print(result);
      imgUrlList.add(CacheKey.QINIU_SERVICE_HOST + result.key);
    }
    EasyLoading.dismiss();
    return imgUrlList;
  }

  //发布视频
  Future publishVideo() async {
    var imgUrlList = await uploadAssets();
    String imgIDStr = await CommonUtil.getCoveridsString(imgUrlList, '1');

    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '2';
    params['content'] = publishText;
    params['cover_id'] = imgIDStr;
    if (topicModel.value != null) {
      params['topic_id'] = topicModel.value.topicId;
    }

    await publishNetWork(params);
  }

  //发布操作网络请求
  Future publishNetWork(Map<String, dynamic> params) async {
    CommonModel receive = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circlePublishMomentUrl,
        params: params);
    if (receive.list == 'true') {
      if (receive.message != null && receive.message.length > 0) {
        EasyLoading.showToast(receive.message,
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        EasyLoading.showToast('发布成功',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      Future.delayed(Duration(seconds: 1)).then((value) async {
        Get.back();
      });
    }
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

  //删除某个已选中的资源
  void deleteAsset(int index) {
    if (selectedAssets.length == 1) {
      isVideo.value = false;
    }
    selectedAssets.removeAt(index);
  }

  //删除当前话题
  void deleteCurrentTopic() {
    topicModel.value = TopicModel();
  }

  //选择图片或者视频
  Future clickPickAsset() async {
    int totalCount = 9 - selectedAssets.length;
    if (await containsVideo(selectedAssets)) {
      totalCount = 9;
    }
    List<AssetEntity> result = await AssetPicker.pickAssets(Get.context,
        maxAssets: (totalCount),
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
                  Plugin _plugin = Plugin();
                  AssetEntity entity =
                      await _plugin.saveImageWithPath(_image.path);
                  if (await containsVideo(selectedAssets)) {
                    //如果之前选择了视频
                    selectedAssets.assignAll([entity]);
                  } else if (selectedAssets.length < 9) {
                    //如果已选图片数量小于9张
                    selectedAssets.add(entity);
                  }
                  isVideo.value = false;
                  Get.back();
                } else if (selectIndex == 2) {
                  var _video = await ImagePicker().getVideo(
                      source: ImageSource.camera,
                      maxDuration: Duration(seconds: 15));
                  if (_video == null) {
                    return;
                  }
                  File _videoFile = File(_video.path);
                  Plugin _plugin = Plugin();
                  AssetEntity entity = await _plugin.saveVideo(_videoFile);
                  selectedAssets.assignAll([entity]);
                  isVideo.value = true;
                  Get.back();
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
    }, customItemPosition: CustomItemPosition.prepend);
    if (result == null) {
      return;
    }
    if (await containsVideo(result)) {
      //如果当前选择了视频
      if (result.first.duration > 15) {
        EasyLoading.showToast('视频长度不能超过15秒',
            toastPosition: EasyLoadingToastPosition.bottom);
      } else {
        selectedAssets.assignAll(result);
      }
    } else if (await containsVideo(selectedAssets)) {
      //如果之前选择了视频
      selectedAssets.assignAll(result);
    } else {
      selectedAssets.addAll(result);
    }
    isVideo.value = await containsVideo(selectedAssets);
  }

  //判断是否选择了视频
  Future<bool> containsVideo(List<AssetEntity> result) async {
    if (result.length == 1) {
      AssetEntity entity = result.first;
      if (entity.type == AssetType.video) {
        return true;
      }
      return false;
    }
    return false;
  }

  //选择话题
  void clickSelectTopic() {
    Get.toNamed(Routes.TOPICLIST).then((value) {
      topicModel.value = value;
    });
  }
}
