import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:video_compress/video_compress.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:ws_app_flutter/models/mine/advanceMsgList.dart';
import 'package:ws_app_flutter/view_models/mine/chat_controller.dart';
import 'package:ws_app_flutter/widgets/chat/advanceMsgItem.dart';

class AdvanceMsg extends StatelessWidget {
  AdvanceMsg(this.toUser, this.type);
  final String toUser;
  final int type;

  //选择图片或者视频并发送，0为图片，1为视频
  pickAssetAndSend(context, checkType) async {
    AssetEntity entity;
    List<AssetEntity>? result = await AssetPicker.pickAssets(Get.context!,
        maxAssets: 1,
        requestType: checkType == 0 ? RequestType.image : RequestType.video);
    if (result == null) {
      return;
    }
    entity = result.first;
    String path = (await entity.file)!.path;
    if (checkType == 0) {
      //图片
      sendImageMsg(path);
    } else if (checkType == 1) {
      //视频
      sendVideoMsg(path, entity.duration);
    }
  }

  //拍摄照片或者视频并发送
  takeAssetAndSend(context) async {
    final AssetEntity? _entity =
        await CameraPicker.pickFromCamera(context, enableRecording: true);
    if (_entity == null) {
      return;
    }
    String path = (await _entity.file)!.path;
    if (_entity.mimeType == AssetType.image) {
      //图片
      sendImageMsg(path);
    } else if (_entity.mimeType == AssetType.video) {
      //视频
      sendVideoMsg(path, _entity.duration);
    }
  }

  //发送视频消息
  sendVideoMsg(String path, int duration) async {
    final thumbnailFile = await VideoCompress.getFileThumbnail(path);
    print("thumbnailFile $thumbnailFile");

    V2TimValueCallback<V2TimMessage> res = await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .sendVideoMessage(
          videoFilePath: path,
          receiver: type == 1 ? toUser : '',
          groupID: type == 2 ? toUser : '',
          duration: duration,
          type: 'mp4',
          snapshotPath: thumbnailFile.path,
          onlineUserOnly: false,
        );

    if (res.code == 0) {
      V2TimMessage msg = res.data!;
      // 添加新消息
      try {
        Get.find<ChatController>().addMessageIfNotExits(msg);
      } catch (err) {
        print("发生错误");
      }
    } else {
      EasyLoading.showToast('发送失败 ${res.code} ${res.desc}',
          toastPosition: EasyLoadingToastPosition.bottom);
      print(res.desc);
    }
  }

  //发送图片消息
  sendImageMsg(String path) async {
    V2TimValueCallback<V2TimMessage> res = await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .sendImageMessage(
          imagePath: path,
          receiver: type == 1 ? toUser : '',
          groupID: type == 2 ? toUser : '',
          onlineUserOnly: false,
        );

    if (res.code == 0) {
      V2TimMessage msg = res.data!;
      // 添加新消息
      try {
        Get.find<ChatController>().addMessageIfNotExits(msg);
      } catch (err) {
        print("发生错误");
      }
    } else {
      EasyLoading.showToast('发送失败 ${res.code} ${res.desc}',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //发送自定义消息
  sendCustomData(context) async {
    print("herree $toUser");
    V2TimValueCallback<V2TimMessage> res = await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .sendCustomMessage(
          data: json.encode({
            "text": "欢迎加入腾讯·云通信大家庭！",
            "businessID": "text_link",
            "link": "https://cloud.tencent.com/document/product/269/3794",
            "version": 4
          }),
          receiver: type == 1 ? toUser : '',
          groupID: type == 2 ? toUser : '',
        );
    if (res.code == 0) {
      V2TimMessage msg = res.data!;
      // 添加新消息
      try {
        Get.find<ChatController>().addMessageIfNotExits(msg);
      } catch (err) {
        print("发生错误");
      }
    } else {
      print("发送失败 ${res.code} ${res.desc} herree");
      EasyLoading.showToast('发送失败 ${res.code} ${res.desc}',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //发送文件消息
  sendFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("选择成功${result.files.single.path}");
      String path = result.files.single.path!;
      V2TimValueCallback<V2TimMessage> res = await TencentImSDKPlugin
          .v2TIMManager
          .getMessageManager()
          .sendFileMessage(
            fileName: path.split('/').last,
            filePath: path,
            receiver: type == 1 ? toUser : '',
            groupID: type == 2 ? toUser : '',
            onlineUserOnly: false,
          );
      if (res.code == 0) {
        V2TimMessage msg = res.data!;
        // 添加新消息
        try {
          Get.find<ChatController>().addMessageIfNotExits(msg);
        } catch (err) {
          print("发生错误");
        }
      } else {
        EasyLoading.showToast('发送失败 ${res.code} ${res.desc}',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      // User canceled the picker
    }
  }

  Future<int?> openPanel(context) {
    close() {
      Navigator.of(context).pop();
    }

    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          height: 260,
          color: Color(0xffededed),
          padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
            ),
            children: [
              new AdvanceMsgList(
                name: '相册',
                icon: Icon(
                  Icons.insert_photo,
                  size: 30,
                ),
                onPressed: () async {
                  close();
                  pickAssetAndSend(context, 0);
                },
              ),
              new AdvanceMsgList(
                name: '拍摄',
                icon: Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
                onPressed: () {
                  close();
                  takeAssetAndSend(context);
                },
              ),
              new AdvanceMsgList(
                name: '视频',
                icon: Icon(
                  Icons.video_call,
                  size: 30,
                ),
                onPressed: () {
                  close();
                  pickAssetAndSend(context, 1);
                },
              ),
              new AdvanceMsgList(
                name: '文件',
                icon: Icon(
                  Icons.insert_drive_file,
                  size: 30,
                ),
                onPressed: () async {
                  close();
                  sendFile(context);
                },
              ),
              new AdvanceMsgList(
                name: '自定义',
                icon: Icon(Icons.topic),
                onPressed: () {
                  close();
                  sendCustomData(context);
                },
              ),
            ].map((e) => AdvanceMsgItem(e)).toList(),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    print("toUser $toUser type $type herree");
    return Container(
      width: 56,
      height: 56,
      child: IconButton(
        icon: Icon(
          Icons.add,
          size: 28,
          color: Colors.black,
        ),
        onPressed: () async {
          await openPanel(context);
        },
      ),
    );
  }
}
