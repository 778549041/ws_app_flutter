import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/enjoy/gallery_mall_model.dart';
import 'package:ws_app_flutter/view_models/enjoy/gallery_mall_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class GalleryMallPage extends StatefulWidget {
  @override
  GalleryMallPageState createState() => GalleryMallPageState();
}

class GalleryMallPageState extends State<GalleryMallPage>
    with TickerProviderStateMixin {
  final GalleryMallController controller = Get.find<GalleryMallController>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '积分商城',
      bgColor: MainAppColor.mainSilverColor,
      child: SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: () => controller.loadMore(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildBanner(),
            ),
            SliverToBoxAdapter(
              child: _buildSegment(),
            ),
            Obx(
              () => SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 15,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  return _buildGridItem(index);
                },
                itemCount: controller.list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: Get.width - 30,
      height: (Get.width - 30) * 194 / 345,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Obx(
        () => Swiper(
          //是否自动播放
          autoplay: controller.carouselData.length > 1,
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
          itemCount: controller.carouselData.length,
          itemBuilder: (context, index) {
            CarouselItem item = controller.carouselData[index];
            return Stack(
              children: <Widget>[
                NetImageWidget(
                  imageUrl: item.image_url,
                  width: Get.width - 30,
                  height: (Get.width - 30) * 194 / 345,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Offstage(
                    offstage: !item.is_vip!,
                    child: Image.asset(
                      'assets/images/enjoy/icon_car_owner.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSegment() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      height: 40,
      child: Obx(
        () => TabBar(
          isScrollable: true,
          controller: TabController(
              length: controller.tabsData.length,
              vsync: this,
              initialIndex: controller.tabsData.contains(controller.cat_id)
                  ? controller.tabsData.indexOf(controller.cat_id)
                  : 0),
          tabs: controller.tabsData.map((e) {
            return Tab(
              text: e.cat_name,
            );
          }).toList(),
          labelColor: Colors.black,
          unselectedLabelColor: Color(0xFF999999),
          labelStyle: TextStyle(fontSize: 18),
          unselectedLabelStyle: TextStyle(fontSize: 15),
          indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
          onTap: (index) => controller.tabIndexChanged(index),
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    ShopModel model = controller.list[index];
    return GestureDetector(
      onTap: () => controller.pushDetail(model),
      child: Padding(
        padding: index.isEven
            ? EdgeInsets.only(left: 15)
            : EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  NetImageWidget(
                    imageUrl: model.image,
                    width: (Get.width - 45) / 2,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Offstage(
                      offstage: !model.typeVip!,
                      child: Image.asset(
                        'assets/images/enjoy/icon_car_owner.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10),
              ),
            ),
            Offstage(
              offstage: int.parse(model.deduction!) == 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/enjoy/enjoy_price_point_red.png',
                    width: 7.5,
                    height: 8,
                  ),
                  Flexible(
                    child: Text(
                      TextUtil.formatComma3(model.deduction!),
                      style: TextStyle(color: Color(0xFFE30052), fontSize: 12),
                    ),
                  ),
                  Image.asset(
                    'assets/images/enjoy/car_owner_tag.png',
                    width: 40,
                    height: 11,
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: int.parse(model.integral!) == 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/enjoy/enjoy_price_point.png',
                    width: 7.5,
                    height: 8,
                  ),
                  Flexible(
                    child: Text(
                      TextUtil.formatComma3(model.integral!),
                      style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 12),
                    ),
                  ),
                  Image.asset(
                    'assets/images/enjoy/normal_user_tag.png',
                    width: 40,
                    height: 11,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(GalleryMallPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
