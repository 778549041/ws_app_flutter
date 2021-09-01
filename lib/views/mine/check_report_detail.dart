import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/check_report_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class CheckReportDetail extends GetView<CheckReportDetailController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'EV车辆健康检查表',
      bgColor: MainAppColor.mainSilverColor,
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: <Widget>[
              _buildEngieBatteryItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEngieBatteryItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 30),
      padding: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '姓名：' + controller.model.value.info!.name!,
                        style: TextStyle(
                            color: MainAppColor.secondaryTextColor,
                            fontSize: 13),
                      ),
                    ),
                    Text(
                      '日期：' + controller.model.value.info!.Date!,
                      style: TextStyle(
                          color: MainAppColor.secondaryTextColor, fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '车架号：' + controller.model.value.info!.VIN!,
                  style: TextStyle(
                      color: MainAppColor.secondaryTextColor, fontSize: 13),
                ),
              ],
            ),
          ),
          Divider(
            color: MainAppColor.seperatorLineColor,
            height: 0.5,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '动力电池检查',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
