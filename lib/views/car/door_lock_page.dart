import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class DoorLockPage extends GetView<EletricController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '门锁状态',
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Obx(() => Offstage(
                  offstage: controller
                          .carStatusModel.value.datas.sendingTime.length ==
                      '0',
                  child: Text(
                    '车辆数据上传于：${DateUtil.formatDateMs(int.parse(controller.carStatusModel.value.datas.sendingTime))}',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
