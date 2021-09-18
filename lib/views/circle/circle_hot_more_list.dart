import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_hot_model.dart';
import 'package:ws_app_flutter/view_models/circle/circle_hot_more_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class CircleHotMoreList extends GetView<CircleHotMoreListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '热门榜',
      child: CustomScrollView(
        slivers: <Widget>[
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                CircleHotData item = controller.list[index];
                return Container(
                  margin:
                      const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('${index + 1}'),
                          Expanded(
                            child: Text(
                              item.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(
                        color: MainAppColor.seperatorLineColor,
                        height: 0.5,
                      ),
                    ],
                  ),
                );
              }, childCount: controller.list.length),
            ),
          ),
        ],
      ),
    );
  }
}
