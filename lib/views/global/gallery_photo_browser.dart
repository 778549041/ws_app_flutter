import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ws_app_flutter/view_models/gallery_photo_controller.dart';

class GalleryPhotoPage extends GetView<GalleryPhotoController> {
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
                itemCount: 5,
                scrollPhysics: const BouncingScrollPhysics(),
                loadingBuilder: (context, event) {},
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                pageController: PageController(),
                onPageChanged: (index) {
                  
                },
                scrollDirection: Axis.horizontal,
                builder: null),
          ],
        ),
      ),
    );
  }
}
