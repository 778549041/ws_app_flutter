import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/view_models/wow/cate_news_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/wow/news_list_item.dart';

class CateNewsListPage extends GetView<CateNewsController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '品牌资讯',
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
                  NewModel model = controller.list[index];
                  if (index == 0) {
                    model.isBgClear = true;
                  }
                  return NewsListItem(
                    model: model,
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
