import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ws_app_flutter/models/mine/emoji.dart';
import 'package:ws_app_flutter/utils/emojiData.dart';

class FaceMsg extends StatelessWidget {
  FaceMsg(this.toUser, this.type);
  final String toUser;
  final int type;

  Future<int?> openPanel(context) {
    close() {
      Navigator.pop(context);
    }

    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 246,
          color: Color(0xffededed),
          padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              childAspectRatio: 1,
              // mainAxisSpacing: 23,
              // crossAxisSpacing: 12,
            ),
            children: emojiData.map(
              (e) {
                var item = Emoji.fromJson(e);
                return new EmojiItem(
                  name: item.name,
                  unicode: item.unicode,
                  toUser: toUser,
                  type: type,
                  close: close,
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      child: IconButton(
          icon: Icon(
            Icons.tag_faces,
            size: 28,
            color: Colors.black,
          ),
          onPressed: () async {
            await openPanel(context);
          }),
    );
  }
}
