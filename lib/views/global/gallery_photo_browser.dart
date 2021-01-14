import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ws_app_flutter/models/wow/moment_model.dart';

class GalleryPhotoPage extends StatefulWidget {
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List galleryItems;
  final Axis scrollDirection;

  GalleryPhotoPage(
      {this.loadingBuilder,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialIndex,
      @required this.galleryItems,
      this.scrollDirection = Axis.horizontal})
      : pageController = PageController(initialPage: initialIndex);

  @override
  GalleryPhotoPageState createState() => GalleryPhotoPageState();
}

class GalleryPhotoPageState extends State<GalleryPhotoPage> {
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        constraints: BoxConstraints.expand(height: Get.height),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
                itemCount: widget.galleryItems.length,
                scrollPhysics: const BouncingScrollPhysics(),
                loadingBuilder: widget.loadingBuilder,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                scrollDirection: widget.scrollDirection,
                builder: _buildItem),
            Positioned(
              //图片index显示
              top: ScreenUtil.getInstance().statusBarHeight + 15,
              width: ScreenUtil.getInstance().screenWidth,
              child: Center(
                child: Text(
                  '${currentIndex + 1}/${widget.galleryItems.length}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Positioned(
              //右上角关闭按钮
              right: 10,
              top: ScreenUtil.getInstance().statusBarHeight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () => Get.back(),
              ),
            ),
            Positioned(
              bottom: ScreenUtil.getInstance().bottomBarHeight + 16,
              child: FlatButton(
                child: Text(
                  '保存图片',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  if (GetPlatform.isIOS) {
                    return _saveNetworkImage();
                  }
                  requestPermission().then((value) {
                    if (value) {
                      _saveNetworkImage();
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final FileModel item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      onTapUp: (BuildContext context, TapUpDetails details,
          PhotoViewControllerValue controllerValue) {
        Get.back();
      },
      imageProvider: CachedNetworkImageProvider(item.savepath),
//      initialScale: PhotoViewComputedScale.contained,
//      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
//      maxScale: PhotoViewComputedScale.covered * 1.1,

      heroAttributes: PhotoViewHeroAttributes(tag: item.savepath),
    );
  }

  //动态申请权限，ios 要在info.plist 上面添加
  Future<bool> requestPermission() async {
    var status = await Permission.photos.status;
    if (status.isUndetermined) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.photos].request();
    }
    return status.isGranted;
  }

  //保存网络图片到本地
  _saveNetworkImage() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      LogUtil.v('暂无相册权限');
      Get.dialog(CupertinoAlertDialog(
        title: Text('提示'),
        content: Text('您当前没有开启相册权限'),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () => Get.back(),
          ),
          FlatButton(
            child: Text('去开启'),
            onPressed: () {
              openAppSettings();
            },
          )
        ],
      ));
      return;
    }
    var response = await Dio().get(widget.galleryItems[currentIndex].savepath,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    LogUtil.v(result);
    if (GetPlatform.isIOS) {
      if (result['isSuccess']) {
        Fluttertoast.showToast(msg: '保存成功');
      } else {
        Fluttertoast.showToast(msg: '保存失败');
      }
    } else {
      if (result != null) {
        Fluttertoast.showToast(msg: '保存成功');
      } else {
        Fluttertoast.showToast(msg: '保存失败');
      }
    }
  }

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(GalleryPhotoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
