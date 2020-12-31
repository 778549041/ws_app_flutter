import 'package:flutter/material.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/global.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/routes.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/splash/splash_page.dart';

void main() => Global.globalInit().then((value) => runApp(MyApp()));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.put<UserController>(UserController());
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        home: SplashPage(),
        getPages: AppPages.pages,
        builder: (context, child) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                Get.focusScope.unfocus();
              },
              child: child,
            ),
          );
        });
  }

  void _initShareSDK() {
    ShareSDKRegister register = ShareSDKRegister();
    register.setupWechat(CacheKey.WECHAT_APPKEY, CacheKey.WECHAT_APPSECRET,
        CacheKey.UNIVERSAL_LINKS);
    register.setupSinaWeibo(CacheKey.SINA_APPKEY, CacheKey.SINA_APPSECRET,
        CacheKey.SERVICE_URL_HOST + CacheKey.SINA_REDIRECT_URI);
    SharesdkPlugin.regist(register);
  }

  @override
  void initState() {
    _initShareSDK();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
