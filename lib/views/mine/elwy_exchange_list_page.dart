import 'package:auto_size_text/auto_size_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/exchange_package_list_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/elwy_exchange_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class ElwyExchangeListPage extends GetView<ElwyExchangeListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'e路无忧',
      bgColor: MainAppColor.mainSilverColor,
      child: SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        onRefresh: () => controller.refresh(),
        onLoading: () => controller.loadMore(),
        child: CustomScrollView(
          slivers: [
            Obx(
              () => controller.isEmpty()
                  ? SliverToBoxAdapter(
                      child: ViewStateEmptyWidget(
                        image: 'assets/images/common/empty.png',
                        message: '空空如也',
                        buttonText: '重新加载',
                        onPressed: () => controller.refresh(),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _buildItem(index);
                      }, childCount: controller.list.length),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    ExchangePackageModel model = controller.list[index];
    return GestureDetector(
      onTap: () => controller.pushDetail(model),
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    model.name!,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: '消耗积分：',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                      TextSpan(
                        text: TextUtil.formatComma3(model.deduction!) + '积分',
                        style:
                            TextStyle(color: Color(0xFFAB2A52), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: MainAppColor.seperatorLineColor,
              height: 0.5,
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.card_type!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                ),
                itemBuilder: (context, index) {
                  CardType _item = model.card_type![index];
                  return Row(
                    children: <Widget>[
                      NetImageWidget(
                        imageUrl: _item.logo,
                        height: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          _item.titile!,
                          minFontSize: 6,
                          maxLines: 1,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
