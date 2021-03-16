import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:qiniu_sdk_base/qiniu_sdk_base.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class ReportController extends GetxController {
  TextEditingController textEditingController;
  FocusNode focusNode;
  String publishText;
  var selectedAssets = List<AssetEntity>().obs;

  @override
  void onInit() {
    publishText = '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //点击提交按钮
  Future submit() async {
    Get.focusScope.unfocus();
    if (publishText.length == 0) {
      //无任何内容
      EasyLoading.showToast('请先输入举报原因',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (publishText.length > 0 && CommonUtil.isBlank(publishText)) {
      textEditingController.text = '';
      return;
    }
    if (selectedAssets != null) {
      //包含图片
      reportImage();
    } else {
      //纯文本
      reportOnlyText();
    }
  }

  //举报纯文本
  Future reportOnlyText() async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '0';
    params['content'] = publishText;
    await reportNetWork(params);
  }

  //举报图片
  Future reportImage() async {
    var imgUrlList = await uploadAssets();
    String imgIDStr = await CommonUtil.getCoveridsString(imgUrlList, '0');

    Map<String, dynamic> params = Map<String, dynamic>();
    params['type'] = '1';
    params['content'] = publishText;
    params['cover_id'] = imgIDStr;

    await reportNetWork(params);
  }

  //上传资源文件
  Future uploadAssets() async {
    EasyLoading.show(status: '文件上传中...');
    List<String> imgUrlList = [];
    for (var item in selectedAssets) {
      String filePath = await FlutterAbsolutePath.getAbsolutePath(item.id);
      File compressedFile = await FlutterNativeImage.compressImage(filePath,
          quality: 70, percentage: 50);
      var result = await Storage().putFile(
          compressedFile,
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

  //举报操作网络请求
  Future reportNetWork(Map<String, dynamic> params) async {
    CommonModel receive = await DioManager().request<CommonModel>(
        DioManager.POST, 'index.php/m/circomment-complaint.html',
        params: params);
    if (receive.result) {
      EasyLoading.showToast('举报成功，平台将会在24小时之内给出回复',
          toastPosition: EasyLoadingToastPosition.bottom);
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
    selectedAssets.removeAt(index);
  }

  //选择图片或者视频
  Future clickPickAsset() async {
    List<AssetEntity> result = await AssetPicker.pickAssets(Get.context,
        maxAssets: (9 - selectedAssets.length));
    if (result == null) {
      return;
    }
    selectedAssets.addAll(result);
  }

  //跳转举报须知
  void pushReportKnow() {
    Get.toNamed(Routes.REPORTKNOW);
  }
}
