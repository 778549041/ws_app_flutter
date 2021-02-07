import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/shop_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ShopAddressListPage extends GetView<ShopListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: '我的收货地址',
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  height: 100,
                  color: Colors.red,
                );
              }, childCount: controller.list.length),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: CustomButton(
                  backgroundColor: Color(0xFF1C7AF4),
                  width: 140,
                  height: 40,
                  title: '下一步',
                  titleColor: Colors.white,
                  radius: 20,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ));
  }
}
