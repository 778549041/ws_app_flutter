import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class PermissionManager {
//动态申请权限，ios 要在info.plist 上面添加
  Future<bool> requestPermission(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) {
      return true;
    }
    Map<Permission, PermissionStatus> statuses = await [permission].request();
    status = statuses[permission]!;
    if (status.isGranted) {
      //如果用户已授权
      return true;
    } else {
      //没有权限
      String _permissionCHName = '';
      if (permission == Permission.calendar) {
        _permissionCHName = '日历';
      } else if (permission == Permission.camera) {
        _permissionCHName = '相机';
      } else if (permission == Permission.contacts) {
        _permissionCHName = '通讯录';
      } else if (permission == Permission.location) {
        _permissionCHName = '定位';
      } else if (permission == Permission.locationAlways) {
        _permissionCHName = '持续定位';
      } else if (permission == Permission.locationWhenInUse) {
        _permissionCHName = '使用期间定位';
      } else if (permission == Permission.mediaLibrary) {
        _permissionCHName = '媒体';
      } else if (permission == Permission.microphone) {
        _permissionCHName = '麦克风';
      } else if (permission == Permission.phone) {
        _permissionCHName = '拨号';
      } else if (permission == Permission.photos) {
        _permissionCHName = '相册';
      } else if (permission == Permission.reminders) {
        _permissionCHName = '提醒事项';
      } else if (permission == Permission.sensors) {
        _permissionCHName = '传感器';
      } else if (permission == Permission.sms) {
        _permissionCHName = '短信';
      } else if (permission == Permission.speech) {
        _permissionCHName = '语音';
      } else if (permission == Permission.storage) {
        _permissionCHName = '存储';
      } else if (permission == Permission.ignoreBatteryOptimizations) {
        _permissionCHName = '电量优化';
      } else if (permission == Permission.notification) {
        _permissionCHName = '通知';
      } else if (permission == Permission.accessMediaLocation) {
        _permissionCHName = '应用访问';
      } else if (permission == Permission.activityRecognition) {
        _permissionCHName = '行为识别';
      }

      Get.dialog(
          BaseDialog(
            title: '提示',
            rightText: '去设置',
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('您当前没有开启$_permissionCHName权限',
                  style: TextStyle(fontSize: 16.0)),
            ),
            onConfirm: () {
              Get.back();
              openAppSettings();
            },
          ),
          barrierDismissible: false);
      return false;
    }
  }
}
