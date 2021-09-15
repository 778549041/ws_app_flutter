import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/circle_tab_controller.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';

class CircleTabPage extends StatefulWidget {
  @override
  CircleTabPageState createState() => CircleTabPageState();
}

class CircleTabPageState extends State<CircleTabPage>
    with TickerProviderStateMixin {
  final CircleTabController controller = Get.find<CircleTabController>();
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () => controller.refresh(),
      enablePullUp: true,
      onLoading: () => controller.loadMore(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '热门榜',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  StaggeredGridView.countBuilder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      // return _buildGridItem(index);
                      return Container();
                    },
                    itemCount: 9,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '精彩话题',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: Get.width - 30,
                    height: 100,
                    child: Swiper(
                      //是否自动播放
                      autoplay: false,
                      //自动播放延迟
                      autoplayDelay: 3000,
                      //pagination是否显示在外面
                      outer: true,
                      //触发时是否停止播放
                      autoplayDisableOnInteraction: true,
                      //动画时间
                      duration: 600,
                      //默认指示器
                      pagination: SwiperPagination(
                        // SwiperPagination.fraction 数字1/5，默认点
                        builder: DotSwiperPaginationBuilder(
                          color: Colors.black,
                          activeColor: Color(0xFF2673FB),
                          size: 8,
                          activeSize: 10,
                        ),
                      ),
                      // viewportFraction: 0.8,
                      //视图宽度，即显示的item的宽度屏占比
                      //scale: 0.9,
                      //两侧item的缩放比
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          width: Get.width - 30,
                          height: 100,
                        );
                        // CarouselItem item = controller.carouselData[index];
                        // return Stack(
                        //   children: <Widget>[
                        //     NetImageWidget(
                        //       imageUrl: item.image_url,
                        //       width: Get.width - 30,
                        //       height: (Get.width - 30) * 194 / 345,
                        //     ),
                        //     Positioned(
                        //       right: 0,
                        //       top: 0,
                        //       child: Offstage(
                        //         offstage: !item.is_vip!,
                        //         child: Image.asset(
                        //           'assets/images/enjoy/icon_car_owner.png',
                        //           width: 40,
                        //           height: 40,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '官方动态',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, idx) {
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _buildCircleTabBar(),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                    ],
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleTabBar() {
    // _tabController?.dispose();
    // _tabController = TabController(
    //     length: controller.tabsData.length,
    //     vsync: this,
    //     initialIndex: controller.tabsData.contains(controller.cat_id)
    //         ? controller.tabsData.indexOf(controller.cat_id)
    //         : 0);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        isScrollable: true,
        controller: _tabController,
        tabs: [
          Tab(
            text: '热门',
          ),
          Tab(
            text: '主理人',
          ),
          Tab(
            text: '同城',
          ),
          Tab(
            text: '优质',
          ),
          Tab(
            text: '摄影',
          ),
        ],
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
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
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
