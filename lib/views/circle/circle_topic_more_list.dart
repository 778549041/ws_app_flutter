import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_more_list_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

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
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => controller.selectTopic(item),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 15, right: 15),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    NetImageWidget(
                                      imageUrl: item.imageUrl!,
                                      width: 148,
                                      height: 104,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.title!,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            '${item.totalNum}人参与',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: MainAppColor
                                                    .secondaryTextColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                  color: Color(0xFFD6D6D6),
                                  height: 0.5,
                                ),
                              ],
                            ),
                          ),
                        );
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
                          onPressed: () {
                            //TODO 跳转我的话题
                          },
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
                          onPressed: () {
                            //TODO 跳转创建话题
                          },
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
