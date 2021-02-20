import 'package:badges/badges.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/enum/message_elem_type.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/msg_center_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

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
                              int.parse(controller.msgModel.interactionCount) >
                                  0,
                          elevation: 0,
                          shape: BadgeShape.circle,
                          padding: EdgeInsets.all(7),
                          badgeContent: Text(
                            controller.msgModel.interactionCount,
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
                              int.parse(controller.msgModel.msgCount) > 0,
                          elevation: 0,
                          shape: BadgeShape.circle,
                          padding: EdgeInsets.all(7),
                          badgeContent: Text(
                            controller.msgModel.msgCount,
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
                      V2TimConversation _item =
                          controller.conversionList[index];
                      return _buildConversitionRow(_item);
                    },
                    childCount: controller.conversionList.length,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(int index, Widget content) {
    String _image, _title;
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
                  _image,
                  width: 26,
                  height: 24,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  _title,
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

  Widget _buildConversitionRow(V2TimConversation conversation) {
    return GestureDetector(
      onTap: () => controller.clickConversation(conversation),
      behavior: HitTestBehavior.translucent,
      child: Slidable(
        key: Key(conversation.conversationID),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: RoundAvatar(
                      imageUrl: conversation.faceUrl,
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            conversation.showName,
                            maxLines: 1,
                          ),
                          Text(
                            conversation.lastMessage.elemType == 1
                                ? conversation.lastMessage.textElem == null
                                    ? ''
                                    : conversation.lastMessage.textElem.text
                                : conversation.lastMessage.elemType ==
                                        MessageElemType.V2TIM_ELEM_TYPE_SOUND
                                    ? '【语音消息】'
                                    : conversation.lastMessage.elemType ==
                                            MessageElemType
                                                .V2TIM_ELEM_TYPE_CUSTOM
                                        ? '【自定义消息】'
                                        : conversation.lastMessage.elemType ==
                                                MessageElemType
                                                    .V2TIM_ELEM_TYPE_IMAGE
                                            ? '【图片】'
                                            : conversation
                                                        .lastMessage.elemType ==
                                                    MessageElemType
                                                        .V2TIM_ELEM_TYPE_VIDEO
                                                ? '【视频】'
                                                : conversation.lastMessage
                                                            .elemType ==
                                                        MessageElemType
                                                            .V2TIM_ELEM_TYPE_FILE
                                                    ? '【文件】'
                                                    : conversation.lastMessage
                                                                .elemType ==
                                                            MessageElemType
                                                                .V2TIM_ELEM_TYPE_FACE
                                                        ? '【表情】'
                                                        : '',
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(DateUtil.formatDateMs(
                            conversation.lastMessage.timestamp * 1000,
                            format: DateFormats.h_m)),
                        Badge(
                          toAnimate: false,
                          showBadge: conversation.unreadCount > 0,
                          elevation: 0,
                          shape: BadgeShape.circle,
                          padding: EdgeInsets.all(7),
                          badgeContent: Text(
                            conversation.unreadCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
              color: MainAppColor.seperatorLineColor,
            ),
          ],
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => controller
                .deleteSingleConversition(conversation.conversationID),
            closeOnTap: true,
          ),
        ],
      ),
    );
  }
}
