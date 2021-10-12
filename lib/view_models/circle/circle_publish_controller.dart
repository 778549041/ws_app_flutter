import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:qiniu_sdk_base/qiniu_sdk_base.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/third_config.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CirclePublishController extends GetxController {
  TextEditingController? textEditingController;
  FocusNode? focusNode;
  String? publishText;
  var topicModel = TopicModel().obs;
  var selectedAssets = <AssetEntity>[].obs;
  var isVideo = false.obs;

  @override
  void onInit() {
    publishText = '';
    final TopicModel? topic =
        Get.arguments == null ? null : Get.arguments['model']; //修改地址传过来的参数
    if (topic != null) {
      topicModel.value = topic;
    }
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //点击发布按钮
  Future publishMoment() async {
    Get.focusScope?.unfocus();
    if ((selectedAssets.length == 0) && publishText?.length == 0) {
      //无任何内容
      EasyLoading.showToast('发布内容不能为空',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (publishText != null &&
        publishText!.length > 0 &&
        CommonUtil.isBlank(publishText)) {
      textEditingController?.text = '';
      return;
    }
    if (publishText != null && publishText!.length > 0) {
      _publishContentIsLegal();
    } else {
      if (isVideo.value) {
        //发布视频
        _publishVideo();
      } else {
        //发布图片
        _publishImage();
      }
    }
  }

  //检查发布文本内容是否合法
  Future _publishContentIsLegal() async {
    if (CommonUtil.containsLink(publishText)) {
      EasyLoading.showToast('发布内容中不能包含URL链接或网址',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circlePublishContentValidateUrl,
        params: {'content': publishText});
    if (model.result!) {
      if (selectedAssets.length == 0) {
        //发布纯文本
        _publishOnlyText();
      } else if (isVideo.value) {
        //发布视频
        _publishVideo();
      } else {
        //发布图片
        _publishImage();
      }
    } else {
      EasyLoading.showToast(model.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //发布纯文本
  Future _publishOnlyText() async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '0';
    params['content'] = publishText;
    if (topicModel.value.topicId != null) {
      params['topic_id'] = topicModel.value.topicId;
    }
    await _publishNetWork(params);
  }

  //发布图片
  Future _publishImage() async {
    var imgUrlList = await _uploadAssets();
    String imgIDStr = await CommonUtil.getCoveridsString(imgUrlList, '0');

    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '1';
    params['content'] = publishText;
    params['cover_id'] = imgIDStr;
    if (topicModel.value.topicId != null) {
      params['topic_id'] = topicModel.value.topicId;
    }

    await _publishNetWork(params);
  }

  //上传资源文件
  Future _uploadAssets() async {
    EasyLoading.show(status: '文件上传中...');
    List<String> imgUrlList = [];
    for (var item in selectedAssets) {
      late File compressedFile;
      if (item.type == AssetType.image) {
        String filePath = (await item.file)!.path;
        compressedFile =
            await FlutterNativeImage.compressImage(filePath, quality: 70);
      } else if (item.type == AssetType.video) {
        // File file = await item.file;
        // MediaInfo info = await VideoCompress.compressVideo(file.path);
        // compressedFile = info.file;
        compressedFile = (await item.file)!;
      }

      var result = await Storage().putFile(
          compressedFile,
          Auth(accessKey: QINIU_ACCESS_KEY, secretKey: QINIU_SECRET_KEY)
              .generateUploadToken(
                  putPolicy: PutPolicy(
                      scope: Env.envConfig.qiniuSpaceName,
                      deadline: DateUtil.getNowDateMs() + 3600)),
          options: PutOptions(controller: PutController()));
      LogUtil.d(result);
      imgUrlList.add(Env.envConfig.qiniuServiceUrl + result.key!);
    }
    EasyLoading.dismiss();
    return imgUrlList;
  }

  //发布视频
  Future _publishVideo() async {
    var imgUrlList = await _uploadAssets();
    String imgIDStr = await CommonUtil.getCoveridsString(imgUrlList, '1');

    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '2';
    params['content'] = publishText;
    params['cover_id'] = imgIDStr;
    if (topicModel.value.topicId != null) {
      params['topic_id'] = topicModel.value.topicId;
    }

    await _publishNetWork(params);
  }

  //发布操作网络请求
  Future _publishNetWork(Map<String, dynamic> params) async {
    CommonModel receive = await DioManager().request<CommonModel>(
        DioManager.POST, Api.circlePublishMomentUrl,
        params: params);
    if (receive.list == 'true') {
      if (receive.message != null && receive.message!.length > 0) {
        EasyLoading.showToast(receive.message!,
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
      Get.context!,
      currentIndex: index,
      previewAssets: selectedAssets,
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
    List<AssetEntity>? result = await AssetPicker.pickAssets(Get.context!,
        maxAssets: (totalCount),
        specialPickerType: SpecialPickerType.wechatMoment,
        specialItemBuilder: (context) {
      return CustomButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          final AssetEntity? _entity =
              await CameraPicker.pickFromCamera(context, enableRecording: true);
          if (_entity != null) {
            if (_entity.type == AssetType.video) {
              selectedAssets.add(_entity);
              isVideo.value = true;
              Get.back();
            } else {
              if (await containsVideo(selectedAssets)) {
                //如果之前选择了视频
                selectedAssets.assignAll([_entity]);
              } else if (selectedAssets.length < 9) {
                //如果已选图片数量小于9张
                selectedAssets.add(_entity);
              }
              isVideo.value = false;
              Get.back();
            }
          }
        },
      );
    }, specialItemPosition: SpecialItemPosition.prepend);
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
    Get.toNamed(Routes.TOPICLIST)?.then((value) {
      if (value == null) {
        topicModel.value = TopicModel();
      } else {
        topicModel.value = value;
      }
    });
  }
}
