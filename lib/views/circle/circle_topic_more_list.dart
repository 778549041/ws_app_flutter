import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_more_list_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/circle/circle_topic_item.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CircleTopicMoreList extends GetView<CircleTopicMoreListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '话题列表',
      child: Column(
        children: <Widget>[
          Expanded(
            child: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () => controller.refresh(),
              enablePullUp: true,
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                slivers: [
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        TopicModel item = controller.list[index];
                        return CircleTopicItem(item, 0);
                      }, childCount: controller.list.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Get.find<UserController>()
                    .userInfo
                    .value
                    .member!
                    .memberInfo!
                    .isLeader!
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      children: <Widget>[
                        CustomButton(
                          title: '我的话题',
                          titleColor: Colors.white,
                          backgroundColor: Color(0xFF1B7DF4),
                          width: (Get.width - 80) / 2,
                          height: 40,
                          radius: 20,
                          onPressed: () => controller.pushAction(0),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                          title: '创建话题',
                          titleColor: Colors.white,
                          backgroundColor: Color(0xFF1B7DF4),
                          width: (Get.width - 80) / 2,
                          height: 40,
                          radius: 20,
                          onPressed: () => controller.pushAction(1),
                        )
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
