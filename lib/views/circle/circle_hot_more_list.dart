import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                TextStyle rankStyle = TextStyle(
                    fontSize: 17,
                    color: Color(0xFFFFA45B),
                    fontStyle: FontStyle.italic);
                if (index == 0 || index == 1 || index == 2) {
                  rankStyle = TextStyle(
                    fontSize: 17,
                    color: Color(0xFFFF2121),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  );
                }
                return GestureDetector(
                  onTap: () => controller.pushAction(item),
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '${index + 1}',
                              style: rankStyle,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              item.typeImgName!,
                              width: 22,
                              height: 12,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                item.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: MainAppColor.seperatorLineColor,
                          height: 0.5,
                        ),
                      ],
                    ),
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
