import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:ws_app_flutter/widgets/chat/avatar.dart';

class FileMessage extends StatelessWidget {
  final V2TimMessage message;
  FileMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        
      },
      child: Container(
        color: Colors.white,
        child: Row(
          textDirection: message.isSelf ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.fileElem.fileName,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 12,
                        color: Color(0xFF999999)
                      ),
                    ),
                    Text(
                      "${message.fileElem.fileSize} KB",
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 12,
                        color: Color(0xFF999999)
                      ),
                    )
                  ],
                ),
              ),
            ),
            Avatar(
              width: 50,
              height: 50,
              avtarUrl: 'assets/images/common/file.png',
              radius: 0,
            )
          ],
        ),
      ),
    );
  }
}
