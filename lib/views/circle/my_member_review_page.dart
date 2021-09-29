import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/topic_apply_join_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/circle/my_member_review_controller.dart';
import 'package:ws_app_flutter/widgets/circle/member_review_item.dart';

class MyMemberReviewPage extends GetView<MyMemberReviewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MainAppColor.mainSilverColor,
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
                        TopicApplyJoinModel item = controller.list[index];
                        return MemberReviewItem(item, 0);
                      }, childCount: controller.list.length),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
