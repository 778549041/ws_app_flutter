import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';
import 'package:ws_app_flutter/views/car/car_page.dart';
import 'package:ws_app_flutter/views/circle/circle_page.dart';
import 'package:ws_app_flutter/views/enjoy/enjoy_page.dart';
import 'package:ws_app_flutter/views/mine/mine_page.dart';
import 'package:ws_app_flutter/views/wow/wow_page.dart';

class MainTabBarPage extends StatefulWidget {
  @override
  MainTabBarPageState createState() => MainTabBarPageState();
}

class MainTabBarPageState extends State<MainTabBarPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final MainController controller = Get.find<MainController>();
  final List<Widget> _allPages = [
    WowPage(),
    CirclePage(),
    CarPage(),
    EnjoyPage(),
    MinePage(),
  ];
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => controller.onWillPop(),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _allPages,
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          items: [
            TabItem<Image>(
                icon: Image.asset('assets/images/tabbar/tab_wow_normal.png'),
                activeIcon:
                    Image.asset('assets/images/tabbar/tab_wow_selected.png')),
            TabItem<Image>(
                icon: Image.asset('assets/images/tabbar/tab_circle_normal.png'),
                activeIcon: Image.asset(
                    'assets/images/tabbar/tab_circle_selected.png')),
            TabItem<Image>(
                icon: Image.asset('assets/images/tabbar/tab_car_normal.png'),
                activeIcon:
                    Image.asset('assets/images/tabbar/tab_car_selected.png')),
            TabItem<Image>(
                icon: Image.asset('assets/images/tabbar/tab_enjoy_normal.png'),
                activeIcon:
                    Image.asset('assets/images/tabbar/tab_enjoy_selected.png')),
            TabItem<Image>(
                icon: Image.asset('assets/images/tabbar/tab_mine_normal.png'),
                activeIcon:
                    Image.asset('assets/images/tabbar/tab_mine_selected.png')),
          ],
          backgroundColor: Colors.white,
          curveSize: 0,
          top: 0,
          initialActiveIndex: 0,
          onTap: (index) => controller.onItemTap(index),
        ),
      ),
      value: SystemUiOverlayStyle.light,
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    controller.tabController = _tabController;
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MainTabBarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
