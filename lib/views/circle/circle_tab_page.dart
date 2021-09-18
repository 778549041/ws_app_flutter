import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/circle_tab_controller.dart';
import 'package:ws_app_flutter/views/circle/moment_list_page.dart';
import 'package:ws_app_flutter/widgets/circle/circle_header.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CircleTabPage extends StatefulWidget {
  @override
  CircleTabPageState createState() => CircleTabPageState();
}

class CircleTabPageState extends State<CircleTabPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final CircleTabController controller = Get.find<CircleTabController>();
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollView(
      headerSliverBuilder: (c, f) {
        return <Widget>[
          SliverToBoxAdapter(
            child: CircleHeader(),
          ),
        ];
      },
      body: _buildBody(),
    );
  }

  //body
  Widget _buildBody() {
    return Obx(() {
      if (controller.tabsData.length == 0) {
        return Container();
      }
      _tabController = TabController(
        initialIndex: controller.currentIndex!,
        length: controller.tabsData.length,
        vsync: this,
      );
      return Column(
        children: <Widget>[
          Flexible(
            child: _buildCircleTabBar(),
          ),
          Flexible(
            child: _buildTabbarView(),
            flex: 10,
          ),
        ],
      );
    });
  }

  //圈子分类标签tab
  Widget _buildCircleTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: Get.width - 70,
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: controller.tabsData.map((e) {
                return Tab(
                  text: e.title,
                );
              }).toList(),
              labelColor: Colors.white,
              unselectedLabelColor: MainAppColor.secondaryTextColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                indicatorHeight: 30,
                indicatorRadius: 15,
                indicatorColor: Color(0xFF1B7DF4),
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              onTap: (index) => controller.indexChanged(index),
            ),
          ),
          CustomButton(
            width: 40,
            height: 40,
            image: 'assets/images/circle/manage_tag_plus.png',
            imageH: 12.5,
            imageW: 12.5,
            onPressed: () {
              //TODO
              print('点击了编辑标签');
            },
          ),
        ],
      ),
    );
  }

  //圈子标签分类tabbarview
  Widget _buildTabbarView() {
    return TabBarView(
      children: controller.tabsData.map((e) {
        return MomentListPage(
          tagId: e.tag_id!,
        );
      }).toList(),
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CircleTabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
