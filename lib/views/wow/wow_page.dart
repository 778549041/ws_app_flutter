import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/wow/wow_controller.dart';
import 'package:ws_app_flutter/views/wow/activity_list_page.dart';
import 'package:ws_app_flutter/views/wow/news_list_page.dart';
import 'package:ws_app_flutter/views/wow/recommend_page.dart';

class WowPage extends StatefulWidget {
  @override
  WowPageState createState() => WowPageState();
}

class WowPageState extends State<WowPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final WowController controller = Get.put<WowController>(WowController());
  final List<Tab> tabs = <Tab>[
    Tab(
      text: '推荐',
    ),
    Tab(
      text: '资讯',
    ),
    Tab(
      text: '活动',
    )
  ];
  final List<Widget> _pages = <Widget>[
    RecommendPage(),
    NewsListPage(),
    ActivityListPage()
  ];
  TabController _tabController;
  
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/common/bg.png',
            width: Get.width,
            height: Get.height / 2,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
            width: Get.width,
            height: 40,
            child: TabBar(
              indicatorColor: Colors.transparent,
              controller: _tabController,
              tabs: tabs,
              onTap: (value) => controller.tabClick(value),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight + 40),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
