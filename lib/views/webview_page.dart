import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ws_app_flutter/view_models/net/net_controller.dart';
import 'package:get/get.dart';

class WebViewPage extends StatelessWidget {
  final String url = Get.arguments['url']; //前端页面地址
  final String title = Get.arguments['title']; //页面标题
  final bool hasNav = Get.arguments['hasNav'] ?? false; //是否需要导航栏，默认不需要
  final String localHtml = Get.arguments['localHtml']; //本地html文件

  //无网络加载失败显示UI
  Widget _buildWebViewFailedWidget() {
    return Container(
      width: double.infinity,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 20),
          child: Container(
            child: Image.asset(
              'assets/images/common_network_error.png',
              fit: BoxFit.fitWidth,
              width: 180,
            ),
          ),
        ),
        Text(
          '请检查你的网络设置',
          style: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            width: 200,
            height: 45,
            child: FlatButton(
              color: const Color(0xFFFFFFFF),
              textColor: const Color(0xFF4C60FF),
              child: Text(
                '重新加载',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.5),
                side: const BorderSide(color: Color(0xFF4C60FF), width: 1),
              ),
              onPressed: () => Get.find<NetConnectController>()
                  .onPressedReload(url: url, localHtml: localHtml),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetX<NetConnectController>(
      init: NetConnectController(),
      builder: (netcontroller) {
        return Scaffold(
            appBar: hasNav
                ? AppBar(
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          netcontroller.goBack();
                        }),
                    title: Text(
                      (title != null) ? title : netcontroller.webTitle.value,
                    ),
                  )
                : null,
            body: IndexedStack(
              index: netcontroller.currentIndex.value,
              children: <Widget>[
                const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF4C60FF)),
                  ),
                ),
                WebView(
                  //是否允许js交互事件
                  javascriptMode: JavascriptMode.unrestricted,
                  //webview初始化
                  onWebViewCreated: (WebViewController controller) {
                    netcontroller.webViewController = controller;
                    netcontroller.loadWebPage(url: url, localHtml: localHtml);
                  },
                  //交互事件集合
                  javascriptChannels: netcontroller.loadJavascriptChannel(),
                  //页面开始加载
                  onPageStarted: (String url) {
                    netcontroller.onPageStart(url);
                  },
                  //页面加载完成
                  onPageFinished: (String url) {
                    netcontroller.onPageFinished(url);
                  },
                  //导航代理
                  navigationDelegate: (NavigationRequest request) {
                    return netcontroller.navigationDelegate(request);
                  },
                ),
                _buildWebViewFailedWidget()
              ],
            ));
      },
    );
  }
}
