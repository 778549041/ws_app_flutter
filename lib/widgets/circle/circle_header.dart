import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/widgets/circle/circle_header_hot.dart';
import 'package:ws_app_flutter/widgets/circle/circle_header_offical.dart';
import 'package:ws_app_flutter/widgets/circle/circle_header_topic.dart';
import 'package:ws_app_flutter/view_models/circle/circle_tab_controller.dart';

class CircleHeader extends GetView<CircleTabController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Obx(
          () => controller.hotData.value.data == null
              ? Container()
              : CircleHeaderHot(
                  list: controller.hotData.value.data!,
                ),
        ),
        Obx(
          () => controller.topicData.value.list == null
              ? Container()
              : CircleHeaderTopic(
                  list: controller.topicData.value.list!,
                ),
        ),
        Obx(
          () => controller.officialData.value.list == null
              ? Container()
              : CircleHeaderOfficial(
                  list: controller.officialData.value.list!,
                ),
        ),
      ],
    );
  }
}
