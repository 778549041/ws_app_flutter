import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/view_models/wow/activity_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/wow/activity_list_item.dart';
import 'package:ws_app_flutter/widgets/wow/activity_side.dart';

class ActivityListPage extends GetView<ActivityController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFF3F3F3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: SmartRefresher(
              controller: controller.refreshController,
              header: WaterDropHeader(),
              onRefresh: () => controller.refresh(),
              enablePullUp: true,
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                slivers: [
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ActivityListItem(model: controller.list[index]);
                      }, childCount: controller.list.length),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 30,
          right: 30,
          child: Row(
            children: <Widget>[
              Container(
                width: Get.width - 121,
                height: 35,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/wow/icon_search_grey.png',
                      width: 15,
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('活动搜索');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '大家都在搜“VE-1新车发布”',
                          style:
                              TextStyle(color: Color(0xFF999999), fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CustomButton(
                  backgroundColor: Colors.transparent,
                  width: 51,
                  height: 35,
                  image: 'assets/images/wow/active_menu.png',
                  imageW: 51,
                  imageH: 35,
                  onPressed: () {
                    Get.generalDialog(
                      barrierLabel: '',
                      barrierDismissible: true,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ActivitySideWidget();
                      },
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset.zero,
                                  end: const Offset(-1.0, 0.0),
                                ).animate(secondaryAnimation),
                                child: child),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
