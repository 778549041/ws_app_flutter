import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class SoundMessage extends StatefulWidget {
  SoundMessage(this.message);
  final V2TimMessage message;

  @override
  State<StatefulWidget> createState() => SoundMessageState();
}

class SoundMessageState extends State<SoundMessage> {
  bool isPlay = false;
  //实例化对象
  FlutterPluginRecord recordPlugin = new FlutterPluginRecord();
  void initState() {
    super.initState();
    recordPlugin.responsePlayStateController.listen((data) {
      if (data.playState == 'complete') {
        setState(() {
          isPlay = false;
        });
      }
    });
    //    初始化
    recordPlugin.initRecordMp3();
  }

  play() {
    String? url = widget.message.soundElem?.url;
    if (url != null) {
      setState(() {
        isPlay = !isPlay;
      });
      recordPlugin.playByPath(url, 'url');
    }
  }

  @override
  void deactivate() {
    LogUtil.d("sound message deactivate call ${widget.message.msgID}");
    recordPlugin.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        play();
      },
      child: Container(
        child: Row(
          children: [
            Icon(Icons.volume_up),
            Text(isPlay ? '正在播放...' : '点击播放'),
            Expanded(
              child: Container(),
            ),
            Text(" ${widget.message.soundElem!.duration!} s")
          ],
        ),
      ),
    );
  }
}
