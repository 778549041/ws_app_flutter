import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/chat/conversation_row.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class MineFriendsPage extends GetView<ConversationController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的好友',
      rightItems: <Widget>[
        CustomButton(
          backgroundColor: Colors.transparent,
          width: 40,
          height: 40,
          image: 'assets/images/mine/mine_friend_list.png',
          imageW: 25.5,
          imageH: 19.5,
          onPressed: () {
            //好友列表
            Get.toNamed(Routes.FRIENDSLIST);
          },
        ),
        CustomButton(
          backgroundColor: Colors.transparent,
          width: 40,
          height: 40,
          image: 'assets/images/mine/mine_add_friend.png',
          imageW: 20,
          imageH: 20,
          onPressed: () {
            //添加好友
            Get.toNamed(Routes.ADDFRIEND);
          },
        )
      ],
      child: CustomScrollView(
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  V2TimConversation? _item = controller.list[index];
                  return ConversationRow(
                    conversation: _item!,
                  );
                },
                childCount: controller.list.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
