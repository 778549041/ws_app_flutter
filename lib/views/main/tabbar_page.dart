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

class MainTabBarPage extends GetView<MainController> {
  final List<Widget> _allPages = [
    WowPage(),
    CirclePage(),
    CarPage(),
    EnjoyPage(),
    MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => controller.onWillPop(),
          child: PageView.builder(
            itemBuilder: (context, index) => _allPages[index],
            itemCount: _allPages.length,
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) => controller.onChangeValue(value),
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
}
