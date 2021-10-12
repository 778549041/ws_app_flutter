import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/mine_faq_tab_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/mine/mine_answer_page.dart';
import 'package:ws_app_flutter/views/mine/mine_question_page.dart';

class MineFaqTabPage extends StatefulWidget {
  @override
  MineFaqTabPageState createState() => MineFaqTabPageState();
}

class MineFaqTabPageState extends State<MineFaqTabPage> with SingleTickerProviderStateMixin {
  final MineFaqTabController controller =
      Get.find<MineFaqTabController>();
  final List<Tab> tabs = <Tab>[
    Tab(
      text: '我的提问',
    ),
    Tab(
      text: '我的回答',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    MineQuestionPage(),
    MineAnswerPage(),
  ];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的问答',
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF1B7DF4),
            ),
            width: 200,
            height: 40,
            child: TabBar(
              controller: _tabController,
              tabs: tabs,
              labelColor: Color(0xFF1B7DF4),
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                indicatorHeight: 30,
                indicatorRadius: 15,
                indicatorColor: Colors.white,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
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
  void didUpdateWidget(MineFaqTabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}