import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class IntegralRulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '积分规则',
      bgColor: MainAppColor.mainSilverColor,
      child: SingleChildScrollView(
        child: Container(
          height: (Get.height -
              ScreenUtil.getInstance().statusBarHeight -
              ScreenUtil.getInstance().appBarHeight),
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  '一、如何查看积分？',
                  style: TextStyle(color: Color(0xFF4245E5), fontSize: 13),
                ),
              ),
              Divider(
                color: MainAppColor.seperatorLineColor,
                height: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40),
                child: Text(
                  '用户可在“优享”&“我的”界面查看个人当前积分值',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  '二、如何获取积分？',
                  style: TextStyle(color: Color(0xFF4245E5), fontSize: 13),
                ),
              ),
              Divider(
                color: MainAppColor.seperatorLineColor,
                height: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '用户可以通过注册、完善个人信息、日常签到、参与线上线下活动获得相应积分；同时车辆行驶及充电亦可获得积分哦。',
                      style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      title: '点击获取更多积分攻略',
                      borderColor: Color(0xFF333333),
                      borderWidth: 0.5,
                      width: 130,
                      height: 20,
                      fontSize: 12,
                      titleColor: Color(0xFFAB2A52),
                      radius: 10,
                      onPressed: () {
                        Get.toNamed(Routes.INTEGRALSTRATEGY);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  '三、如何使用积分？',
                  style: TextStyle(color: Color(0xFF4245E5), fontSize: 13),
                ),
              ),
              Divider(
                color: MainAppColor.seperatorLineColor,
                height: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40),
                child: Text(
                  '用户通过WOW-积分商城，使用积分兑换商品或服务类权益，也可于“优享”参与“许心愿”“抽大奖”等积分游戏活动。（更多使用场景，敬请关注。）',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  '四、积分是否会失效？',
                  style: TextStyle(color: Color(0xFF4245E5), fontSize: 13),
                ),
              ),
              Divider(
                color: MainAppColor.seperatorLineColor,
                height: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40),
                child: Text(
                  '积分有效期为两年，自积分入账之日起至第24个月月底，逾期积分将自动失效。例如：2019年12月31日前获取的积分，有效期自2019年12月31日开始计算，2021年12月31日24点过期失效。',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: Text(
                  '本页面内容仅供参考，最终解释权属广汽本田汽车有限公司。',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
