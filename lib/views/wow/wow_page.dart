import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class WowPage extends StatefulWidget {
  @override
  WowPageState createState() => WowPageState();
}

class WowPageState extends State<WowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WOW'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            CupertinoButton(
              child: Text('网页'),
              onPressed: () {
                Get.toNamed(Routes.WEBVIEW, arguments: {
                  'url': 'https://www.baidu.com',
                  'hasNav': true
                });
              },
            ),
            CupertinoButton(
              child: Text('退出登录'),
              onPressed: () {
                Get.find<UserController>().logout();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(WowPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
