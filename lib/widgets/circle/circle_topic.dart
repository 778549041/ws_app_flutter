import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_controller.dart';

class CircleTopicItem extends GetView<CircleTopicController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      margin: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 140,
        margin: const EdgeInsets.only(left: 15, bottom: 15),
        child: Obx(() => RefreshConfiguration.copyAncestor(
            context: context,
            hideFooterWhenNotFull: false,
            child: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () => controller.refresh(),
              enablePullUp: true,
              onLoading: () => controller.loadMore(),
              footer: ClassicFooter(
                iconPos: IconPosition.top,
                idleText: '',
                loadingText: '',
                noDataText: '',
                failedText: '',
                canLoadingText: '',
                spacing: 0,
                outerBuilder: (child) {
                  return Container(
                    width: 80.0,
                    child: Center(
                      child: child,
                    ),
                  );
                },
              ),
              header: ClassicHeader(
                releaseText: '',
                idleText: '',
                refreshingText: '',
                completeText: '',
                failedText: '',
                canTwoLevelText: '',
                spacing: 0,
                iconPos: IconPosition.top,
                outerBuilder: (child) {
                  return Container(
                    width: 80.0,
                    child: Center(
                      child: child,
                    ),
                  );
                },
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    return _buildTopicItem(controller.list[index]);
                  }),
            ))),
      ),
    );
  }

  Widget _buildTopicItem(TopicModel model) {
    return GestureDetector(
      onTap: () => controller.pushToTopicLst(model.topicId!),
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(imageUrl: model.imageUrl!),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Column(
                    children: <Widget>[
                      Text(
                        model.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        '${model.totalNum.toString()}人参与',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
