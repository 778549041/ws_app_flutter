import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/review_comment_list_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/circle/comment_review_controller.dart';
import 'package:ws_app_flutter/widgets/circle/comment_review_item.dart';

class CommentReviewPage extends GetView<CommentReviewController> {
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
                        ReviewCommentModel item = controller.list[index];
                        return CommentReviewItem(item);
                      }, childCount: controller.list.length),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
