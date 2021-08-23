import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/view_models/mine/msg_center_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/chat/conversation_row.dart';

class MsgCenterPage extends GetView<MsgCenterController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '消息中心',
      child: CustomScrollView(
        slivers: [
          Obx(() => SliverStickyHeader(
                header: Container(
                  color: Colors.white,
                  height: 190.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      _buildHeaderRow(
                        0,
                        Badge(
                          toAnimate: false,
                          showBadge:
                              int.parse(controller.msgModel.value.interactionCount!) >
                                  0,
                          elevation: 0,
                          shape: BadgeShape.circle,
                          padding: EdgeInsets.all(7),
                          badgeContent: Text(
                            controller.msgModel.value.interactionCount!,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        color: MainAppColor.seperatorLineColor,
                      ),
                      _buildHeaderRow(
                        1,
                        Badge(
                          toAnimate: false,
                          showBadge:
                              int.parse(controller.msgModel.value.msgCount!) > 0,
                          elevation: 0,
                          shape: BadgeShape.circle,
                          padding: EdgeInsets.all(7),
                          badgeContent: Text(
                            controller.msgModel.value.msgCount!,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        color: MainAppColor.seperatorLineColor,
                      ),
                      Container(
                        height: 38,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '全部会话',
                          style:
                              TextStyle(color: Color(0xFF1B7DF4), fontSize: 14),
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        color: MainAppColor.seperatorLineColor,
                      ),
                    ],
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      V2TimConversation? _item =
                          Get.find<ConversationController>().list[index];
                      return ConversationRow(conversation: _item!,);
                    },
                    childCount: Get.find<ConversationController>().list.length,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(int index, Widget content) {
    String? _image, _title;
    if (index == 0) {
      _image = 'assets/images/mine/mine_msg_active.png';
      _title = '互动消息';
    } else if (index == 1) {
      _image = 'assets/images/mine/mine_msg_system.png';
      _title = '系统消息';
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => controller.pushAction(index == 0 ? 2 : 1),
      child: Container(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  _image!,
                  width: 26,
                  height: 24,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  _title!,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            content,
          ],
        ),
      ),
    );
  }
}
