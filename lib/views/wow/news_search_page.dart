import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/view_models/wow/news_search_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';
import 'package:ws_app_flutter/widgets/wow/news_list_item.dart';

class NewsSearchPage extends GetView<NewsSearchController> {
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
          leftWidget: Image.asset(
            'assets/images/wow/map_search.png',
            scale: 2.0,
          ),
          hintText: '',
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
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Obx(() => Text(
                          controller.list.length > 0 ? '搜索出以下资讯' : '猜你想看的是',
                          style: TextStyle(
                              color: MainAppColor.mainBlueBgColor,
                              fontSize: 15),
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Obx(() => Offstage(
                  //       offstage: controller.list.length > 0,
                  //       child:
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, bottom: 5, right: 15),
                    child: Obx(() => Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 5,
                          runSpacing: 5,
                          children: List.generate(
                              controller.searchTagList.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectItem(index);
                              },
                              child: Container(
                                width: 60,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      controller.searchTagList[index].selected
                                          ? MainAppColor.mainBlueBgColor
                                          : Colors.transparent,
                                  border: Border.all(
                                      width: 0.5, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  controller.searchTagList[index].tagName,
                                  style: TextStyle(
                                    color:
                                        controller.searchTagList[index].selected
                                            ? Colors.white
                                            : MainAppColor.mainBlueBgColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          }),
                        )),
                  ),
                  // )),
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
                  NewModel model = controller.list[index];
                  if (index == 0) {
                    model.isBgClear = true;
                  }
                  return NewsListItem(
                    model: model,
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
