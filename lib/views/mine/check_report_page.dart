import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/mine/check_report_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class CheckReportPage extends GetView<CheckReportController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '检查报告',
        child: SmartRefresher(
      controller: controller.refreshController,
      enablePullUp: true,
      onRefresh: () => controller.refresh(),
      onLoading: () => controller.loadMore(),
      child: CustomScrollView(
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container();
              }, childCount: controller.list.length),
            ),
          ),
        ],
      ),
    ));
  }
}
