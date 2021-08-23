import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:video_player/video_player.dart';

class VideoMessage extends StatefulWidget {
  VideoMessage(this.message);
  final V2TimMessage message;

  @override
  State<StatefulWidget> createState() => VideoMessageState();
}

class VideoMessageState extends State<VideoMessage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    try {
      if (widget.message.videoElem?.videoUrl == null) {
        _controller = VideoPlayerController.file(
          File(widget.message.videoElem!.videoPath!),
        )..initialize().then((_) {
            setState(() {});
          }).catchError((err) {
            LogUtil.d("初始化视频发生错误$err");
          });
      } else {
        _controller = VideoPlayerController.network(
          widget.message.videoElem!.videoUrl!,
        )..initialize().then((_) {
            setState(() {});
          }).catchError((err) {
            LogUtil.d("初始化视频发生错误$err");
          });
      }
    } catch (err) {
      LogUtil.d("视频初始化发生异常");
    }

    if (!_controller!.hasListeners) {
      _controller!.addListener(() {
        LogUtil.d(
            "播放着 ${_controller!.value.isPlaying} ${_controller!.value.position} ${_controller!.value.duration} ${_controller!.value.duration == _controller!.value.position}");
        if (_controller!.value.position == _controller!.value.duration) {
          LogUtil.d("到头了 ${_controller!.value.isPlaying}");
          if (!_controller!.value.isPlaying) {
            setState(() {});
          }
        }
      });
    }
  }

  getUlr() {
    if (widget.message.videoElem?.videoUrl == null) {
      return widget.message.videoElem!.videoPath;
    } else {
      return widget.message.videoElem!.videoUrl;
    }
  }

  void deactivate() {
    LogUtil.d("video message deactivate call ${widget.message.msgID}");
    _controller!.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return _controller!.value.isInitialized
        ? Container(
            child: Stack(
              children: [
                Positioned(
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          setState(() {});
                          if (_controller!.value.isPlaying) {
                            _controller!.pause();
                          } else {
                            if (_controller!.value.position ==
                                _controller!.value.duration) {
                              _controller!.seekTo(Duration(
                                  seconds: 0,
                                  microseconds: 0,
                                  milliseconds: 0));
                            }
                            _controller!.play();
                            setState(() {});
                          }
                        } catch (err) {
                          EasyLoading.showToast(err.toString(),
                              toastPosition: EasyLoadingToastPosition.bottom);
                        }
                      },
                      child: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0,
                ),
              ],
            ),
          )
        : Container(
            child: SpinKitCircle(
              size: 100.0,
              color: Color(0xFF006fff),
            ),
          );
  }
}
