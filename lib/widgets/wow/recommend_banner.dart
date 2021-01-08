import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';

class RecommendBanner extends GetView<RecommendController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: Get.width - 30,
          height: (Get.width - 30) * 295 / 345 + 30,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Swiper(
              //是否自动播放
              autoplay: true,
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
                print("index-----" + index.toString());
              },
              itemCount: 5,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/common/bg.png',
                    fit: BoxFit.cover,
                    width: Get.width - 30,
                    height: (Get.width - 30) * 295 / 345,
                  ),
                );
              }),
        ),
        Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            width: Get.width - 30,
            height: 32,
            child: Stack(
              children: <Widget>[
                Swiper(
                    //是否自动播放
                    autoplay: true,
                    //自动播放延迟
                    autoplayDelay: 3000,
                    scrollDirection: Axis.vertical,
                    //动画时间
                    duration: 600,
                    onTap: (int index) {
                      //点击事件，返回下标
                      print("index-----" + index.toString());
                    },
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.width - 30,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(colors: [
                              Color(0xFF2659FF),
                              Color(0xFF01D4D7)
                            ])),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$index',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    }),
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
      ],
    );
  }
}
