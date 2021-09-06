import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/car/exterior_parts.dart';
import 'package:ws_app_flutter/views/car/interior_parts.dart';
import 'package:ws_app_flutter/views/car/smart_parts.dart';

class CarPartsPage extends StatefulWidget {
  @override
  CarPartsPageState createState() => CarPartsPageState();
}

class CarPartsPageState extends State<CarPartsPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(
      text: 'SMART智能',
    ),
    Tab(
      text: 'EXTERIOR外型',
    ),
    Tab(
      text: 'INTERIOR内饰',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    SmartPartsPage(),
    ExteriorPartsPage(),
    InteriorPartsPage(),
  ];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的活动',
      bgColor: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(40, 10, 40, 20),
            child: Text(
              '同步研发、量身定制、精准装配、坚固耐用\n最高三年或十万公里贴心质保\n提供优越的安全性与品质保证',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            width: Get.width,
            height: 40,
            child: TabBar(
              controller: _tabController,
              tabs: tabs,
              labelColor: Color(0xFF1c7ef4),
              unselectedLabelColor: Color(0xFF1c7ef4).withOpacity(0.5),
              labelStyle: TextStyle(fontSize: 16),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              indicatorColor: Color(0xFF1c7ef4),
            ),
          ),
          Expanded(
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
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CarPartsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
