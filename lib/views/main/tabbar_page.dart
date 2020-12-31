import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/views/car/car_page.dart';
import 'package:ws_app_flutter/views/circle/circle_page.dart';
import 'package:ws_app_flutter/views/enjoy/enjoy_page.dart';
import 'package:ws_app_flutter/views/mine/mine_page.dart';
import 'package:ws_app_flutter/views/wow/wow_page.dart';

class MainTabBarPage extends StatefulWidget {
  @override
  MainTabBarPageState createState() => MainTabBarPageState();
}

class MainTabBarPageState extends State<MainTabBarPage> {
  int _selectedIndex = 0;
  PageController _pageController;
  DateTime _lastPressed;
  List<Widget> _allPages = [
    WowPage(),
    CirclePage(),
    CarPage(),
    EnjoyPage(),
    MinePage(),
  ];

  List<String> _normalImageName = [
    'assets/images/tab_wow_normal.png',
    'assets/images/tab_circle_normal.png',
    'assets/images/tab_car_normal.png',
    'assets/images/tab_enjoy_normal.png',
    'assets/images/tab_mine_normal.png'
  ];
  List<String> _selectedImageName = [
    'assets/images/tab_wow_selected.png',
    'assets/images/tab_circle_selected.png',
    'assets/images/tab_car_selected.png',
    'assets/images/tab_enjoy_selected.png',
    'assets/images/tab_mine_selected.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (context, index) => _allPages[index],
          itemCount: _allPages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 54,
          padding: const EdgeInsets.only(top:5,bottom: 5),
          width: Get.width,
          child: Row(
            children: List.generate(
                _allPages.length,
                (index) => SizedBox(
                      height: 49,
                      width: Get.width / 5,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: _selectedIndex == index
                            ? Image.asset(_selectedImageName[index])
                            : Image.asset(_normalImageName[index]),
                        onTap: () {
                          _pageController.jumpToPage(index);
                        },
                      ),
                    )),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
