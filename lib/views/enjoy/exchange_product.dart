import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/enjoy/exchange_product_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class ExchangeProductPage extends GetView<ExchangeProductController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '确认积分兑换',
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
