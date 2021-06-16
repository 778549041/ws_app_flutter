import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_progress.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/global.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';
import 'package:ws_app_flutter/view_models/mine/chat_controller.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/splash/splash_controller.dart';
import 'package:ws_app_flutter/views/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => Global.globalInit().then((value) {
      runApp(MyApp());
      configLoading();
    });

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

//全局设置loading样式
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        headerBuilder: () => WaterDropHeader(),
        footerBuilder: () => ClassicFooter(),
        hideFooterWhenNotFull: true,
        shouldFooterFollowWhenNotFull: (status) {
          return false;
        },
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            defaultTransition: Transition.rightToLeft,
            initialBinding: BindingsBuilder(
              () => {
                Get.lazyPut<UserController>(() => UserController()),
                Get.lazyPut<SplashController>(() => SplashController()),
              },
            ),
            localizationsDelegates: [
              RefreshLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('zh'),
            ],
            locale: const Locale('zh'),
            localeResolutionCallback:
                (Locale locale, Iterable<Locale> supportedLocales) {
              return locale;
            },
            home: SplashPage(),
            getPages: AppPages.pages,
            builder: EasyLoading.init(
              builder: (context, child) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: GestureDetector(
                    onTap: () {
                      Get.focusScope.unfocus();
                    },
                    child: child,
                  ),
                );
              },
            )));
  }

  //ShareSDK初始化
  void _initShareSDK() {
    ShareSDKRegister register = ShareSDKRegister();
    register.setupWechat(CacheKey.WECHAT_APPKEY, CacheKey.WECHAT_APPSECRET,
        CacheKey.UNIVERSAL_LINKS);
    register.setupSinaWeibo(
        CacheKey.SINA_APPKEY,
        CacheKey.SINA_APPSECRET,
        CacheKey.SERVICE_URL_HOST + CacheKey.SINA_REDIRECT_URI,
        CacheKey.UNIVERSAL_LINKS);
    SharesdkPlugin.regist(register);
  }

  //高德地图初始化
  void _initAmap() async {
    await AmapService.instance.init(
        androidKey: '2f380dfbbd258d3dcc39dba0ba93f0dd',
        iosKey: '7a1bd67b8d226567eae73e1e9cba3429');
    if (await PermissionManager().requestPermission(Permission.location)) {
      final _location = await AmapLocation.instance.fetchLocation();
    }
  }

  //极光推送初始化
  void _initJPush() async {
    JPush jpush = JPush();
    //添加事件监听
    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      },
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
      onReceiveNotificationAuthorization: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
      },
    );
    //初始化jpush
    jpush.setup(
        appKey: '8ef8b590f8a19c29cb57f8c3',
        channel: 'developer-default',
        production: false,
        debug: false);
    //申请推送权限
    jpush.applyPushAuthority(NotificationSettingsIOS(
      sound: true,
      alert: true,
      badge: true,
    ));
    //上传registrationID到服务器
    jpush.getRegistrationID().then((registrationID) {
      print(registrationID);
      SpUtil.putString(CacheKey.REGISTRATIONID, registrationID);
    });
    //iOS点击推送启动应用拿到推送消息
    jpush.getLaunchAppNotification().then((Map<dynamic, dynamic> message) {});
  }

  //bugly初始化
  void _initBugly() {
    FlutterBugly.init(androidAppId: '', iOSAppId: '18870e2ba8');
  }

  //腾讯云IMSDK初始化
  void _initimIMSDK() async {
    V2TIMManager timManager = TencentImSDKPlugin.v2TIMManager;
    await timManager.initSDK(
      sdkAppID: CacheKey.TIMSDK_APPID,
      loglevel: LogLevel.V2TIM_LOG_DEBUG,
      listener: listener,
    );
    //高级消息监听
    timManager.getMessageManager().addAdvancedMsgListener(
          listener: advancedMsgListener,
        );
    //会话监听
    timManager.getConversationManager().setConversationListener(
          listener: conversationListener,
        );
  }

  listener(data) async {
    if (data.type == 'onKickedOffline') {
      // 被踢下线
      print("被踢下线了");
    }
  }

  advancedMsgListener(data) {
    if (data.type == 'onRecvNewMessage') {
      try {
        V2TimMessage message;
        message = data.data;
        if (Get.isRegistered<ChatController>()) {
          Get.find<ChatController>().addMessageIfNotExits(message);
        }
      } catch (err) {
        print(err);
      }
    }
    if (data.type == 'onRecvC2CReadReceipt') {
      print('收到了新消息 已读回执');
      List<V2TimMessageReceipt> list = data.data;
      list.forEach((element) {
        print("已读回执${element.userID} ${element.timestamp}");
        if (Get.isRegistered<ChatController>()) {
          Get.find<ChatController>().updateC2CMessageByUserId(element.userID);
        }
      });
    }
    if (data.type == 'onRecvMessageRevoked') {
      //消息撤回 TODO
    }
    if (data.type == 'onSendMessageProgress') {
      //消息进度
      MessageProgress msgPro = data.data;
      V2TimMessage message = msgPro.message;
      try {
        if (Get.isRegistered<ChatController>()) {
          Get.find<ChatController>().addMessageIfNotExits(message);
        }
      } catch (err) {
        print("error $err");
      }
      print(
          "消息发送进度 ${msgPro.progress} ${message.timestamp} ${message.msgID} ${message.timestamp} ${message.status}");
    }
  }

  conversationListener(data) {
    String type = data.type;
    if (type == 'onNewConversation' || type == 'onConversationChanged') {
      try {
        //如果当前会话在使用中，也更新一下
        if (Get.isRegistered<ConversationController>()) {
          Get.find<ConversationController>().refresh();
        }
      } catch (e) {}
    } else {
      print("$type emit but no nerver use");
    }
  }

  @override
  void initState() {
    _initShareSDK();
    _initAmap();
    _initJPush();
    _initBugly();
    _initimIMSDK();
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
