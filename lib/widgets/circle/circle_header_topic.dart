import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class CircleHeaderTopic extends StatelessWidget {
  final List<TopicModel> list;

  CircleHeaderTopic({required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          if (int.parse(
                  Get.find<UserController>().msgModel.value.circleCount!) >
              0)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                //TODO
                print('点击了圈子新消息');
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      style: TextStyle(color: Colors.white, fontSize: 15),
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
                  Get.toNamed(Routes.CIRCLETOPICMORE);
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
              autoplay: list.length > 1,
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
              itemCount: list.length,
              onTap: (int index) {
                //点击事件，返回下标
                TopicModel item = list[index];
                Get.toNamed(Routes.CIRCLTOPICLIST,
                    arguments: {'topcid': item.topicId!});
              },
              itemBuilder: (context, index) {
                return _buildTopicItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  //精彩话题item
  Widget _buildTopicItem(int index) {
    TopicModel item = list[index];
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
}
