import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_list_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
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
      child: ShowCaseWidget(
        builder: Builder(
          builder: (context) => Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      onRefresh: () => controller.refresh(),
                      enablePullUp: true,
                      onLoading: () => controller.loadMore(),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: GetBuilder<CircleTopicListController>(
                              id: 'topicHeader',
                              builder: (ctl) {
                                if (ctl.topicDetailModel == null) {
                                  return Container();
                                } else {
                                  return _buildHeader();
                                }
                              },
                            ),
                          ),
                          Obx(
                            () => SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
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
                  ),
                  GetBuilder<CircleTopicListController>(
                      id: 'topicHeader',
                      builder: (ctl) {
                        if (ctl.topicDetailModel == null) {
                          return Container();
                        } else {
                          return Obx(
                            () => (Get.find<UserController>()
                                        .userInfo
                                        .value
                                        .member!
                                        .memberInfo!
                                        .isLeader! &&
                                    controller
                                        .topicDetailModel!.list!.can_edit!)
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    child: Row(
                                      children: <Widget>[
                                        CustomButton(
                                          title: '成员审核',
                                          titleColor: Colors.white,
                                          backgroundColor: Color(0xFF1B7DF4),
                                          width: (Get.width - 80) / 2,
                                          height: 40,
                                          radius: 20,
                                          onPressed: () =>
                                              controller.pushAction(1),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CustomButton(
                                          title: '内容审核',
                                          titleColor: Colors.white,
                                          backgroundColor: Color(0xFF1B7DF4),
                                          width: (Get.width - 80) / 2,
                                          height: 40,
                                          radius: 20,
                                          onPressed: () =>
                                              controller.pushAction(2),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                          );
                        }
                      }),
                ],
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
                  onPressed: () => controller.pushAction(0),
                  appBarHeight: ScreenUtil.getInstance().appBarHeight,
                  appContext: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
              imageUrl: controller.topicDetailModel!.list?.imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: Get.width * 204 / 375 - 75),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        margin: const EdgeInsets.fromLTRB(75, 0, 15, 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              controller.topicDetailModel!.list?.title == null
                                  ? ''
                                  : controller.topicDetailModel!.list!.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Offstage(
                              offstage: !(controller
                                      .topicDetailModel!.list!.hot! ||
                                  controller.topicDetailModel!.list!.isNew!),
                              child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  controller.topicDetailModel!.list!.tagImg!,
                                  width: 28,
                                  height: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(75, 0, 15, 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      controller.topicDetailModel!.list!
                                                  .member_id ==
                                              '0'
                                          ? '官方话题'
                                          : '创建者：${controller.topicDetailModel!.list?.member_info?.name == null ? '' : controller.topicDetailModel!.list!.member_info!.name!}',
                                      style: TextStyle(
                                          color: Color(0xFF1B7DF4),
                                          fontSize: 13),
                                    ),
                                  ),
                                  _buildBtn(),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              child: ExpandableText(
                                controller.topicDetailModel!.list?.content ==
                                        null
                                    ? ''
                                    : controller
                                        .topicDetailModel!.list!.content!,
                                expandText: '[更多]',
                                collapseText: '[收起]',
                                linkColor: Color(0xFF1B7DF4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: RoundAvatar(
                      imageUrl: controller.topicDetailModel!.list?.adminUrl,
                      height: 50,
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                      placeHolder: 'assets/images/circle/icon_news_offical.png',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn() {
    if (controller.topicDetailModel!.list!.can_edit! &&
        controller.topicDetailModel!.list!.examine != 2) {
      return CustomPopupMenu(
        child: _buildButton(
          null,
          '权限设置',
          Color(0xFF1B7DF4),
        ),
        verticalMargin: 0,
        arrowColor: Color(0xFFECECEC),
        menuBuilder: () => ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Color(0xFFECECEC),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.menuItems
                    .map(
                      (item) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => controller.changePermission(item),
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Center(
                                  child: Text(
                                    item.title,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )),
                            Divider(
                              color: Colors.white,
                              height: 0.5,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        pressType: PressType.singleClick,
        controller: controller.popupMenuController,
      );
    } else {
      return Row(
        children: <Widget>[
          Offstage(
            offstage: controller.topicDetailModel!.list!.isJoin! == 2,
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              child: _buildButton(
                controller.topicDetailModel!.list!.isJoin! == 1
                    ? null
                    : () => controller.applyJoinTopic(),
                controller.topicDetailModel!.list!.isJoin! == 1 ? '审核中' : '加入',
                Colors.cyan,
              ),
            ),
          ),
          _buildButton(
            () => controller.followAction(),
            controller.topicDetailModel!.list!.is_follow! ? '取消关注' : '关注',
            Color(0xFF1B7DF4),
          ),
        ],
      );
    }
  }

  Widget _buildButton(Function()? onpressed, String title, Color color) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
