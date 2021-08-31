import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/mine/integral_model.dart';
import 'package:ws_app_flutter/view_models/mine/integral_income_controller.dart';

class IntegralIncomePage extends GetView<IntegralIncomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: Center(
                        child: Text('暂无数据'),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _buildItem(index);
                        },
                        childCount: controller.list.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    Integral model = controller.list[index];
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateUtil.formatDateMs(model.change_time! * 1000,
                format: DateFormats.y_mo_d),
            style: TextStyle(color: Color(0xFF999999), fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Color(0xFFCCCCCC),
            height: 0.5,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.change_reason!,
            style: TextStyle(fontSize: 18),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: DateUtil.formatDateMs(model.change_time! * 1000,
                        format: DateFormats.h_m_s),
                    style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                    children: [
                      TextSpan(
                        text: ' 获取积分',
                        style:
                            TextStyle(color: Color(0xFF7AE168), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                model.change!,
                style: TextStyle(color: Color(0xFF44D729), fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
