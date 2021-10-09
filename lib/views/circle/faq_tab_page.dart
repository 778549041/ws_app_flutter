import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ws_app_flutter/views/circle/faq_tab_list_page.dart';

class FAQTabPage extends StatefulWidget {
  @override
  FAQTabPageState createState() => FAQTabPageState();
}

class FAQTabPageState extends State<FAQTabPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List<Tab> _tabs = <Tab>[
    Tab(
      text: '热门问答',
    ),
    Tab(
      text: '随便看看',
    ),
    Tab(
      text: '往期热点',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    FaqTabListPage(0),
    FaqTabListPage(1),
    FaqTabListPage(2),
  ];
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF1B7DF4),
          ),
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
  void didUpdateWidget(FAQTabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
