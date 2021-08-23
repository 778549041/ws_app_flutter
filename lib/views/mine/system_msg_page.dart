import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/system_msg_model.dart';
import 'package:ws_app_flutter/view_models/mine/system_msg_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class SystemMsgPage extends GetView<SystemMsgController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '系统消息',
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
                  return _buildMsgRow(index);
                }, childCount: controller.list.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMsgRow(int index) {
    SystemMsg msg = controller.list[index];
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(msg.subject!)),
              Text(DateUtil.formatDateMs(msg.createtime! * 1000,
                  format: DateFormats.full)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(msg.content!),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: MainAppColor.seperatorLineColor,
          ),
        ],
      ),
    );
  }
}
