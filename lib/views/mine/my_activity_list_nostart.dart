import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/my_act_ing_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/widgets/wow/activity_list_item.dart';

class MyActListNostart extends GetView<MyActIngController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        onRefresh: () => controller.refresh(),
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
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ActivityListItem(
                              model: controller.list[index]);
                        },
                        childCount: controller.list.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
