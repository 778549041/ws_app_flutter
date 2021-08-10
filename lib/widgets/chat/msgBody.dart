import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_im_sdk_plugin/enum/message_elem_type.dart';
import 'package:tencent_im_sdk_plugin/enum/message_status.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:ws_app_flutter/widgets/chat/SystemMessage.dart';
import 'package:ws_app_flutter/widgets/chat/customMessage.dart';
import 'package:ws_app_flutter/widgets/chat/fileMessage.dart';
import 'package:ws_app_flutter/widgets/chat/imageMessage.dart';
import 'package:ws_app_flutter/widgets/chat/soundMessage.dart';
import 'package:ws_app_flutter/widgets/chat/videoMessage.dart';

class MsgBody extends StatelessWidget {
  TextDirection textDirection = TextDirection.rtl;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.end;
  TextAlign textAlign = TextAlign.left;
  EdgeInsetsGeometry padding = EdgeInsets.only(
    right: 12,
  );
  final int type;
  final String name;
  final String message;
  final V2TimMessage? msgobj;

  MsgBody({
    this.type = 1,
    this.name = '',
    this.message = '',
    this.msgobj,
  }) {
    if (type != 1) {
      this.textDirection = TextDirection.ltr;
      this.crossAxisAlignment = CrossAxisAlignment.start;
      this.padding = EdgeInsets.only(
        left: 12,
      );
    }
  }
  String getMessageTime() {
    String time = '';
    int timestamp = msgobj!.timestamp! * 1000;
    DateTime timeDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();

    if (now.day == timeDate.day) {
      time =
          "${timeDate.hour.toString().padLeft(2, '0')}:${timeDate.minute.toString().padLeft(2, '0')}:${timeDate.second.toString().padLeft(2, '0')}";
    } else {
      time =
          "${timeDate.month.toString().padLeft(2, '0')}-${timeDate.day.toString().padLeft(2, '0')} ${timeDate.hour.toString().padLeft(2, '0')}:${timeDate.minute.toString().padLeft(2, '0')}:${timeDate.second.toString().padLeft(2, '0')}";
    }
    return time;
  }

  Widget getHandleBar() {
    Widget wid = new Container();

    if (msgobj!.isSelf!) {
      if (msgobj!.status! == MessageStatus.V2TIM_MSG_STATUS_SEND_SUCC) {
        if (msgobj!.isPeerRead! &&
            (msgobj!.groupID == null || msgobj!.groupID == '')) {
          //c2c消息已读
          wid = Text(
            "已读",
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF999999),
            ),
          );
        }
        if (msgobj!.isPeerRead == false &&
            (msgobj!.groupID == null || msgobj!.groupID == '')) {
          //c2c未读
          wid = Text(
            "未读",
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF006fff),
            ),
          );
        }
      }
      if (msgobj!.status! == MessageStatus.V2TIM_MSG_STATUS_SEND_FAIL) {
        wid = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              size: 14,
              color: Color(0xFFFA5151),
            ),
            Text(
              "发送失败",
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFFFA5151),
                height: 1.4,
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: InkWell(
            //     onTap: () {

            //     },
            //     child: Text(
            //       "重新发送",
            //       style: TextStyle(
            //         fontSize: 10,
            //         color: Color(0xFF006fff),
            //         height: 1.4,
            //       ),
            //     ),
            //   ),
            // )
          ],
        );
      }
      if (msgobj!.status! == MessageStatus.V2TIM_MSG_STATUS_SENDING) {
        wid = Text(
          "发送中...",
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF006fff),
          ),
        );
      }
    }
    // 非自己消息不作处理
    return wid;
  }

  @override
  Widget build(BuildContext context) {
    // print("当前消息类型 ${msgobj.elemType} ${message}");

    return Expanded(
      child: Container(
        padding: padding,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Row(
              textDirection: textDirection,
              children: [
                Text(
                  name,
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: PhysicalModel(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: type == 1
                        ? Color(0xff006eff).withOpacity(0.1)
                        : Color(0xfff8f8f8).withOpacity(1),
                    border: Border.all(
                      width: 0.5,
                      style: BorderStyle.solid,
                      color: type == 1
                          ? Color(0xff006eff).withOpacity(0.3)
                          : Color(0xffe8e8e8).withOpacity(1),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: msgobj!.elemType ==
                          MessageElemType.V2TIM_ELEM_TYPE_IMAGE //图片
                      ? ImageMessage(msgobj!)
                      : msgobj!.elemType ==
                              MessageElemType.V2TIM_ELEM_TYPE_FACE //表情
                          ? Container(
                              child: Text("表情 ${msgobj!.faceElem!.data!}"),
                            )
                          : msgobj!.elemType ==
                                  MessageElemType.V2TIM_ELEM_TYPE_SOUND //语音
                              ? SoundMessage(msgobj!)
                              : msgobj!.elemType ==
                                      MessageElemType.V2TIM_ELEM_TYPE_VIDEO //视频
                                  ? VideoMessage(msgobj!)
                                  : msgobj!.elemType ==
                                          MessageElemType
                                              .V2TIM_ELEM_TYPE_CUSTOM //自定义消息
                                      ? CustomMessage(msgobj!)
                                      : msgobj!.elemType == 1 //文字
                                          ? Text(
                                              message,
                                              textAlign: textAlign,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: type == 1
                                                    ? Color(0xff171538)
                                                    : Color(0xff000000),
                                              ),
                                            )
                                          : msgobj!.elemType ==
                                                  MessageElemType
                                                      .V2TIM_ELEM_TYPE_GROUP_TIPS //系统消息
                                              ? SystemMessage(msgobj!)
                                              : msgobj!.elemType ==
                                                      MessageElemType
                                                          .V2TIM_ELEM_TYPE_FILE //文件消息
                                                  ? FileMessage(msgobj!)
                                                  : Text(
                                                      "未解析消息${msgobj!.elemType}",
                                                      textAlign: textAlign,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: type == 1
                                                            ? Color(0xff171538)
                                                            : Color(0xff000000),
                                                      ),
                                                    ),
                ),
              ),
            ),
            getHandleBar(),
            Row(
              children: [
                Expanded(
                    child: Text(
                  getMessageTime(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF999999),
                    height: 1.6,
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
