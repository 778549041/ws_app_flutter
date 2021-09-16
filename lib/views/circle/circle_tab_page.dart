import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_hot_model.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/view_models/circle/circle_tab_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/circle/moment_list_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

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
      headerSliverBuilder: (BuildContext c, bool f) {
        return <Widget>[
          SliverToBoxAdapter(
            child: _buildHotGrid(),
          ),
          SliverToBoxAdapter(
            child: _buildTopicBanner(),
          ),
          SliverToBoxAdapter(
            child: _buildOfficialList(),
          ),
        ];
      },
      body: _buildBody(),
    );
  }

  //热门榜
  Widget _buildHotGrid() {
    return Obx(
      () => controller.hotData.value.data == null
          ? Container()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    padding: const EdgeInsets.only(top: 10),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      return _buildGridItem(index);
                    },
                    itemCount: controller.hotData.value.data!.length + 1,
                  )
                ],
              ),
            ),
    );
  }

  //热门榜item
  Widget _buildGridItem(int index) {
    if (index == controller.hotData.value.data!.length) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          //TODO
          print('点击了热门榜更多');
        },
        child: Container(
          height: 30,
          padding: const EdgeInsets.only(left: 27),
          alignment: AlignmentDirectional.centerStart,
          child: Image.asset(
            'assets/images/circle/hot_more_hot.png',
            width: 76,
            height: 14,
            scale: 2,
          ),
        ),
      );
    }
    CircleHotData item = controller.hotData.value.data![index];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //TODO
        print('点击了热门榜第$index个元素');
      },
      child: Container(
        height: 30,
        child: Row(
          children: <Widget>[
            Image.asset(
              item.typeImgName!,
              width: 22,
              height: 12,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                item.title!,
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //精彩话题
  Widget _buildTopicBanner() {
    return Obx(
      () => controller.topicData.value.list!.length == 0
          ? Container()
          : Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  if (int.parse(Get.find<UserController>()
                          .msgModel
                          .value
                          .circleCount!) >
                      0)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        //TODO
                        print('点击了圈子新消息');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFABABAB),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            NetImageWidget(
                              imageUrl: Get.find<UserController>()
                                  .msgModel
                                  .value
                                  .memberInfo
                                  ?.avatar,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${Get.find<UserController>().msgModel.value.circleCount}条新消息',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '精彩话题',
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomButton(
                        width: 34,
                        height: 20,
                        image: 'assets/images/circle/circle_more.png',
                        imageW: 34,
                        imageH: 20,
                        onPressed: () {
                          //TODO
                          print('点击了精彩话题更多');
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: Get.width - 30,
                    height: (Get.width - 30) * 408 / 750 + 30,
                    child: Swiper(
                      //是否自动播放
                      autoplay: controller.topicData.value.list!.length > 1,
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
                        margin: const EdgeInsets.only(top: 10),
                        builder: DotSwiperPaginationBuilder(
                          color: Colors.black,
                          activeColor: Color(0xFF2673FB),
                          size: 8,
                          activeSize: 10,
                        ),
                      ),
                      itemCount: controller.topicData.value.list!.length,
                      onTap: (int index) {
                        //点击事件，返回下标
                        TopicModel item =
                            controller.topicData.value.list![index];
                        //TODO
                        print('点击了${item.topicId}的话题');
                      },
                      itemBuilder: (context, index) {
                        return _buildTopicItem(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  //精彩话题item
  Widget _buildTopicItem(int index) {
    TopicModel item = controller.topicData.value.list![index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(
        children: <Widget>[
          NetImageWidget(
            imageUrl: item.imageUrl,
            width: Get.width - 30,
            height: (Get.width - 30) * 408 / 750,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Offstage(
                        offstage: !(item.self! || item.hot! || item.isNew!),
                        child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Image.asset(
                            item.tagImg!,
                            width: 28,
                            height: 16,
                          ),
                        ),
                      ),
                      Text(
                        item.title!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  Text('${item.join!}条动态',
                      style: TextStyle(color: Colors.white, fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //官方动态
  Widget _buildOfficialList() {
    return Obx(
      () => controller.officialData.value.list!.length == 0
          ? Container()
          : Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '官方动态',
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomButton(
                        width: 34,
                        height: 20,
                        image: 'assets/images/circle/circle_more.png',
                        imageW: 34,
                        imageH: 20,
                        onPressed: () {
                          //TODO
                          print('点击了官方动态更多');
                        },
                      ),
                    ],
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.officialData.value.list!.length > 2
                        ? 2
                        : controller.officialData.value.list!.length,
                    itemBuilder: (context, idx) {
                      return _buildOfficialItem(idx);
                    },
                  ),
                ],
              ),
            ),
    );
  }

  //官方动态item
  Widget _buildOfficialItem(int index) {
    MomentModel item = controller.officialData.value.list![index];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //TODO
        print('点击了官方动态第$index个元素');
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            NetImageWidget(
              imageUrl: item.image_url,
              width: 85,
              height: 52,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                item.content!,
                style: TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //body
  Widget _buildBody() {
    return Obx(() {
      if (controller.tabsData.length == 0) {
        return Container();
      }
      _tabController = TabController(
        length: controller.tabsData.length,
        vsync: this,
      );
      return Column(
        children: <Widget>[
          _buildCircleTabBar(),
          Expanded(
            child: _buildTabbarView(),
          ),
        ],
      );
    });
  }

  //圈子分类标签tab
  Widget _buildCircleTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
            ),
          ),
          CustomButton(
            width: 40,
            height: 40,
            image: 'assets/images/circle/manage_tag_plus.png',
            imageH: 12.5,
            imageW: 12.5,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  //圈子标签分类tabbarview
  Widget _buildTabbarView() {
    return TabBarView(
      children: controller.tabsData.map((e) {
        return MomentListPage();
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
