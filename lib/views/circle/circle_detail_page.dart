import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/circle_detail_controller.dart';

class CircleDetailPage extends GetView<CircleDetailController> {
  final String circleId =
      Get.arguments == null ? null : Get.arguments['circle_id'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}