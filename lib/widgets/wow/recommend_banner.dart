import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ws_app_flutter/models/wow/banner_model.dart';
import 'package:ws_app_flutter/models/wow/text_banner.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';

class RecommendBanner extends GetView<RecommendController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFF3F3F3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              width: Get.width - 30,
              height: (Get.width - 30) * 295 / 345 + 30,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Obx(() => Swiper(
                  //是否自动播放
                  autoplay: controller
                          .bannerModel.value.carouselHead.banner.items.length >
                      1,
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
                        activeSize: 10),
                  ),
                  // viewportFraction: 0.8,
                  //视图宽度，即显示的item的宽度屏占比
                  //scale: 0.9,
                  //两侧item的缩放比
                  onTap: (int index) {
                    //点击事件，返回下标
                    BannerItem item = controller
                        .bannerModel.value.carouselHead.banner.items[index];
                  },
                  itemCount: controller
                      .bannerModel.value.carouselHead.banner.items.length,
                  itemBuilder: (context, index) {
                    BannerItem item = controller
                        .bannerModel.value.carouselHead.banner.items[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        width: Get.width - 30,
                        height: (Get.width - 30) * 295 / 345,
                        fit: BoxFit.cover,
                      ),
                    );
                  })),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        colors: [Color(0xFF2659FF), Color(0xFF01D4D7)])),
                margin: EdgeInsets.only(left: 15, right: 15),
                width: Get.width - 30,
                height: 32,
                child: Stack(
                  children: <Widget>[
                    Obx(() => Swiper(
                        //是否自动播放
                        autoplay:
                            controller.textBannerModel.value.data.length > 1,
                        loop: controller.textBannerModel.value.data.length > 1,
                        //自动播放延迟
                        autoplayDelay: 3000,
                        scrollDirection: Axis.vertical,
                        //触发时是否停止播放
                        autoplayDisableOnInteraction: false,
                        //动画时间
                        duration: 600,
                        onTap: (int index) {
                          //点击事件，返回下标
                          TextBannerModel item =
                              controller.textBannerModel.value.data[index];
                        },
                        itemCount: controller.textBannerModel.value.data.length,
                        itemBuilder: (context, index) {
                          TextBannerModel item =
                              controller.textBannerModel.value.data[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.content,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          );
                        })),
                    Positioned(
                      top: 0,
                      left: Get.width - 56,
                      child: Image.asset(
                        'assets/images/wow/banner_hot.png',
                        width: 26,
                        height: 23,
                      ),
                    )
                  ],
                )),
                SizedBox(height: 20,)
          ],
        ),
      ],
    );
  }
}
