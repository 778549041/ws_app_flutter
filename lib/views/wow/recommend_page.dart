import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
import 'package:ws_app_flutter/widgets/car/control_loading_view.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';
import 'package:ws_app_flutter/widgets/wow/news_list_item.dart';
import 'package:ws_app_flutter/widgets/wow/recommend_act_item.dart';
import 'package:ws_app_flutter/widgets/wow/recommend_banner.dart';
import 'package:ws_app_flutter/widgets/wow/recommend_ele.dart';

class RecommendPage extends GetView<RecommendController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 22,
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
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.refresh,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: RecommendBanner(),
                  ),
                  if (controller.userInfo.value.member.isVehicle == 'true')
                    SliverToBoxAdapter(
                      child: RecommendEle(),
                    ),
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CircleListItem(
                            model: controller.momentListModel.value.list[index],
                            pageName: 'recommendCircle',
                          ),
                        );
                      },
                          childCount:
                              (controller.momentListModel.value.list.length > 3)
                                  ? 3
                                  : controller
                                      .momentListModel.value.list.length),
                    ),
                  ),
                  Obx(() => SliverToBoxAdapter(
                        child: Offstage(
                          offstage:
                              controller.newsListModel.value.list.length == 0,
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                      )),
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return NewsListItem(
                          model: controller.newsListModel.value.list[index],
                        );
                      },
                          childCount:
                              controller.newsListModel.value.list.length),
                    ),
                  ),
                  Obx(
                    () => SliverToBoxAdapter(
                      child: Offstage(
                        offstage:
                            controller.activityListModel.value.data.length == 0,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          width: Get.width,
                          color: Color(0xFFF3F3F3),
                          child: Text(
                            'VE-1活动',
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
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return RecommendActItem(
                          model: controller.activityListModel.value.data[index],
                        );
                      },
                          childCount:
                              controller.activityListModel.value.data.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 60 - ScreenUtil.getInstance().statusBarHeight,
          right: 20,
          child: ControlLoadingView(),
        ),
      ],
    );
  }
}
