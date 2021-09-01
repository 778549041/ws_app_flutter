import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/exchange_package_detail_model.dart';
import 'package:ws_app_flutter/view_models/mine/elwy_exchange_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class ElwyExchangeDetailPage extends GetView<ElwyExchangeDetailController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '服务套餐大礼包',
      bgColor: MainAppColor.mainSilverColor,
      child: Obx(() => Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildHeader(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _buildItem(index);
                        },
                        childCount: controller.model.value.list?.card_list ==
                                null
                            ? 0
                            : controller.model.value.list!.card_list!.length,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 0),
                height: 40,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: '消耗积分：',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: [
                          TextSpan(
                            text: controller.model.value.list?.score == null
                                ? ''
                                : TextUtil.formatComma3(
                                        controller.model.value.list!.score!) +
                                    '积分',
                            style: TextStyle(
                                color: Color(0xFFAB2A52), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      title: '立即兑换',
                      titleColor: Colors.white,
                      backgroundColor: Color(0xFF4245E5),
                      width: 150,
                      height: 40,
                      onPressed: () => controller.exchangePackage(),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        controller.model.value.list?.FCardBagName == null
            ? ''
            : controller.model.value.list!.FCardBagName!,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildItem(int index) {
    ExchangePackageCard bag = controller.model.value.list!.card_list![index];
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NetImageWidget(
            imageUrl: bag.FLocalLogoPath,
            width: 85,
            height: 85,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bag.FTitle! + '*' + bag.FCardCount! + '次',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  bag.FNotice!,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
