import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/wow/category_model.dart';
import 'package:ws_app_flutter/view_models/wow/news_controller.dart';
import 'package:ws_app_flutter/widgets/wow/news_list_item.dart';

class NewsListPage extends GetView<NewsController> {
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
              onRefresh: () => controller.refresh(),
              enablePullUp: true,
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                slivers: [
                  Obx(
                    () => SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        CategoryModel _model =
                            controller.categoryListModel.value.list[index];
                        return GestureDetector(
                          onTap: () => controller.clickCategory(_model),
                          child: Container(
                            margin: (index % 2 == 0)
                                ? EdgeInsets.only(left: 15)
                                : EdgeInsets.only(right: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Stack(
                                children: <Widget>[
                                  CachedNetworkImage(
                                    imageUrl: _model.image,
                                    fit: BoxFit.cover,
                                    width: (Get.width - 35) / 2,
                                    height: (Get.width - 35) * 6 / 17,
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          _model.nodeName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                          childCount:
                              controller.categoryListModel.value.list.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 0,
                        childAspectRatio: 17 / 12,
                      ),
                    ),
                  ),
                  Obx(
                    () => SliverToBoxAdapter(
                      child: Offstage(
                        offstage: controller.list.length == 0,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15, bottom: 15),
                          width: Get.width,
                          color: Color(0xFFF3F3F3),
                          child: Text(
                            '热门资讯',
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return NewsListItem(
                          model: controller.list[index],
                        );
                      }, childCount: controller.list.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 30,
          right: 30,
          child: GestureDetector(
            onTap: () => controller.clickSearch(),
            child: Container(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '大家都在搜“VE-1新车发布”',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
