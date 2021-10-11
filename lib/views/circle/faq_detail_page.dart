import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/faq_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/circle/faq_answer_list_page.dart';
import 'package:ws_app_flutter/widgets/circle/faq_list_item.dart';

class FAQDetailPage extends StatefulWidget {
  @override
  FAQDetailPageState createState() => FAQDetailPageState();
}

class FAQDetailPageState extends State<FAQDetailPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final FAQDetailController controller = Get.find<FAQDetailController>();
  final List<Tab> _tabs = <Tab>[
    Tab(
      text: '全部回答',
    ),
    Tab(
      text: '我的回答',
    ),
  ];
  final List<Widget> _pages = <Widget>[
    FAQAnswerListPage(0),
    FAQAnswerListPage(1),
  ];
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BasePage(
      title: '问答详情',
      child: NestedScrollView(
        headerSliverBuilder: (c, f) {
          return <Widget>[
            Obx(
              () => SliverToBoxAdapter(
                child: controller.model.value.data == null
                    ? Container()
                    : FAQListItem(
                        model: controller.model.value.data!,
                        isDetail: true,
                      ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              height: 30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Obx(
                      () => Text(
                        '共${controller.model.value.data?.answers == null ? 0 : controller.model.value.data!.answers!}个回答',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      border: Border.all(width: 0.5, color: Color(0xFF1B7DF4)),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      tabs: _tabs,
                      labelStyle: TextStyle(fontSize: 15),
                      unselectedLabelStyle: TextStyle(fontSize: 15),
                      labelColor: Colors.white,
                      unselectedLabelColor: Color(0xFF1B7DF4),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                        padding: EdgeInsets.zero,
                        insets: EdgeInsets.zero,
                        indicatorHeight: 25,
                        indicatorRadius: 12.5,
                        indicatorColor: Color(0xFF1B7DF4),
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                  ),
                ],
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
  void didUpdateWidget(FAQDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
