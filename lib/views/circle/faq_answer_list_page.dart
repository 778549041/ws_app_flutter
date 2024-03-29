import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/view_models/circle/faq_answer_list_controller.dart';
import 'package:ws_app_flutter/widgets/circle/faq_answer_list_item.dart';

class FAQAnswerListPage extends StatelessWidget {
  final int type; //0全部回答，1我的回答
  final bool hasAccept; //该提问是否已经采纳了回答
  final bool questionIsSelf; //该提问是否是当前用户

  FAQAnswerListPage({
    required this.type,
    this.hasAccept = false,
    this.questionIsSelf = false,
  });

  @override
  Widget build(BuildContext context) {
    final FAQAnswerListController controller =
        Get.find<FAQAnswerListController>(tag: type.toString());
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: () => controller.loadMore(),
      child: CustomScrollView(
        slivers: <Widget>[
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                AnswerModel item = controller.list[index];
                item.questionIsSelf = questionIsSelf;
                item.questionHasAccept = hasAccept;
                return FAQAnswerListItem(item);
              }, childCount: controller.list.length),
            ),
          ),
        ],
      ),
    );
  }
}
