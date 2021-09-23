import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CreateTopicController extends GetxController {
  List<CircleTagModel> tagList = <CircleTagModel>[];
  var topicTitle = ''.obs;
  String? topicDesc;
  int? selectedTagId;
  var permission = '不开放'.obs;
  AssetEntity? selectedImage;

  @override
  void onInit() {
    super.onInit();
    _getAllTagList();
    update(['selectimg']);
  }

  Future _getAllTagList() async {
    CircleTagListModel tagListModel = await DioManager()
        .request<CircleTagListModel>(DioManager.GET, Api.allCircleTagListUrl,
            queryParamters: {'type': '1'});
    for (var i = 0; i < tagListModel.data!.length; i++) {
      CircleTagModel item = tagListModel.data![i];
      if (i == 0) {
        item.selected = true;
        selectedTagId = item.tag_id!;
      } else {
        item.selected = false;
      }
      tagList.add(item);
    }
    update(['tagList']);
  }

  //输入内容变更
  void inputChanged(int index, String value) {
    if (index == 0) {
      topicTitle.value = value;
    } else if (index == 1) {
      topicDesc = value;
    }
  }

  //选择标签
  void selectTag(CircleTagModel model) {
    selectedTagId = model.tag_id!;
    for (var item in tagList) {
      if (item.tag_id! == selectedTagId) {
        item.selected = true;
      } else {
        item.selected = false;
      }
    }
    update(['tagList']);
  }

  //选择权限
  void selectPermission(Object? value) {
    permission.value = value!.toString();
  }

  //选择图片或者视频
  Future clickPickAsset() async {
    List<AssetEntity>? result = await AssetPicker.pickAssets(Get.context!,
        maxAssets: 1, specialItemBuilder: (context) {
      return CustomButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          final AssetEntity? _entity =
              await CameraPicker.pickFromCamera(context);
          if (_entity != null) {
            selectedImage = _entity;
            update(['selectimg']);
            Get.back();
          }
        },
      );
    }, specialItemPosition: SpecialItemPosition.prepend);
    if (result != null) {
      selectedImage = result.first;
      update(['selectimg']);
    }
  }

  //提交
  void confirmAction() async {
    if (topicTitle.value.length == 0) {
      EasyLoading.showToast('请输入话题名称',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (topicDesc == null || topicDesc?.length == 0) {
      EasyLoading.showToast('请输入话题描述',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (selectedImage == null) {
      EasyLoading.showToast('请选择一张封面图',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    Uint8List? bytes = await selectedImage!.originBytes;
    String bs64 = base64Encode(bytes!);
    String bs64Image = "data:image/png;base64," + bs64;
    EasyLoading.show(status: '图片上传中...');
    CommonModel _model = await DioManager().request<CommonModel>(
        DioManager.POST, 'index.php/m/imagemanage-upload.html',
        params: {'avatar': bs64Image});
    if (_model.imageId != null) {
      EasyLoading.dismiss();
      CommonModel _result = await DioManager()
          .request<CommonModel>(DioManager.POST, Api.createTopicUrl, params: {
        'image_id': _model.imageId!,
        'tag_id': selectedTagId!,
        'access': permission.value == '不开放'
            ? 1
            : permission.value == '半开放'
                ? 2
                : 3,
        'title': topicTitle.value,
        'content': topicDesc,
      });
      if (_result.result!) {
        Get.toNamed(Routes.CREATETOPICSUCCESS);
      } else {
        EasyLoading.showToast(_result.message!,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      EasyLoading.showToast('图片上传失败',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
