import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';

class NetConnectController extends BaseController {
  var currentIndex = 0.obs;
  var isConnect = true.obs;
  var webTitle = ''.obs;
  WebViewController webViewController;

  //检查网络状态
  _checkConnected() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    isConnect.value = connectivityResult != ConnectivityResult.none;
    print('netconnected:' + isConnect.value.toString());
    if (!isConnect.value) {
      currentIndex.value = 2;
    }
  }

  //获取当前网页页面标题
  _loadTitle() async {
    final String title = await webViewController?.getTitle();
    webTitle.value = title;
  }

  //加载本地html文件
  Future<void> _loadHtmlFromAsset(String localHtml) async {
    final String path = await rootBundle.loadString(localHtml);
    webViewController?.loadUrl(Uri.dataFromString(path,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  //调用js事件
  Future<void> _evaluateJavascript() async {
    webViewController
        ?.evaluateJavascript('callJS(\'visible\');')
        ?.then((value) {
      print(value);
    });
  }

  //支付跳转
  Future<void> _openPay(String url) async {
    print("payurl:" + url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      EasyLoading.showToast('未安装支付软件',toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //js调用flutter
  Set<JavascriptChannel> loadJavascriptChannel() {
    final Set<JavascriptChannel> channels = Set<JavascriptChannel>();
    JavascriptChannel toastChannel = JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          EasyLoading.showToast(message.message,toastPosition: EasyLoadingToastPosition.bottom);
        });
    channels.add(toastChannel);
    return channels;
  }

  //返回上一层
  Future<void> goBack() async {
    if (webViewController != null && await webViewController.canGoBack()) {
      webViewController?.goBack();
    } else {
      Get.back();
    }
  }

  //加载失败点击按钮刷新页面
  void onPressedReload({String url, String localHtml}) {
    if (webViewController == null) {
      return;
    }
    currentIndex.value = 0;
    _checkConnected();
    loadWebPage(url: url, localHtml: localHtml);
  }

  //加载页面
  void loadWebPage({String url, String localHtml}) {
    if (url != null) {
      webViewController?.loadUrl(url, headers: {'Referer': url});
    }
    if (localHtml != null) {
      _loadHtmlFromAsset(localHtml);
    }
  }

  //页面开始加载
  void onPageStart(String url) {
    print("start load:" + url);
  }

  //页面加载完成
  void onPageFinished(String url) {
    print("finished load:" + url);
    if (isConnect.value) {
      currentIndex.value = 1;
    }
    _loadTitle();
    //设置cookie
    String cookie =
        "document.cookie = '_SID=${CommonUtil.sid()}'";
    webViewController?.evaluateJavascript(cookie);
    // _evaluateJavascript();
  }

  //导航代理
  FutureOr<NavigationDecision> navigationDelegate(NavigationRequest request) {
    if (request.url.startsWith('alipays:') ||
        request.url.startsWith('weixin:')) {
      _openPay(request.url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  @override
  void onReady() {
    _checkConnected();
    super.onReady();
  }
}
