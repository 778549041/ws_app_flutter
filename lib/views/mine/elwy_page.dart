import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/elwy_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class ELWYPage extends GetView<ELWYController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'e路无忧',
      child: Obx(() {
        if (controller.isEmpty()) {
          return ViewStateEmptyWidget(onPressed: () => {});
        }
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container();
              }, childCount: controller.list.length),
            ),
          ],
        );
      }),
    );
  }
}
