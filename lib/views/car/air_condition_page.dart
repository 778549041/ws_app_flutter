import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/control_loading_view.dart';

class AirConditionPage extends GetView<EletricController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BasePage(
          title: '远程空调',
          bgColor: MainAppColor.mainSilverColor,
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/chekong/air_cond_car.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                children: <Widget>[
                  _buildTime(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 60,
          right: 20,
          child: ControlLoadingView(),
        ),
      ],
    );
  }

  Widget _buildTime() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Obx(
        () => Offstage(
          offstage:
              controller.carStatusModel.value.datas.sendingTime.length == '0',
          child: Text(
            '车辆数据上传于：${DateUtil.formatDateMs(int.parse(controller.carStatusModel.value.datas.sendingTime))}',
            style: TextStyle(color: Color(0xFF999999), fontSize: 12),
          ),
        ),
      ),
    );
  }
}
