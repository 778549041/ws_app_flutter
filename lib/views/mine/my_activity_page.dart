import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/my_activity_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/mine/my_activity_list_all.dart';
import 'package:ws_app_flutter/views/mine/my_activity_list_ing.dart';
import 'package:ws_app_flutter/views/mine/my_activity_list_nostart.dart';
import 'package:ws_app_flutter/views/mine/my_activity_list_over.dart';

class MyActivityPage extends StatefulWidget {
  @override
  MyActivityPageState createState() => MyActivityPageState();
}

class MyActivityPageState extends State<MyActivityPage>
    with SingleTickerProviderStateMixin {
  final MyActivityController controller = Get.find<MyActivityController>();
  final List<Tab> tabs = <Tab>[
    Tab(
      text: '全部',
    ),
    Tab(
      text: '未开始',
    ),
    Tab(
      text: '进行中',
    ),
    Tab(
      text: '已结束',
    )
  ];
  final List<Widget> _pages = <Widget>[
    MyActListAll(),
    MyActListNostart(),
    MyActListIng(),
    MyActListOver(),
  ];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的活动',
      bgColor: MainAppColor.mainSilverColor,
      child: Column(
        children: <Widget>[
          Container(
            width: Get.width,
            height: 40,
            child: TabBar(
              controller: _tabController,
              tabs: tabs,
              labelColor: Color(0xFF4245E5),
              unselectedLabelColor: MainAppColor.secondaryTextColor,
              indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
            ),
          ),
          Expanded(
            child: TabBarView(
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
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MyActivityPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
