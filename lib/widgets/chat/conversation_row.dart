import 'package:badges/badges.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/enum/message_elem_type.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class ConversationRow extends StatelessWidget {
  final V2TimConversation? conversation;
  ConversationRow({this.conversation});

  @override
  Widget build(BuildContext context) {
    if (conversation == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () =>
          Get.find<ConversationController>().clickConversation(conversation!),
      behavior: HitTestBehavior.translucent,
      child: Slidable(
        key: Key(conversation!.conversationID),
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
                      imageUrl: conversation!.faceUrl!,
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
                            conversation!.showName!,
                            maxLines: 1,
                          ),
                          Text(
                            conversation!.lastMessage == null
                                ? ''
                                : conversation!.lastMessage!.elemType ==
                                        MessageElemType.V2TIM_ELEM_TYPE_TEXT
                                    ? conversation!.lastMessage!.textElem ==
                                            null
                                        ? ''
                                        : conversation!
                                            .lastMessage!.textElem!.text!
                                    : conversation!.lastMessage!.elemType ==
                                            MessageElemType
                                                .V2TIM_ELEM_TYPE_SOUND
                                        ? '【语音消息】'
                                        : conversation!.lastMessage!.elemType ==
                                                MessageElemType
                                                    .V2TIM_ELEM_TYPE_CUSTOM
                                            ? '【自定义消息】'
                                            : conversation!.lastMessage!
                                                        .elemType ==
                                                    MessageElemType
                                                        .V2TIM_ELEM_TYPE_IMAGE
                                                ? '【图片】'
                                                : conversation!.lastMessage!
                                                            .elemType ==
                                                        MessageElemType
                                                            .V2TIM_ELEM_TYPE_VIDEO
                                                    ? '【视频】'
                                                    : conversation!.lastMessage!
                                                                .elemType ==
                                                            MessageElemType
                                                                .V2TIM_ELEM_TYPE_FILE
                                                        ? '【文件】'
                                                        : conversation!
                                                                    .lastMessage!
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
                            conversation!.lastMessage!.timestamp! * 1000,
                            format: DateFormats.h_m)),
                        if (conversation!.unreadCount != null)
                          Badge(
                            toAnimate: false,
                            showBadge: conversation!.unreadCount! > 0,
                            elevation: 0,
                            shape: BadgeShape.circle,
                            padding: EdgeInsets.all(7),
                            badgeContent: Text(
                              conversation!.unreadCount!.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
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
            onTap: () => Get.find<ConversationController>()
                .deleteSingleConversition(conversation!.conversationID),
            closeOnTap: true,
          ),
        ],
      ),
    );
  }
}
