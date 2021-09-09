import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/pac_list_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/mine/elwy_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class ELWYPage extends GetView<ELWYController> {
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
                        buttonText: '去兑换',
                        onPressed: () => controller.pushExchangeList(),
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
    PackageModel model = controller.list[index];
    return GestureDetector(
      onTap: () => controller.pushDetail(model),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: model.status! == 0 ? Color(0xFFECECEC) : Colors.white,
              border: model.status! == 0
                  ? Border.all(color: Color(0xFFC9C9C9), width: 0.5)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        model.FCardBagName!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      model.createtime!,
                      style: TextStyle(fontSize: 12),
                    )
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
                    itemCount: model.cardname!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                    ),
                    itemBuilder: (context, index) {
                      CardName _item = model.cardname![index];
                      late String imagePath;
                      if (model.status! == 0) {
                        //失效
                        if (_item.FTitle! == '充电服务') {
                          imagePath =
                              'assets/images/mine/elwy_expired_charge.png';
                        } else if (_item.FTitle! == '全车检查') {
                          imagePath =
                              'assets/images/mine/elwy_expired_allcheck.png';
                        } else if (_item.FTitle! == '电池诊断') {
                          imagePath =
                              'assets/images/mine/elwy_expired_battery.png';
                        } else if (_item.FTitle! == '基础保养') {
                          imagePath =
                              'assets/images/mine/elwy_expired_jichu.png';
                        }
                      } else {
                        if (_item.FTitle! == '充电服务') {
                          imagePath = 'assets/images/mine/elwy_charge.png';
                        } else if (_item.FTitle! == '全车检查') {
                          imagePath = 'assets/images/mine/elwy_allcheck.png';
                        } else if (_item.FTitle! == '电池诊断') {
                          imagePath = 'assets/images/mine/elwy_battery.png';
                        } else if (_item.FTitle! == '基础保养') {
                          imagePath = 'assets/images/mine/elwy_jichu.png';
                        }
                      }

                      return Row(
                        children: <Widget>[
                          Image.asset(
                            imagePath,
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _item.FTitle!,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: MainAppColor.seperatorLineColor,
                  height: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '特约店：${model.store!}',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Positioned(
            left: (Get.width - 53) / 2,
            bottom: 20,
            child: Offstage(
              offstage: model.status != 0,
              child: Image.asset(
                'assets/images/mine/elwy_expired.png',
                width: 53,
                height: 48.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
