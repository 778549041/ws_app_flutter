import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/content_review_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/circle/comment_review_page.dart';
import 'package:ws_app_flutter/views/circle/moment_review_page.dart';

class ContentReviewPage extends StatefulWidget {
  @override
  ContentReviewPageState createState() => ContentReviewPageState();
}

class ContentReviewPageState extends State<ContentReviewPage>
    with SingleTickerProviderStateMixin {
  final ContentReviewController controller =
      Get.find<ContentReviewController>();
  final List<Tab> _tabs = <Tab>[
    Tab(
      text: '动态审核',
    ),
    Tab(
      text: '评论审核',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    MomentReviewPage(),
    CommentReviewPage(),
  ];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '内容审核',
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
  void didUpdateWidget(ContentReviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
