import 'package:expandable_text/expandable_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/draggable_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CircleTopicListPage extends GetView<CircleTopicListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '话题活动',
      bgColor: MainAppColor.mainSilverColor,
      child: Stack(
        children: <Widget>[
          SmartRefresher(
            controller: controller.refreshController,
            onRefresh: () => controller.refresh(),
            enablePullUp: true,
            onLoading: () => controller.loadMore(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Obx(
                    () => controller.topicDetailModel.value.list == null
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: <Widget>[
                                  NetImageWidget(
                                    width: Get.width,
                                    height: Get.width * 204 / 375,
                                    imageUrl: controller
                                        .topicDetailModel.value.list?.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: Get.width * 204 / 375 - 50,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 60),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text('创建者：大橘子',style: TextStyle(color: Color(0xFF1B7DF4),fontSize: 13),),
                                                ),
                                                Text('aaaa'),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            controller.topicDetailModel.value
                                                        .list?.content ==
                                                    null
                                                ? ''
                                                : controller.topicDetailModel
                                                    .value.list!.content!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: Get.width * 204 / 375 - 75,
                                    left: 15,
                                    child: RoundAvatar(
                                      imageUrl: controller.topicDetailModel
                                          .value.list?.adminUrl,
                                      height: 50,
                                      borderWidth: 0,
                                      borderColor: Colors.transparent,
                                    ),
                                  ),
                                  Positioned(
                                    top: Get.width * 204 / 375 - 75,
                                    left: 75,
                                    right: 15,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            controller.topicDetailModel.value
                                                        .list?.title ==
                                                    null
                                                ? ''
                                                : controller.topicDetailModel
                                                    .value.list!.title!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Offstage(
                                          offstage: !(controller
                                                  .topicDetailModel
                                                  .value
                                                  .list!
                                                  .self! ||
                                              controller.topicDetailModel.value
                                                  .list!.hot! ||
                                              controller.topicDetailModel.value
                                                  .list!.isNew!),
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            child: Image.asset(
                                              controller.topicDetailModel.value
                                                  .list!.tagImg!,
                                              width: 28,
                                              height: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(bottom: 15),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: Colors.white,
                          //   ),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(10),
                          //     child: Stack(
                          //       children: <Widget>[
                          //         NetImageWidget(
                          //           width: Get.width,
                          //           height: Get.width * 204 / 375,
                          //           imageUrl: controller
                          //               .topicDetailModel.value.list?.imageUrl,
                          //           fit: BoxFit.cover,
                          //         ),
                          //         Positioned(
                          //           top: Get.width * 204 / 375 - 50,
                          //           left: 0,
                          //           right: 0,
                          //           bottom: 0,
                          //           child: Container(
                          //             height: 100,
                          //             padding: const EdgeInsets.fromLTRB(
                          //                 15, 30, 15, 10),
                          //             color: Colors.white,
                          //             child: Text(
                          //               controller.topicDetailModel.value.list
                          //                           ?.content ==
                          //                       null
                          //                   ? ''
                          //                   : controller.topicDetailModel.value
                          //                       .list!.content!,
                          //             ),
                          //           ),
                          //         ),
                          //         Positioned(
                          //           top: Get.width * 204 / 375 - 75,
                          //           left: 15,
                          //           right: 15,
                          //           child: Row(
                          //             children: <Widget>[
                          //               RoundAvatar(
                          //                 imageUrl: controller.topicDetailModel
                          //                     .value.list?.adminUrl,
                          //                 height: 50,
                          //                 borderWidth: 0,
                          //                 borderColor: Colors.transparent,
                          //               ),
                          //               SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Column(
                          //                 children: <Widget>[
                          //                   Row(
                          //                     children: <Widget>[
                          //                       Text(
                          //                         controller
                          //                                     .topicDetailModel
                          //                                     .value
                          //                                     .list
                          //                                     ?.title ==
                          //                                 null
                          //                             ? ''
                          //                             : controller
                          //                                 .topicDetailModel
                          //                                 .value
                          //                                 .list!
                          //                                 .title!,
                          //                         maxLines: 1,
                          //                         overflow:
                          //                             TextOverflow.ellipsis,
                          //                         style: TextStyle(
                          //                             color: Colors.white,
                          //                             fontSize: 15),
                          //                       ),
                          //                       Offstage(
                          //                         offstage: !(controller
                          //                                 .topicDetailModel
                          //                                 .value
                          //                                 .list!
                          //                                 .self! ||
                          //                             controller
                          //                                 .topicDetailModel
                          //                                 .value
                          //                                 .list!
                          //                                 .hot! ||
                          //                             controller
                          //                                 .topicDetailModel
                          //                                 .value
                          //                                 .list!
                          //                                 .isNew!),
                          //                         child: Container(
                          //                           margin:
                          //                               const EdgeInsets.only(
                          //                                   right: 5),
                          //                           child: Image.asset(
                          //                             controller
                          //                                 .topicDetailModel
                          //                                 .value
                          //                                 .list!
                          //                                 .tagImg!,
                          //                             width: 28,
                          //                             height: 16,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   Row(
                          //                     children: <Widget>[
                          //                       Expanded(
                          //                         child: Text(
                          //                           '创建者：大橘子',
                          //                           style: TextStyle(
                          //                               color:
                          //                                   Color(0xFF1B7DF4),
                          //                               fontSize: 13),
                          //                         ),
                          //                       ),
                          //                       Text('aaaa'),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
                  ),
                ),
                Obx(
                  () => SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CircleListItem(
                          model: controller.list[index],
                          pageName: 'circleTopicList',
                        ),
                      );
                    }, childCount: controller.list.length),
                  ),
                ),
              ],
            ),
          ),
          DraggableButton(
              data: 'dfab_demo',
              offset: Offset(
                  Get.width - 56,
                  Get.height -
                      Get.statusBarHeight -
                      Get.bottomBarHeight -
                      100 -
                      ScreenUtil.getInstance().appBarHeight),
              child: Image.asset('assets/images/circle/circle_publish.png'),
              onPressed: () => controller.pushToPublish(),
              appBarHeight: ScreenUtil.getInstance().appBarHeight,
              appContext: context),
        ],
      ),
    );
  }
}
