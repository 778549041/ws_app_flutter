import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/circle/circle_search_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';

class CircleSearchPage extends GetView<CircleSearchController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      titleWidget: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        alignment: Alignment.center,
        height: 40,
        child: CustomTextField(
          inputAction: TextInputAction.search,
          leftWidget: Image.asset(
            'assets/images/wow/map_search.png',
            scale: 2.0,
          ),
          hintText: '输入你想看的内容',
          submitCallBack: (value) => controller.inputSearch(value),
        ),
      ),
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
                  return CircleListItem(
                    model: controller.list[index],
                    pageName: 'circleSearchList',
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
