import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/integral_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/mine/integral_income_page.dart';
import 'package:ws_app_flutter/views/mine/integral_outcome_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class IntegralPage extends StatefulWidget {
  @override
  IntegralPageState createState() => IntegralPageState();
}

class IntegralPageState extends State<IntegralPage>
    with SingleTickerProviderStateMixin {
  final IntegralController controller = Get.find<IntegralController>();
  final List<Tab> tabs = <Tab>[
    Tab(
      text: '积分获取',
    ),
    Tab(
      text: '积分支出',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    IntegralIncomePage(),
    IntegralOutcomePage(),
  ];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的积分',
      bgColor: MainAppColor.mainSilverColor,
      rightItems: [
        CustomButton(
          backgroundColor: Colors.transparent,
          image: 'assets/images/mine/calendar.png',
          width: 100,
          height: 30,
          imageH: 20,
          imageW: 20,
          onPressed: () => controller.selectDate(),
        ),
      ],
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '我的积分总额',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 15),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Obx(
                        () => RichText(
                          text: TextSpan(
                            text: TextUtil.formatComma3(
                                Get.find<UserController>()
                                    .userInfo
                                    .value
                                    .member!
                                    .integral!),
                            style: TextStyle(fontSize: 45, color: Colors.black),
                            children: [
                              TextSpan(
                                text: ' 积分',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      width: 90,
                      height: 30,
                      radius: 15,
                      backgroundColor: Color(0xFF4245E5),
                      title: '使用积分>>',
                      titleColor: Colors.white,
                      onPressed: () => controller.pushAction(0),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
            width: 200,
            height: 40,
            child: TabBar(
              controller: _tabController,
              tabs: tabs,
              labelColor: Colors.white,
              unselectedLabelColor: MainAppColor.secondaryTextColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                indicatorHeight: 30,
                indicatorRadius: 15,
                indicatorColor: Color(0xFF4245E5),
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
          SizedBox(
            height: 30,
          ),
          CustomButton(
            width: 170,
            height: 40,
            radius: 20,
            backgroundColor: Color(0xFF4245E5),
            title: '积分规则',
            titleColor: Colors.white,
            onPressed: () => controller.pushAction(1),
          ),
          SizedBox(
            height: 20,
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
  void didUpdateWidget(IntegralPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
