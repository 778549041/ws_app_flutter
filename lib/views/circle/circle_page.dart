import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/circle/circle_controller.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';
import 'package:ws_app_flutter/widgets/circle/circle_topic.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CirclePage extends GetView<CircleController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/common/bg.png',
          width: Get.width,
          height: Get.height / 2,
          fit: BoxFit.cover,
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil.getInstance().statusBarHeight,
                  left: 15,
                  right: 15),
              padding: const EdgeInsets.only(top: 5),
              width: Get.width,
              height: 40,
              child: Row(
                children: <Widget>[
                  Container(
                    width: Get.width - 75,
                    height: 35,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/wow/icon_search_grey.png',
                          width: 15,
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('圈子搜索');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              '大家都在搜“VE-1新车发布”',
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomButton(
                      backgroundColor: Colors.transparent,
                      width: 30,
                      height: 30,
                      image: 'assets/images/wow/active_menu.png',
                      imageW: 23,
                      imageH: 22,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 22),
                decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    header: WaterDropHeader(),
                    onRefresh: () => controller.refresh(),
                    enablePullUp: true,
                    onLoading: () => controller.loadMore(),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, bottom: 15),
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Text(
                              '话题活动',
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: CircleTopicItem(),
                        ),
                        Obx(
                          () => SliverToBoxAdapter(
                            child: Offstage(
                              offstage: controller.list.length == 0,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 15),
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Text(
                                  '热门动态',
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CircleListItem(
                                  model: controller.list[index],
                                  pageName: 'circleList',
                                ),
                              );
                            }, childCount: controller.list.length),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
