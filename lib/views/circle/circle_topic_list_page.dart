import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_controller.dart';

class CircleTopicListPage extends GetView<CircleTopicController>{
  final String topcId =
      Get.arguments == null ? null : Get.arguments['topcid'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}