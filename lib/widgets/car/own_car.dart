import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
import 'package:ws_app_flutter/widgets/car/battery_view.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/switch_loading.dart';

class OwnCarWidget extends GetView<EletricController> {
  final List<Map<String, dynamic>> _gridData = [
    {'image': 'assets/images/chekong/car_peijian.png', 'title': '爱车配件'},
    {'image': 'assets/images/chekong/car_weizhang.png', 'title': '违章查询'},
    {'image': 'assets/images/chekong/car_by.png', 'title': '预约保养'},
    {'image': 'assets/images/chekong/car_map_nav.png', 'title': '实时导航'},
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildEletricView(),
            Obx(() => Offstage(
                  offstage: controller
                          .carStatusModel.value.datas?.sendingTime?.length ==
                      '0',
                  child: Text(
                    '车辆数据上传于：${DateUtil.formatDateMs(int.parse(controller.carStatusModel.value.datas!.sendingTime!))}',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                controller.carDataModel.value.datas!.fcarColor!,
                style: TextStyle(fontSize: 22),
              ),
            ),
            if (controller.carDataModel.value.datas!.fcarColorURL!.length > 0)
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: CachedNetworkImage(
                    imageUrl:
                        controller.carDataModel.value.datas!.fcarColorURL!),
              ),
            _buildCarControlView(),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              height: (Get.width - 20) / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: GridView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _gridData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> _item = _gridData[index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFF3F3F3), width: 0.5)),
                        child: CustomButton(
                          image: _item['image'],
                          imageH: 28,
                          imageW: 28,
                          title: _item['title'],
                          fontSize: 12,
                          imagePosition: XJImagePosition.XJImagePositionTop,
                          onPressed: () => buttonAction(index),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  //电量信息
  Widget _buildEletricView() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BatteryView(
              percent: controller.progressValue.value,
              isCharging: controller.charging.value,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    controller.carDataModel.value.datas?.rspBody?.soc == null
                        ? '100'
                        : controller.carDataModel.value.datas!.rspBody!.soc!
                            .toString(),
                    style: TextStyle(color: Color(0xFF2673FB), fontSize: 36),
                    maxLines: 1,
                  ),
                  Text(
                    '%',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                'assets/images/wow/dashboard.png',
                width: 40,
                height: 27,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    controller.carDataModel.value.datas?.rspBody?.rangMileage ==
                            null
                        ? '470'
                        : controller
                            .carDataModel.value.datas!.rspBody!.rangMileage!
                            .toString(),
                    style: TextStyle(color: Color(0xFF2673FB), fontSize: 36),
                    maxLines: 1,
                  ),
                  Text(
                    'KM',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //车控视图
  Widget _buildCarControlView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/chekong/car.png',
                      width: 30,
                      height: 23,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('车辆'),
                    SizedBox(
                      width: 15,
                    ),
                    Obx(() => IndexedStack(
                          alignment: AlignmentDirectional.center,
                          index: (controller.currentCmdType == 3 &&
                                  (controller.currentCmdStatus == 1 ||
                                      controller.currentCmdStatus == 3))
                              ? 0
                              : 1,
                          children: <Widget>[
                            SpinKitCircle(
                              color: Color(0xFF1B7DF4),
                              size: 30,
                            ),
                            CustomButton(
                              width: 53,
                              height: 25,
                              radius: 12.5,
                              backgroundColor: Color(0xFF1B7DF4),
                              disabled: (controller.currentCmdType != 3 &&
                                      (controller.currentCmdStatus == 1 ||
                                          controller.currentCmdStatus == 3))
                                  ? true
                                  : false,
                              image: 'assets/images/chekong/find_car.png',
                              imageH: 13.5,
                              imageW: 15.5,
                              title: '寻车',
                              fontSize: 11,
                              titleColor: Colors.white,
                              onPressed: () => controller.sendControlCmd(3, 5),
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Obx(() => Text(
                          controller.carStatusModel.value.datas!.carLaunchStr!,
                          style: TextStyle(color: Color(0xFF999999)),
                          maxLines: 1,
                        ))),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(0xFFF3F3F3),
          ),
          GestureDetector(
            onTap: () => controller.pushAction(0),
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/chekong/lock.png',
                        width: 30,
                        height: 23,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('门锁'),
                      SizedBox(
                        width: 15,
                      ),
                      Obx(() => SwitchLoadingView(
                            width: 53,
                            height: 25,
                            selected: (controller.currentCmdType == 2 &&
                                    (controller.currentCmdStatus == 1 ||
                                        controller.currentCmdStatus == 3))
                                ? controller.openLock.value
                                : !controller.openLock.value,
                            unselectedText:
                                controller.openLock.value ? '开锁' : '等待',
                            selectedText:
                                controller.openLock.value ? '等待' : '落锁',
                            bgColor: controller.openLock.value
                                ? Color(0xFF1B7DF4)
                                : Color(0xFFFF6F6F),
                            loading: (controller.currentCmdType == 2 &&
                                (controller.currentCmdStatus == 1 ||
                                    controller.currentCmdStatus == 3)),
                            disabled: controller.disabledLock.value ||
                                (controller.currentCmdType != 2 &&
                                    (controller.currentCmdStatus == 1 ||
                                        controller.currentCmdStatus == 3)),
                            loadingColor: controller.openLock.value
                                ? Color(0xFF1B7DF4)
                                : Color(0xFFFF6F6F),
                            callback: () {
                              if (controller.openLock.value) {
                                controller.sendControlCmd(2, 2);
                              } else {
                                controller.sendControlCmd(2, 1);
                              }
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Obx(() => RichText(
                              text: TextSpan(
                                  text: controller
                                      .carStatusModel.value.datas!.doorOpenStr!,
                                  style: TextStyle(
                                      color: controller.carStatusModel.value
                                                  .datas?.allDoorStatus !=
                                              2
                                          ? Color(0xFFFF6F6F)
                                          : Color(0xFF999999)),
                                  children: [
                                TextSpan(
                                    text: '/',
                                    style: TextStyle(color: Color(0xFF999999))),
                                TextSpan(
                                  text: controller
                                      .carStatusModel.value.datas!.lockOpenStr!,
                                  style: TextStyle(
                                      color: controller.carStatusModel.value
                                                  .datas?.allLockStatus !=
                                              2
                                          ? Color(0xFFFF6F6F)
                                          : Color(0xFF999999)),
                                ),
                              ]))),
                      Image.asset(
                        'assets/images/mine/mine_right_arrow.png',
                        width: 7.5,
                        height: 11,
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(0xFFF3F3F3),
          ),
          GestureDetector(
            onTap: () => controller.pushAction(1),
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/chekong/ck_kt.png',
                        width: 30,
                        height: 23,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('空调'),
                      SizedBox(
                        width: 15,
                      ),
                      Obx(() => IndexedStack(
                            alignment: AlignmentDirectional.center,
                            index: (controller.currentCmdType == 1 &&
                                    (controller.currentCmdStatus == 1 ||
                                        controller.currentCmdStatus == 3))
                                ? 0
                                : 1,
                            children: <Widget>[
                              SpinKitCircle(
                                color: Color(0xFF1B7DF4),
                                size: 30,
                              ),
                              CustomButton(
                                width: 30,
                                height: 30,
                                radius: 15,
                                backgroundColor: controller.carStatusModel.value
                                        .datas!.airOpenStatus!
                                    ? Colors.green
                                    : Color(0xFF1B7DF4),
                                disabled: (controller.currentCmdType != 1 &&
                                        (controller.currentCmdStatus == 1 ||
                                            controller.currentCmdStatus == 3))
                                    ? true
                                    : false,
                                image:
                                    'assets/images/chekong/air_white_switch.png',
                                imageH: 20,
                                imageW: 20,
                                onPressed: () {
                                  if (controller.carStatusModel.value.datas!
                                      .airOpenStatus!) {
                                    controller.sendControlCmd(1, 2);
                                  } else {
                                    controller.sendControlCmd(1, 1);
                                  }
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                            child: Obx(() => Text(
                                  controller
                                      .carStatusModel.value.datas!.airOpenStr!,
                                  style: TextStyle(
                                      color: controller.carStatusModel.value
                                              .datas!.airOpenStatus!
                                          ? Colors.green
                                          : Color(0xFF999999)),
                                  maxLines: 1,
                                ))),
                        Offstage(
                          offstage: false,
                          child: Image.asset(
                            'assets/images/mine/mine_right_arrow.png',
                            width: 7.5,
                            height: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(0xFFF3F3F3),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/chekong/car_light.png',
                      width: 30,
                      height: 23,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('车灯'),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Obx(() => RichText(
                          text: TextSpan(
                              text: controller
                                  .carStatusModel.value.datas!.warnLightStr!,
                              style: TextStyle(
                                  color: controller.carStatusModel.value.datas!
                                              .warnningLightStatus! ==
                                          '1'
                                      ? Color(0xFFFF6F6F)
                                      : Color(0xFF999999)),
                              children: [
                            TextSpan(
                                text: '/',
                                style: TextStyle(color: Color(0xFF999999))),
                            TextSpan(
                              text: controller.carStatusModel.value.datas!
                                  .positionLightStr!,
                              style: TextStyle(
                                  color: controller.carStatusModel.value.datas!
                                              .positionLightStatus! ==
                                          '1'
                                      ? Color(0xFFFF6F6F)
                                      : Color(0xFF999999)),
                            ),
                          ]))),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(0xFFF3F3F3),
          ),
          GestureDetector(
            onTap: () => controller.pushAction(2),
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/chekong/car_battery_diagnosis.png',
                        width: 30,
                        height: 23,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('电池诊断'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '健康度92%',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xFF999999)),
                        maxLines: 1,
                      ),
                      Image.asset(
                        'assets/images/mine/mine_right_arrow.png',
                        width: 7.5,
                        height: 11,
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future buttonAction(int index) async {
    if (index == 0) {
      //爱车配件
      Get.toNamed(Routes.CARPARTS);
    } else if (index == 1) {
      //违章查询
      if (Get.find<UserController>().userInfo.value.member!.isVehicle!) {
        Get.toNamed(Routes.VIOLATION);
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 2) {
      //预约保养
      if (Get.find<UserController>().userInfo.value.member!.isVehicle!) {
        CommonModel _model = await DioManager().request<CommonModel>(
            DioManager.POST, Api.reservationMaintainUrl,
            params: {
              'unionId':
                  Get.find<UserController>().userInfo.value.member!.unionid!,
              'vin': Get.find<UserController>().userInfo.value.member!.fVIN!
            });
        if (_model.datas != null && _model.datas!.length > 0) {
          Get.toNamed(Routes.WEBVIEW, arguments: {
            'url': _model.datas,
            'title': '预约保养',
            'hasNav': true,
          });
        } else {
          EasyLoading.showToast(_model.message!,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 3) {
      //实时导航
      Get.toNamed(Routes.NAVMAP);
    }
  }
}
