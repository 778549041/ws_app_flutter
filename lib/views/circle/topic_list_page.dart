import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/view_models/circle/topic_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/circle/circle_topic_item.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class TopicListPage extends GetView<TopicController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '选择话题',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GetBuilder<TopicController>(
              id: 'tagList',
              builder: (ctl) {
                return Container(
                  width: 65,
                  color: MainAppColor.mainSilverColor,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 0),
                    itemBuilder: (context, index) {
                      CircleTagModel item = ctl.tagList[index];
                      return GestureDetector(
                        onTap: () => ctl.selectTag(item),
                        child: Container(
                          color: item.selected!
                              ? MainAppColor.mainBlueBgColor
                              : Colors.transparent,
                          height: 36,
                          child: Center(
                            child: Text(
                              item.title!,
                              style: TextStyle(
                                  color: item.selected!
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: ctl.tagList.length,
                  ),
                );
              }),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () => controller.refresh(),
                    enablePullUp: true,
                    onLoading: () => controller.loadMore(),
                    child: CustomScrollView(
                      slivers: [
                        Obx(
                          () => SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                TopicModel item = controller.list[index];
                                return CircleTopicItem(item, 4);
                              },
                              childCount: controller.list.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(
                    title: '确定',
                    titleColor: Colors.white,
                    backgroundColor: Color(0xFF1B7DF4),
                    width: 140,
                    height: 40,
                    radius: 20,
                    onPressed: () =>controller.confirmAction(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
