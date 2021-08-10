import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ws_app_flutter/global/color_key.dart';

//应用启动之前的全局设置（工具类的初始化）
void globalInit() {
  //LogUtil日志打印初始化
  LogUtil.init(isDebug: kDebugMode);
  //设置设计稿尺寸，UI适配
  setDesignWHD(375, 812);
  //安卓沉浸式状态栏
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
  //全局设置loading样式
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..maskType = EasyLoadingMaskType.clear
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = MainAppColor.mainSilverColor
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = false;
}
