import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimConversationListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/global.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/third_config.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/location_manager.dart';
import 'package:ws_app_flutter/view_models/mine/chat_controller.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/splash/splash_controller.dart';
import 'package:ws_app_flutter/views/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  //确保flutter框架初始化完成
  WidgetsFlutterBinding.ensureInitialized();
  //SpUtil初始化
  await SpUtil.getInstance();
  //应用入口函数
  runApp(MyApp());
  //全局设置
  globalInit();
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
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
                (Locale? locale, Iterable<Locale> supportedLocales) {
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
                      Get.focusScope?.unfocus();
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
    register.setupWechat(WECHAT_APPKEY, WECHAT_APPSECRET, UNIVERSAL_LINKS);
    register.setupSinaWeibo(SINA_APPKEY, SINA_APPSECRET,
        Env.envConfig.serviceUrl + SINA_REDIRECT_URI, UNIVERSAL_LINKS);
    SharesdkPlugin.regist(register);
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
    //获取registrationID
    jpush.getRegistrationID().then((registrationID) {
      print(registrationID);
      SpUtil.putString(REGISTRATIONID, registrationID);
    });
    //iOS点击推送启动应用拿到推送消息
    jpush.getLaunchAppNotification().then((Map<dynamic, dynamic> message) {
      print('获取到的推送消息数据为${message}');
    });
  }

  //bugly初始化
  void _initBugly() {
    FlutterBugly.init(androidAppId: 'a9d87f9857', iOSAppId: '18870e2ba8');
  }

  //腾讯云IMSDK初始化
  void _initimIMSDK() async {
    //获取腾讯即时通信IM manager
    V2TIMManager timManager = TencentImSDKPlugin.v2TIMManager;
    //初始化SDK
    V2TimValueCallback<bool> initRes = await timManager.initSDK(
      sdkAppID: TIMSDK_APPID,
      loglevel: LogLevel.V2TIM_LOG_DEBUG,
      listener: V2TimSDKListener(
        //连接中
        onConnecting: () {},
        //连接失败
        onConnectFailed: (int i, String s) {},
        //连接成功
        onConnectSuccess: () {},
        //被踢下线
        onKickedOffline: () {
          print("被踢下线了");
        },
        //sig过期
        onUserSigExpired: () {},
        //个人用户信息更新
        onSelfInfoUpdated: (V2TimUserFullInfo info) {},
      ),
    );
    if (initRes.code == 0) {
      //初始化成功
      //添加高级消息监听
      timManager.getMessageManager().addAdvancedMsgListener(
              listener: V2TimAdvancedMsgListener(
            //接收到新消息
            onRecvNewMessage: (V2TimMessage message) {
              if (Get.isRegistered<ChatController>()) {
                Get.find<ChatController>().addMessageIfNotExits(message);
              }
            },
            //收到消息已读回执
            onRecvC2CReadReceipt: (List<V2TimMessageReceipt> data) {
              print('收到了新消息 已读回执');
              data.forEach((element) {
                print("已读回执${element.userID} ${element.timestamp}");
                if (Get.isRegistered<ChatController>()) {
                  Get.find<ChatController>()
                      .updateC2CMessageByUserId(element.userID);
                }
              });
            },
            //消息撤回
            onRecvMessageRevoked: (String data) {},
            //发送消息进度
            onSendMessageProgress: (V2TimMessage message, int progress) {
              if (Get.isRegistered<ChatController>()) {
                Get.find<ChatController>().addMessageIfNotExits(message);
              }
              print(
                  "消息发送进度 ${progress} ${message.timestamp} ${message.msgID} ${message.timestamp} ${message.status}");
            },
          ));
      //会话监听
      timManager.getConversationManager().setConversationListener(
            listener: V2TimConversationListener(
              //收到新会话
              onNewConversation: (List<V2TimConversation> data) =>
                  updateConversation(),
              //会话列表变更
              onConversationChanged: (List<V2TimConversation> data) =>
                  updateConversation(),
            ),
          );
    }
  }

  void updateConversation() {
    //如果当前会话在使用中，也更新一下
    if (Get.isRegistered<ConversationController>()) {
      Get.find<ConversationController>().refresh();
    }
  }

  @override
  void initState() {
    _initShareSDK();
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
