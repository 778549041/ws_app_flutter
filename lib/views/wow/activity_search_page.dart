import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/wow/activity_search_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';
import 'package:ws_app_flutter/widgets/wow/activity_list_item.dart';

class ActivitySearchPage extends GetView<ActivitySearchController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      titleWidget: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        alignment: Alignment.center,
        height: 40,
        child: CustomTextField(
          inputAction: TextInputAction.search,
          leftWidget: Image.asset(
            'assets/images/wow/map_search.png',
            scale: 2.0,
          ),
          hintText: '输入你想看的内容',
          submitCallBack: (value) => controller.inputSearch(value),
        ),
      ),
      child: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.refresh(),
        enablePullUp: true,
        onLoading: () => controller.loadMore(),
        child: CustomScrollView(
          slivers: [
            if (controller.list.length > 0)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Obx(() => Text(
                            '搜索出以下活动',
                            style: TextStyle(
                                color: MainAppColor.mainBlueBgColor,
                                fontSize: 15),
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black,
                      height: 0.5,
                      indent: 15,
                      endIndent: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ActivityListItem(model: controller.list[index]);
                }, childCount: controller.list.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
