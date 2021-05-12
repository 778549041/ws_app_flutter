import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ControlLoadingView extends GetView<EletricController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Offstage(
          offstage: !controller.showLoadingView.value,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.5),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7.5,
                      spreadRadius: 4,
                      color: Color.fromARGB(20, 0, 0, 0))
                ]),
            padding: const EdgeInsets.only(left: 15, right: 0, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Offstage(
                        offstage: controller.currentCmdStatus == 1 ||
                            controller.currentCmdStatus == 3,
                        child: Image.asset(
                          controller.currentCmdStatus == 4
                              ? 'assets/images/chekong/car_loading_success.png'
                              : 'assets/images/chekong/car_loading_failed.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Offstage(
                        offstage: controller.currentCmdStatus != 1 &&
                            controller.currentCmdStatus != 3,
                        child: SpinKitCircle(
                          color: Color(0xFF1B7DF4),
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          controller.currentCmdTitle.value,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        _buildStatusText(),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  width: 30,
                  height: 30,
                  imageH: 15,
                  imageW: 15,
                  radius: 7.5,
                  image: 'assets/images/common/icon_close.png',
                  onPressed: () {
                    controller.showLoadingView.value = false;
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildStatusText() {
    if (controller.currentCmdStatus.value == 5) {
      //指令执行失败
      if (controller.currentCmdType.value == 1 &&
          controller.carStatusModel.value.datas.airOpenStatus == 0) {
        //如果是开空调指令
        return RichText(
          text: TextSpan(
            text: '空调远程控制失败',
            style: TextStyle(color: Color(0xFFFF6F6F)),
            children: [
              TextSpan(
                  text:
                      '\n以下是空调远程控制失败可能的原因：\n①车辆店员未关闭；\n②档位不在P档；\n③车门、发动机盖未关闭；\n④电池SOC过低',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
              TextSpan(
                  text: '\n若以上原因均以排除，仍无法控制空调，请联络特约店。',
                  style: TextStyle(color: Color(0xFFFF6F6F), fontSize: 12)),
            ],
          ),
        );
      } else {
        var status = '';
        if (controller.currentCmdType.value == 1 ||
            controller.currentCmdType.value == 2) {
          status = '请求执行失败，请稍后再试。如有异常请联系特约店';
        } else {
          status = '请求执行失败，请稍后再试。';
        }
        return Text(
          status,
          style: TextStyle(fontSize: 15, color: Color(0xFFFF6F6F)),
        );
      }
    } else {
      var status = '';
      var color = Color(0xFF666666);
      if (controller.currentCmdStatus.value == 1) {
        status = '请求正在发送中';
      } else if (controller.currentCmdStatus.value == 3) {
        status = '请求已发送';
      } else if (controller.currentCmdStatus.value == 2) {
        status = '请求发送失败，请稍后再试';
        color = Color(0xFFFF6F6F);
      } else if (controller.currentCmdStatus.value == 4) {
        status = '请求执行成功';
      }
      return Text(
        status,
        style: TextStyle(fontSize: 15, color: color),
      );
    }
  }
}
