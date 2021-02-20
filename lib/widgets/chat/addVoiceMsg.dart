import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/chat_controller.dart';

class VoiceMsg extends StatefulWidget {
  VoiceMsg(this.toUser, this.type);
  final String toUser;
  final int type;
  @override
  State<StatefulWidget> createState() => VoiceMsgState();
}

class VoiceMsgState extends State<VoiceMsg> {
  String toUser;
  int type;
  bool keybordshow = true;
  toggleKeyBord() {
    setState(() {
      keybordshow = !keybordshow;
    });
    Get.find<ChatController>().setStatus(keybordshow);
  }

  void initState() {
    this.toUser = widget.toUser;
    this.type = widget.type;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool show = Get.find<ChatController>().show.value;
    return Container(
      width: 56,
      height: 56,
      child: InkWell(
        child: Icon(
          show ? Icons.keyboard_voice : Icons.keyboard,
          size: 28,
          color: Colors.black,
        ),
        onTap: () {
          toggleKeyBord();
        },
      ),
    );
  }
}
