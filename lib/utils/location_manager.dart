import 'dart:async';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flustars/flustars.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ws_app_flutter/global/third_config.dart';

class LocationManager {
  AMapFlutterLocation locationPlugin = AMapFlutterLocation();
  LocationManager() {
    /// 动态申请定位权限
    requestPermission();

    // /设置Android和iOS的apiKey
    AMapFlutterLocation.setApiKey(AMAP_ANDROID_KEY, AMAP_IOS_KEY);

    ///开始定位之前设置定位参数
    _setLocationOption();
  }

  ///设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = true;
    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";
    ///Android端定位模式, 只在Android系统上有效
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;
    /// iOS端期望的定位精度， 只在iOS端有效
    locationOption.desiredAccuracy = DesiredAccuracy.HundredMeters;
    locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    ///将定位参数设置给定位插件
    locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  void startLocation() {
    locationPlugin.startLocation();
  }

  ///停止定位
  void stopLocation() {
    locationPlugin.stopLocation();
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      LogUtil.d("定位权限申请通过");
    } else {
      LogUtil.d("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void dispose() {
    ///销毁定位
    locationPlugin.destroy();
  }
}
