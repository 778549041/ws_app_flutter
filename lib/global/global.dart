import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//应用启动之前的全局设置（工具类的初始化）
class Global {
  static Future globalInit() async {
    //确保flutter框架初始化完成
    WidgetsFlutterBinding.ensureInitialized();
    //SpUtil初始化
    await SpUtil.getInstance();
    //LogUtil日志打印初始化
    LogUtil.init(isDebug: kDebugMode);
    //设置设计稿尺寸，UI适配
    setDesignWHD(375, 812);
    //安卓沉浸式状态栏
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
  }
}
