import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:ws_app_flutter/view_models/mine/chat_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/chat/msgInput.dart';
import 'package:ws_app_flutter/widgets/chat/sendMsg.dart';

class ChatPage extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: controller.showName,
      child: Column(
        children: [
          Expanded(
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: false,
              onRefresh: () => controller.refresh(),
              enablePullUp: true,
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                reverse: true,
                slivers: [
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        V2TimMessage _item = controller.list[index];
                        return SendMsg(_item, Key(_item.msgID!));
                      }, childCount: controller.list.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MsgInput(controller.userID,1),
        ],
      ),
    );
  }
}
