import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/member_review_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/circle/my_member_review_page.dart';
import 'package:ws_app_flutter/views/circle/my_members_page.dart';

class MemberReviewPage extends StatefulWidget {
  @override
  MemberReviewPageState createState() => MemberReviewPageState();
}

class MemberReviewPageState extends State<MemberReviewPage>
    with SingleTickerProviderStateMixin {
  final MemberReviewController controller = Get.find<MemberReviewController>();
  final List<Tab> _tabs = <Tab>[
    Tab(
      text: '我的审核',
    ),
    Tab(
      text: '我的成员',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    MyMemberReviewPage(),
    MyMembersPage(),
  ];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '成员审核',
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
              tabs: _tabs,
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
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MemberReviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
