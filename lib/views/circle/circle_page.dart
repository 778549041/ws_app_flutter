import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/circle_controller.dart';
import 'package:ws_app_flutter/views/circle/circle_tab_page.dart';
import 'package:ws_app_flutter/views/circle/faq_tab_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/draggable_button.dart';

class CirclePage extends StatefulWidget {
  @override
  CirclePageState createState() => CirclePageState();
}

class CirclePageState extends State<CirclePage>
    with SingleTickerProviderStateMixin {
  final CircleController controller = Get.find<CircleController>();
  final List<Tab> _tabs = <Tab>[
    Tab(
      text: '圈子动态',
    ),
    Tab(
      text: '问答专区',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    CircleTabPage(),
    FAQTabPage(),
  ];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/common/bg.png',
          width: Get.width,
          height: Get.height / 2,
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight,
              left: 15,
              right: 15),
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          width: Get.width,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  tabs: _tabs,
                  onTap: (value) => controller.tabIndexChanged(value),
                ),
              ),
              CustomButton(
                backgroundColor: Colors.transparent,
                width: 40,
                height: 40,
                image: 'assets/images/circle/icon_search_white.png',
                imageW: 23,
                imageH: 22,
                onPressed: () => controller.buttonAction(1000),
              ),
              CustomButton(
                backgroundColor: Colors.transparent,
                width: 40,
                height: 40,
                image: 'assets/images/mine/mine_add_friend.png',
                imageW: 23,
                imageH: 22,
                onPressed: () => controller.buttonAction(1001),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight + 60),
          decoration: BoxDecoration(
              color: Color(0xFFF3F3F3),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _pages,
            ),
          ),
        ),
        DraggableButton(
          data: 'dfab_demo',
          offset:
              Offset(Get.width - 56, Get.height - Get.bottomBarHeight - 154),
          child: Image.asset('assets/images/circle/circle_publish.png'),
          onPressed: () => controller.buttonAction(1002),
          bottomBarHeight: 54,
          appContext: context,
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
  void didUpdateWidget(CirclePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
