import 'package:flutter/material.dart';
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

  final List<String> _normalImageName = [
    'assets/images/tabbar/tab_wow_normal.png',
    'assets/images/tabbar/tab_circle_normal.png',
    'assets/images/tabbar/tab_car_normal.png',
    'assets/images/tabbar/tab_enjoy_normal.png',
    'assets/images/tabbar/tab_mine_normal.png'
  ];
  final List<String> _selectedImageName = [
    'assets/images/tabbar/tab_wow_selected.png',
    'assets/images/tabbar/tab_circle_selected.png',
    'assets/images/tabbar/tab_car_selected.png',
    'assets/images/tabbar/tab_enjoy_selected.png',
    'assets/images/tabbar/tab_mine_selected.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 54,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          width: Get.width,
          child: Row(
            children: List.generate(
                _allPages.length,
                (index) => SizedBox(
                      height: 49,
                      width: Get.width / 5,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Obx(
                          () => controller.selectedIndex.value == index
                              ? Image.asset(_selectedImageName[index])
                              : Image.asset(_normalImageName[index]),
                        ),
                        onTap: () => controller.onItemTap(index),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
