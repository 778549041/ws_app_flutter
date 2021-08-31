import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/report_list_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/check_report_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class CheckReportPage extends GetView<CheckReportController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '检查报告',
      bgColor: MainAppColor.mainSilverColor,
      child: SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        onRefresh: () => controller.refresh(),
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
                        return _buildItem(index);
                      }, childCount: controller.list.length),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    ReportModel model = controller.list[index];
    return GestureDetector(
      onTap: () {
        print('点击了第$index个检查表');
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/mine/ev_car_check_report.png',
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'EV车辆健康检查表',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.date!,
                    style: TextStyle(
                        fontSize: 12, color: MainAppColor.secondaryTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
