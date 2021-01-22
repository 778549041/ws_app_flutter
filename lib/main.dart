import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/global.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/splash/splash_controller.dart';
import 'package:ws_app_flutter/views/splash/splash_page.dart';

void main() => Global.globalInit().then((value) => runApp(MyApp()));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        defaultTransition: Transition.rightToLeft,
        initialBinding: BindingsBuilder(
          () => {
            Get.lazyPut<UserController>(() => UserController()),
            Get.lazyPut<SplashController>(() => SplashController())
          },
        ),
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

  void _initAmap() async {
    await AmapService.instance.init(
        androidKey: '2f380dfbbd258d3dcc39dba0ba93f0dd',
        iosKey: '7a1bd67b8d226567eae73e1e9cba3429');
    if (await PermissionManager().requestPermission(Permission.location)) {
      final _location = await AmapLocation.instance.fetchLocation();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _initShareSDK();
    _initAmap();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        Get.find<CarController>().refreshLocation();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
    super.didChangeAppLifecycleState(state);
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
