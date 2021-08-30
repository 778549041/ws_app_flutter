import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/mine/integral_outcome_controller.dart';

class IntegralOutcomePage extends GetView<IntegralOutcomeController> {
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
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container();
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
