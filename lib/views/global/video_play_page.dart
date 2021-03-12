import 'package:chewie/chewie.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPalyPage extends StatefulWidget {
  final String videoUrl;
  VideoPalyPage({@required this.videoUrl});

  @override
  VideoPalyPageState createState() => VideoPalyPageState();
}

class VideoPalyPageState extends State<VideoPalyPage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        constraints: BoxConstraints.expand(height: Get.height),
        padding: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
        child: Stack(
          children: <Widget>[
            Chewie(
              controller: _chewieController,
            ),
            Positioned(
              //关闭按钮
              left: 10,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        allowFullScreen: false,
        // aspectRatio: 5 / 3,
        autoPlay: true,
        looping: false);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VideoPalyPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
