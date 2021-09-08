import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/car/battery_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class BatteryCheckPage extends GetView<BatteryController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '电池诊断',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
