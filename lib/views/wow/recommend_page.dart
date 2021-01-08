import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
import 'package:ws_app_flutter/widgets/wow/recommend_banner.dart';
import 'package:ws_app_flutter/widgets/wow/recommend_ele.dart';

class RecommendPage extends GetView<RecommendController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () {},
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top:112),
              decoration: BoxDecoration(
                color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: RecommendBanner(),
                ),
                SliverToBoxAdapter(child: RecommendEle(),),
                // SliverList(delegate: SliverChildBuilderDelegate((){}),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
