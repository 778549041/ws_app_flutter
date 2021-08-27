import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/my_favor_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class MyFavorPage extends GetView<MyFavorController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '兑换订单',
      bgColor: MainAppColor.mainSilverColor,
      child: Obx(
        () {
          if (controller.isEmpty()) {
            return ViewStateEmptyWidget(
              image: 'assets/images/common/empty.png',
              message: '空空如也',
              buttonText: '重新加载',
              onPressed: () => controller.refresh(),
            );
          } else {
            return SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              onRefresh: () => controller.refresh(),
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildFavorRow(index);
                      },
                      childCount: controller.list.length,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFavorRow(int index) {
    NewModel model = controller.list[index];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => controller.pushAction(model),
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Slidable(
            key: Key(model.articleId!),
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: NetImageWidget(
                      imageUrl: model.imageUrl,
                      width: 100,
                      height: 60,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.title!,
                          maxLines: 2,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          DateUtil.formatDateMs(
                              int.parse(model.pubtime!) * 1000,
                              format: DateFormats.y_mo_d),
                          style: TextStyle(
                            color: MainAppColor.secondaryTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: '取消收藏',
                color: Color(0xFF4245E5),
                icon: Icons.delete,
                onTap: () => controller.cancelFavor(model),
                closeOnTap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
