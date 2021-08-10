import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class ImageMessage extends StatelessWidget {
  final V2TimMessage message;
  ImageMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: message.imageElem!.imageList!.map(
        (e) {
          if (e == null) {
            return Container();
          } else {
            if (e.type == 2) {
              if (e.url != null) {
                return Image.network(
                  e.url!,
                  errorBuilder: (context, error, stackTrace) => SpinKitCircle(
                    size: 100.0,
                    color: Color(0xFF006fff),
                  ),
                );
              } else {
                return Image.file(new File(message.imageElem!.path!));
              }
            } else {
              return Container();
            }
          }
        },
      ).toList(),
    );
  }
}
