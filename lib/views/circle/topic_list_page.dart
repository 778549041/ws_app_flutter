import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/view_models/circle/topic_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class TopicListPage extends GetView<TopicController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '选择话题',
      leftItem: CustomButton(
        backgroundColor: Colors.transparent,
        width: 30,
        height: 30,
        title: '取消',
        titleColor: Colors.white,
        onPressed: () => Get.back(),
      ),
      child: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.refresh(),
        enablePullUp: true,
        onLoading: () => controller.loadMore(),
        child: CustomScrollView(
          slivers: [
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  TopicModel item = controller.list[index];
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => controller.selectTopic(index),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, right: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              NetImageWidget(
                                imageUrl: item.imageUrl!,
                                width: 148,
                                height: 104,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.title!,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      '${item.totalNum}人参与',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              MainAppColor.secondaryTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Color(0xFFD6D6D6),
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
      ),
    );
  }
}
