import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/car/mileage_model.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';
import 'package:ws_app_flutter/view_models/car/mileage_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class MileagePage extends GetView<MileageController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '里程信息',
      bgColor: MainAppColor.mainSilverColor,
      rightItems: [
        CustomButton(
          backgroundColor: Colors.transparent,
          image: 'assets/images/car/mileage_tip_icon.png',
          width: 60,
          height: 30,
          imageH: 20,
          imageW: 20,
          onPressed: () => controller.buttonAction(0),
        ),
      ],
      child: Obx(
        () => controller.model.value.totalMileage == null
            ? Container()
            : Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '我的总里程',
                          style:
                              TextStyle(color: Color(0xFF999999), fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: controller.totalMileage.value,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 45),
                                  children: [
                                    TextSpan(
                                      text: 'km',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomButton(
                              width: 90,
                              height: 30,
                              radius: 15,
                              borderColor: controller.hasAccept.value
                                  ? Colors.black
                                  : Colors.transparent,
                              backgroundColor: controller.hasAccept.value
                                  ? Colors.transparent
                                  : Color(0xFF4245E5),
                              title:
                                  controller.hasAccept.value ? '已领取' : '领取积分>>',
                              titleColor: controller.hasAccept.value
                                  ? Colors.black
                                  : Colors.white,
                              onPressed: () => controller.hasAccept.value
                                  ? null
                                  : controller.buttonAction(1),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: SmartRefresher(
                    controller: controller.refreshController,
                    enablePullUp: true,
                    onRefresh: () => controller.refresh(),
                    onLoading: () => controller.loadMore(),
                    child: CustomScrollView(
                      slivers: [
                        controller.isEmpty()
                            ? SliverToBoxAdapter(
                                child: ViewStateEmptyWidget(
                                  image: 'assets/images/common/empty.png',
                                  message: '空空如也',
                                  buttonText: '重新加载',
                                  onPressed: () => controller.refresh(),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return _buildItem(index);
                                }, childCount: controller.list.length),
                              ),
                      ],
                    ),
                  ))
                ],
              ),
      ),
    );
  }

  Widget _buildItem(int index) {
    MileageModel model = controller.list[index];
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            model.mileageDate!,
            style: TextStyle(color: Color(0xFF999999), fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Color(0xFFCCCCCC),
            height: 0.5,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${model.addMileage!}km',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '获得',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                        children: [
                          TextSpan(
                            text: model.rewardPoints,
                            style: TextStyle(
                                color: Color(0xFF59DB42), fontSize: 15),
                          ),
                          TextSpan(
                            text: '积分',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                model.status!,
                style: TextStyle(fontSize: 13, color: model.statusColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
