import 'package:expandable_text/expandable_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';
import 'package:ws_app_flutter/widgets/global/draggable_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CircleTopicListPage extends GetView<CircleTopicListController> {
  final String topcId = Get.arguments == null ? null : Get.arguments['topcid'];

  @override
  Widget build(BuildContext context) {
    controller.topicId.value = topcId;
    return BasePage(
      title: '话题活动',
      bgColor: MainAppColor.mainSilverColor,
      child: Stack(
        children: <Widget>[
          SmartRefresher(
            controller: controller.refreshController,
            onRefresh: () => controller.refresh(),
            enablePullUp: true,
            onLoading: () => controller.loadMore(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Obx(
                                () => NetImageWidget(
                                  width: Get.width,
                                  height: Get.width * 204 / 375,
                                  imageUrl: controller
                                      .topicDetailModel.value.list.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 5, bottom: 5),
                                    color: Colors.black.withOpacity(0.4),
                                    child: Row(
                                      children: <Widget>[
                                        Obx(
                                          () => RoundAvatar(
                                            imageUrl: controller
                                                .topicDetailModel
                                                .value
                                                .list
                                                .adminUrl,
                                            height: 40,
                                            borderWidth: 0,
                                            borderColor: Colors.transparent,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Obx(
                                              () => Text(
                                                controller.topicDetailModel
                                                    .value.list.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                '${controller.topicDetailModel.value.list.totalNum}人参与',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '话题',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Obx(() => ExpandableText(
                                      controller
                                          .topicDetailModel.value.list.content,
                                      expandText: '[更多]',
                                      collapseText: '[收起]',
                                      linkColor: Color(0xFF1B7DF4),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CircleListItem(
                          model: controller.list[index],
                          pageName: 'circleTopicList',
                        ),
                      );
                    }, childCount: controller.list.length),
                  ),
                ),
              ],
            ),
          ),
          DraggableButton(
              data: 'dfab_demo',
              offset: Offset(
                  Get.width - 56,
                  Get.height -
                      Get.statusBarHeight -
                      Get.bottomBarHeight -
                      100 -
                      ScreenUtil.getInstance().appBarHeight),
              child: Image.asset('assets/images/circle/circle_publish.png'),
              onPressed: () => controller.pushToPublish(),
              appBarHeight: ScreenUtil.getInstance().appBarHeight,
              appContext: context),
        ],
      ),
    );
  }
}
