import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/circle/single_user_circle_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';

class SingleUserCircleListPage extends GetView<SingleUserCircleController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '圈子列表',
      child: SmartRefresher(
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
                        return Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CircleListItem(
                            model: controller.list[index],
                            pageName:
                                'singleUserCircleList${controller.memberId}',
                          ),
                        );
                      }, childCount: controller.list.length),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
