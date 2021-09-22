import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/circle/leader_my_apply_topic_controller.dart';
import 'package:ws_app_flutter/widgets/circle/circle_topic_item.dart';

class LeaderMyApplyTopicPage extends GetView<LeaderMyApplyTopicController> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () => controller.refresh(),
      enablePullUp: true,
      onLoading: () => controller.loadMore(),
      child: CustomScrollView(
        slivers: [
          Obx(
            () => controller.isEmpty()
                ? SliverToBoxAdapter(
                    child: ViewStateEmptyWidget(
                      image: 'assets/images/common/empty.png',
                      message: '空空如也',
                      buttonText: '重新加载',
                      onPressed: () => controller.refresh(),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      TopicModel item = controller.list[index];
                      return CircleTopicItem(item, 2);
                    }, childCount: controller.list.length),
                  ),
          ),
        ],
      ),
    );
  }
}
