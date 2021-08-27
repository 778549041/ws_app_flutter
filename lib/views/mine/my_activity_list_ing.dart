import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/my_act_nostart_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/wow/activity_list_item.dart';

class MyActListIng extends GetView<MyActNostartController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bgColor: MainAppColor.mainSilverColor,
      child: Obx(
        () {
          if (controller.isEmpty()) {
            return ViewStateEmptyWidget(
              image: 'assets/images/common/empty.png',
              message: '空空如也',
              buttonText: '重新加载',
              onPressed: () => controller.refresh(),
            );
          } else {
            return SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              onRefresh: () => controller.refresh(),
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ActivityListItem(model: controller.list[index]);
                      },
                      childCount: controller.list.length,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
