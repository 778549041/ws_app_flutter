import 'package:flutter/widgets.dart';
import 'package:ws_app_flutter/widgets/chat/addAdvanceMsg.dart';
import 'package:ws_app_flutter/widgets/chat/addFaceMsg.dart';
import 'package:ws_app_flutter/widgets/chat/addTextMsg.dart';
import 'package:ws_app_flutter/widgets/chat/addVoiceMsg.dart';

class MsgInput extends StatelessWidget {
  MsgInput(this.toUser, this.type);
  final String toUser;
  final int type;
  @override
  Widget build(BuildContext context) {
    print("toUser$toUser $type ***** MsgInput");
    return Container(
      height: 55,
      child: Row(
        children: [
          VoiceMsg(toUser, type),
          TextMsg(toUser, type),
          FaceMsg(toUser, type),
          AdvanceMsg(toUser, type),
        ],
      ),
    );
  }
}
