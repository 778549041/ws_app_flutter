import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/mine/win_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class WinListPage extends GetView<WinListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: '中奖纪录',
        rightItems: [
          CustomButton(
            backgroundColor: Colors.transparent,
            image: 'assets/images/mine/calendar.png',
            width: 100,
            height: 30,
            imageH: 20,
            imageW: 20,
            onPressed: () {
              LogUtil.d('按月份筛选纪录');
              controller.month.value = '8';
            },
          ),
        ],
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: CustomScrollView(
            slivers: [
              Obx(
                () => SliverToBoxAdapter(
                  child: Offstage(
                    offstage: controller.month.value.length == 0,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 15, right: 15, bottom: 10),
                      width: Get.width,
                      color: Color(0xFFF3F3F3),
                      child: Text(
                        '———我的${controller.month.value}月中奖纪录———',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
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
