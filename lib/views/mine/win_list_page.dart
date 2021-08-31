import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/win_list_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/win_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class WinListPage extends GetView<WinListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: '中奖纪录',
        bgColor: MainAppColor.mainSilverColor,
        rightItems: [
          CustomButton(
            backgroundColor: Colors.transparent,
            image: 'assets/images/mine/calendar.png',
            width: 100,
            height: 30,
            imageH: 20,
            imageW: 20,
            onPressed: () => controller.selectDate(),
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
                            color: MainAppColor.secondaryTextColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
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
                          return _buildItem(index);
                        }, childCount: controller.list.length),
                      ),
              ),
            ],
          ),
        ));
  }

  Widget _buildItem(int index) {
    WinModel model = controller.list[index];
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '抽奖日期：${DateUtil.formatDateMs(model.createtime! * 1000, format: DateFormats.y_mo_d)}',
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '奖品详情：${model.prize_detail!.name!}',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/images/mine/win_score.png',
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
