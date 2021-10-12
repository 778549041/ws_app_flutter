import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/mine_answer_controller.dart';
import 'package:ws_app_flutter/widgets/circle/faq_list_item.dart';

class MineAnswerPage extends GetView<MineAnswerController> {
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
                      FAQModel model = controller.list[index];
                      return FAQListItem(
                        model: model,
                      );
                    }, childCount: controller.list.length),
                  ),
          ),
        ],
      ),
    );
  }
}
