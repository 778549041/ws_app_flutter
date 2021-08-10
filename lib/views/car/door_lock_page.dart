import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/control_loading_view.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';
import 'package:ws_app_flutter/widgets/global/switch_loading.dart';

class DoorLockPage extends GetView<EletricController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BasePage(
          title: '门锁状态',
          bgColor: MainAppColor.mainSilverColor,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/chekong/lock_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: <Widget>[
                  _buildTime(),
                  _buildCarImg(),
                  _buildGrid(),
                  _buildLockBtn(),
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
              controller.carStatusModel.value.datas?.sendingTime?.length == 0,
          child: Text(
            '车辆数据上传于：${DateUtil.formatDateMs(int.parse(controller.carStatusModel.value.datas!.sendingTime!))}',
            style: TextStyle(color: Color(0xFF999999), fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildCarImg() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Stack(
        children: <Widget>[
          NetImageWidget(
            imageUrl: controller.carStatusModel.value.datas!.fCarColorUrl!,
            placeholder: 'assets/images/chekong/all_door_open.png',
            width: Get.width,
            height: Get.width * 1297 / 1080,
            fit: BoxFit.fill,
          ),

          //前机盖
          Positioned(
            top: 10 * Get.width / 320,
            left: (Get.width - 35) / 2,
            width: 35,
            child: Offstage(
              offstage:
                  !(controller.carStatusModel.value.datas?.carOverStatus == '1'),
              child: _buildLockTag(0, '前机盖开'),
            ),
          ),

          //左前门关,左前锁开
          Positioned(
            top: 190 * Get.width / 320,
            left: Get.width / 2 - 100 - 80 * Get.width / 320,
            height: 35,
            width: 100,
            child: Offstage(
              offstage:
                  !(controller.carStatusModel.value.datas?.doorLfStatus == '2' &&
                      controller.carStatusModel.value.datas?.doorlockLfStatus ==
                          '1'),
              child: _buildLockTag(1, '左前锁开'),
            ),
          ),
          //左前门开,左前锁开
          Positioned(
            top: 160 * Get.width / 320,
            left: Get.width / 2 - 35 - 120 * Get.width / 320,
            width: 35,
            height: 80,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.doorLfStatus == '1' &&
                      controller.carStatusModel.value.datas?.doorlockLfStatus ==
                          '2'),
              child: _buildLockTag(0, '左前锁开'),
            ),
          ),

          //左后门关,左后锁开
          Positioned(
            top: 240 * Get.width / 320,
            left: Get.width / 2 - 100 - 80 * Get.width / 320,
            width: 100,
            height: 35,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.doorLbStatus == '2' &&
                      controller.carStatusModel.value.datas?.doorlockLbStatus ==
                          '1'),
              child: _buildLockTag(1, '左后锁开'),
            ),
          ),
          //左后门开,左后锁开
          Positioned(
            top: 250 * Get.width / 320,
            left: Get.width / 2 - 35 - 120 * Get.width / 320,
            width: 35,
            height: 80,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.doorLbStatus == '1' &&
                      controller.carStatusModel.value.datas?.doorlockLbStatus ==
                          '1'),
              child: _buildLockTag(0, '左后锁开'),
            ),
          ),

          //右前门关,右前锁开
          Positioned(
            top: 190 * Get.width / 320,
            right: Get.width / 2 - 100 - 80 * Get.width / 320,
            width: 100,
            height: 35,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.doorRfStatus == '2' &&
                      controller.carStatusModel.value.datas?.doorlockRfStatus ==
                          '1'),
              child: _buildLockTag(1, '右前锁开'),
            ),
          ),
          //右前门开,右前锁开
          Positioned(
            top: 160 * Get.width / 320,
            right: Get.width / 2 - 35 - 120 * Get.width / 320,
            width: 35,
            height: 80,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.doorRfStatus == '1' &&
                      controller.carStatusModel.value.datas?.doorlockRfStatus ==
                          '1'),
              child: _buildLockTag(0, '右前锁开'),
            ),
          ),

          //右后门关,右后锁开
          Positioned(
            top: 240 * Get.width / 320,
            right: Get.width / 2 - 100 - 80 * Get.width / 320,
            width: 100,
            height: 35,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.doorRbStatus == '2' &&
                      controller.carStatusModel.value.datas?.doorlockRbStatus ==
                          '1'),
              child: _buildLockTag(1, '右后锁开'),
            ),
          ),
          //右后门开,右后锁开
          Positioned(
            top: 250 * Get.width / 320,
            right: Get.width / 2 - 35 - 120 * Get.width / 320,
            width: 35,
            height: 80,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.doorRbStatus == '1' &&
                      controller.carStatusModel.value.datas?.doorlockRbStatus ==
                          '1'),
              child: _buildLockTag(0, '右后锁开'),
            ),
          ),

          //后备箱开
          Positioned(
            top: Get.width,
            left: (Get.width - 35) / 2,
            width: 35,
            child: Offstage(
              offstage: !(controller.carStatusModel.value.datas?.trunkStatus == '1'),
              child: _buildLockTag(0, '后备箱开'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockTag(int type, String title) {
    if (type == 0) {
      //row
      if (title == '前机盖开') {
        return Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            Image.asset(
              'assets/images/chekong/lock_down_arrow.png',
              width: 8,
              height: 10,
            ),
            Image.asset(
              'assets/images/chekong/extend_box_open.png',
              width: 30,
              height: 30,
            ),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Image.asset(
              'assets/images/chekong/lock_open.png',
              width: 30,
              height: 30,
            ),
            Image.asset(
              'assets/images/chekong/lock_up_arrow.png',
              width: 8,
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        );
      }
    } else {
      //column
      if (title.contains('左')) {
        return Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 13),
            ),
            Image.asset(
              'assets/images/chekong/lock_right_arrow.png',
              width: 8,
              height: 10,
            ),
            Image.asset(
              'assets/images/chekong/lock_open.png',
              width: 30,
              height: 30,
            ),
          ],
        );
      } else {
        return Row(
          children: <Widget>[
            Image.asset(
              'assets/images/chekong/lock_open.png',
              width: 30,
              height: 30,
            ),
            Image.asset(
              'assets/images/chekong/lock_left_arrow.png',
              width: 8,
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 13),
            ),
          ],
        );
      }
    }
  }

  Widget _buildGrid() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 25, 15, 20),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            return _buildGridItem(context, index);
          }),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    String title = '', content = '获取中';
    Color boxColor = Color(0xFFCCCCCC);
    if (index == 0) {
      title = '车门';
      if (controller.carStatusModel.value.datas?.allDoorStatus != 2) {
        content = '开';
        boxColor = Color(0xFFFF6F6F);
      } else {
        content = '关';
        boxColor = Color(0xFFCCCCCC);
      }
    } else if (index == 1) {
      title = '门锁';
      if (controller.carStatusModel.value.datas?.allLockStatus != 2) {
        content = '开';
        boxColor = Color(0xFFFF6F6F);
      } else {
        content = '关';
        boxColor = Color(0xFFCCCCCC);
      }
    } else if (index == 2) {
      title = '后备箱';
      if (controller.carStatusModel.value.datas?.trunkStatus != '2') {
        content = '开';
        boxColor = Color(0xFFFF6F6F);
      } else {
        content = '关';
        boxColor = Color(0xFFCCCCCC);
      }
    } else if (index == 3) {
      title = '前机盖';
      if (controller.carStatusModel.value.datas?.carOverStatus != '2') {
        content = '开';
        boxColor = Color(0xFFFF6F6F);
      } else {
        content = '关';
        boxColor = Color(0xFFCCCCCC);
      }
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 9,
            left: 9,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: boxColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  content,
                  style: TextStyle(color: boxColor, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLockBtn() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Obx(
        () => SwitchLoadingView(
          width: 128,
          height: 44,
          textStyle: TextStyle(color: Colors.white, fontSize: 18),
          selected: (controller.currentCmdType == 2 &&
                  (controller.currentCmdStatus == 1 ||
                      controller.currentCmdStatus == 3))
              ? controller.openLock.value
              : !controller.openLock.value,
          unselectedText: controller.openLock.value ? '开锁' : '等待',
          selectedText: controller.openLock.value ? '等待' : '落锁',
          bgColor:
              controller.openLock.value ? Color(0xFF1B7DF4) : Color(0xFFFF6F6F),
          loading: (controller.currentCmdType == 2 &&
              (controller.currentCmdStatus == 1 ||
                  controller.currentCmdStatus == 3)),
          disabled: controller.disabledLock.value ||
              (controller.currentCmdType != 2 &&
                  (controller.currentCmdStatus == 1 ||
                      controller.currentCmdStatus == 3)),
          loadingColor:
              controller.openLock.value ? Color(0xFF1B7DF4) : Color(0xFFFF6F6F),
          callback: () {
            if (controller.openLock.value) {
              controller.sendControlCmd(2, 2);
            } else {
              controller.sendControlCmd(2, 1);
            }
          },
        ),
      ),
    );
  }
}
