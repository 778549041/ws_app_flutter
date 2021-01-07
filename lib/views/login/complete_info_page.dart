import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/login/complete_info_controller.dart';
import 'package:ws_app_flutter/widgets/custom_button.dart';
import 'package:ws_app_flutter/widgets/round_avatar.dart';

class CompleteInfoPage extends GetView<CompleteInfoController> {
  //输入行
  Widget _buildInputRow(String prefix, String placeholder, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(prefix),
            Expanded(
              child: TextField(
                controller: index == 0
                    ? controller.nameController
                    : controller.professionController,
                style: TextStyle(fontSize: 15, color: Color(0xFFD6D6D6)),
                textAlign: TextAlign.end,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(index == 0 ? 15 : 10)
                ],
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: TextStyle(fontSize: 15, color: Color(0xFFD6D6D6)),
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
        Container(
          color: Color(0xFFD6D6D6),
          height: 1,
        ),
      ],
    );
  }

  //选择行
  Widget _buildPickerRow(String prefix, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          controller.selectSex();
        } else if (index == 2) {
          controller.selectBirth();
        } else if (index == 3) {
          controller.selectAddress();
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Text(prefix),
                Expanded(
                  child: Obx(() => Text(
                        index == 0
                            ? controller.phone.value
                            : index == 1
                                ? controller.sex.value
                                : index == 2
                                    ? controller.birthday.value
                                    : controller.addr.value,
                        textAlign: TextAlign.end,
                        style:
                            TextStyle(color: Color(0xFFD6D6D6), fontSize: 15),
                      )),
                )
              ],
            ),
          ),
          Container(
            color: Color(0xFFD6D6D6),
            height: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/common/bg.png',
              width: Get.width,
              height: Get.height / 2,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: Get.statusBarHeight + 32,
              right: 10,
              child: CustomButton(
                width: 60,
                height: 30,
                backgroundColor: Colors.transparent,
                title: '跳过',
                titleColor: Colors.white,
                imagePosition: XJImagePosition.XJImagePositionRight,
                image: 'assets/images/common/right_arrow_white.png',
                imageH: 30,
                imageW: 10,
                onPressed: () => controller.jumpToNext(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Get.statusBarHeight + 72),
              width: Get.width,
              height: Get.height - (Get.statusBarHeight + 72),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: RichText(
                        text: TextSpan(
                            text: '完善个人信息，即可获得',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            children: [
                              TextSpan(
                                text: '500',
                                style: TextStyle(
                                    color: Color(0xFFFCA807), fontSize: 20),
                              ),
                              TextSpan(
                                text: '积分',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Stack(
                        children: <Widget>[
                          Obx(
                            () => RoundAvatar(
                              height: 90,
                              borderWidth: 3,
                              imageUrl:
                                  controller.userInfo.value.member.headImg ??
                                      '',
                            ),
                          ),
                          Positioned(
                            bottom: 5.0,
                            right: 5.0,
                            child: Image.asset(
                              'assets/images/mine/vip_tag.png',
                              width: 18,
                              height: 18,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Obx(
                          () => Text(
                            controller.userInfo.value.member.name ?? '',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Image.asset(
                          'assets/images/mine/man.png',
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _buildInputRow('昵        称', '请输入昵称', 0),
                    _buildPickerRow('手  机  号', 0),
                    _buildPickerRow('性        别', 1),
                    _buildPickerRow('出生日期', 2),
                    _buildInputRow('职        业', '请输入职业', 1),
                    _buildPickerRow('现  居  地', 3),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      backgroundColor: Color(0xFF4245E5),
                      width: 200,
                      height: 44,
                      radius: 22,
                      title: '继续完善',
                      titleColor: Colors.white,
                      onPressed: () => controller.nextStep(),
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
