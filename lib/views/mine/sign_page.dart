import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/sign_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class SignPage extends GetView<SignController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '每日签到',
      bgColor: MainAppColor.mainSilverColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Obx(
                  () => RoundAvatar(
                    height: 90,
                    borderWidth: 3,
                    imageUrl: Get.find<UserController>()
                        .userInfo
                        .value
                        .member
                        ?.headImg,
                  ),
                ),
                Positioned(
                  bottom: 5.0,
                  right: 5.0,
                  child: Offstage(
                      offstage: !(Get.find<UserController>()
                          .userInfo
                          .value
                          .member!
                          .isVehicle!),
                      child: Image.asset(
                        'assets/images/mine/vip_tag.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      )),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Obx(() => Text(
                        (Get.find<UserController>()
                                    .userInfo
                                    .value
                                    .member!
                                    .showName!
                                    .length >
                                11)
                            ? Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .showName!
                                .substring(0, 11)
                            : Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .showName!,
                        style: TextStyle(fontSize: 15),
                      )),
                  // 销售员或者勋章标签
                  if (Get.find<UserController>()
                      .userInfo
                      .value
                      .member!
                      .memberInfo!
                      .showTag!)
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: MedalWidget(
                        tag: 'mine',
                        medalBtnImage: Get.find<UserController>()
                            .userInfo
                            .value
                            .member!
                            .memberInfo!
                            .medalOrSaleImageName!,
                        medalToastImage: Get.find<UserController>()
                            .userInfo
                            .value
                            .member!
                            .memberInfo!
                            .medalOrSaleDescImageName!,
                        isSales: Get.find<UserController>()
                            .userInfo
                            .value
                            .member!
                            .memberInfo!
                            .isSales!,
                      ),
                    ),
                  Obx(() => Offstage(
                        offstage: Get.find<UserController>()
                                .userInfo
                                .value
                                .member!
                                .sex!
                                .length ==
                            0,
                        child: Image.asset(
                          Get.find<UserController>()
                                      .userInfo
                                      .value
                                      .member!
                                      .sex ==
                                  '0'
                              ? 'assets/images/mine/woman.png'
                              : 'assets/images/mine/man.png',
                          width: 15,
                          height: 15,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TableCalendar(
                locale: 'zh_CN',
                firstDay: controller.firstDay,
                lastDay: controller.lastDay,
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                daysOfWeekHeight: 20,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                calendarBuilders:
                    CalendarBuilders(todayBuilder: (context, day, focusedDay) {
                  return Obx(
                    () => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            controller.hasSign.value ? Colors.red : Colors.grey,
                      ),
                      child: Center(
                        child: Text(day.day.toString()),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Obx(
              () => Offstage(
                offstage: !controller.hasSign.value,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: RichText(
                    text: TextSpan(
                      text: '签到成功，恭喜您获得',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: [
                        TextSpan(
                            text: controller.tipScore.value,
                            style:
                                (TextStyle(color: Colors.red, fontSize: 25))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => CustomButton(
                disabled: controller.hasSign.value,
                title: '点击签到',
                width: 140,
                height: 40,
                backgroundColor: controller.hasSign.value
                    ? Colors.grey
                    : MainAppColor.mainBlueBgColor,
                titleColor: Colors.white,
                radius: 20,
                onPressed: () => controller.signEvent(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
