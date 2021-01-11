import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
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
        child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: RecommendBanner(),
                ),
                SliverToBoxAdapter(
                  child: RecommendEle(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('$index');
                  }, childCount: 5),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ListTile(
                      title: Text('$index'),
                      onTap: () {
                        Get.find<UserController>().logout();
                      },
                    );
                  }, childCount: 5),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('$index');
                  }, childCount: 5),
                )
              ],
            ),
      ),
    );
  }
}
