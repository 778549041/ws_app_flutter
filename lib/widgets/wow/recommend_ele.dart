import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/color_key.dart';
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

class RecommendEle extends GetView<EletricController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF3F3F3),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          _buildEletricView(),
          Obx(() => Offstage(
                offstage:
                    controller.carStatusModel.value.datas.sendingTime.length ==
                        0,
                child: Text(
                  '车辆数据上传于：${DateUtil.formatDateMs(int.parse(controller.carStatusModel.value.datas.sendingTime))}',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          _buildCarControlView(),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: <Widget>[
                _buildToolBtn(0, 'assets/images/wow/home_miles.png'),
                _buildToolBtn(1, 'assets/images/wow/home_battery.png'),
                _buildToolBtn(2, 'assets/images/wow/home_cd.png'),
                _buildToolBtn(3, 'assets/images/wow/home_sos.png'),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  //电量信息
  Widget _buildEletricView() {
    return Obx(
      () => Row(
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
                Text(
                  controller.carDataModel.value.datas.rspBody.soc.toString(),
                  style: TextStyle(color: Color(0xFF2673FB), fontSize: 36),
                ),
                Text(
                  '%',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            width: 0.5,
            height: 40,
            color: Colors.black.withOpacity(0.3),
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
                Text(
                  controller.carDataModel.value.datas.rspBody.rangMileage
                      .toString(),
                  style: TextStyle(color: Color(0xFF2673FB), fontSize: 36),
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
    );
  }

  //车控视图
  Widget _buildCarControlView() {
    return Container(
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
                    IndexedStack(
                      alignment: AlignmentDirectional.center,
                      index: 1,
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
                          image: 'assets/images/chekong/find_car.png',
                          imageH: 13.5,
                          imageW: 15.5,
                          title: '寻车',
                          fontSize: 11,
                          titleColor: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text(
                  '熄火',
                  style: TextStyle(color: Color(0xFF999999)),
                  maxLines: 1,
                )),
              ],
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
                    IndexedStack(
                      alignment: AlignmentDirectional.center,
                      index: 1,
                      children: <Widget>[
                        SpinKitCircle(
                          color: Color(0xFF1B7DF4),
                          size: 30,
                        ),
                        SwitchLoadingView(
                          width: 53,
                          height: 25,
                          unselectedText: '开锁',
                          selectedText: '落锁',
                          bgColor: Color(0xFF1B7DF4),
                          loadingColor: Color(0xFF1B7DF4),
                          callback: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
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
                      '车门关/车锁关',
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
                    IndexedStack(
                      alignment: AlignmentDirectional.center,
                      index: 1,
                      children: <Widget>[
                        SpinKitCircle(
                          color: Color(0xFF1B7DF4),
                          size: 30,
                        ),
                        CustomButton(
                          width: 30,
                          height: 30,
                          image: 'assets/images/chekong/kt_switch.png',
                          imageH: 30,
                          imageW: 30,
                          onPressed: () {},
                        ),
                      ],
                    ),
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
                          child: Text(
                        '空调已关闭',
                        style: TextStyle(color: Color(0xFF999999)),
                        maxLines: 1,
                      )),
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
        ],
      ),
    );
  }

  Widget _buildToolBtn(int index, String imageName) {
    final double _width = (Get.width - 51) / 4;
    final double _height = _width * 75 / 81;
    final double spacing = index == 0 ? 0 : 7;
    var _title = index == 0
        ? '里程信息'
        : index == 1
            ? 'e路无忧'
            : index == 2
                ? '附近电桩'
                : '一键救援';
    return GestureDetector(
      onTap: () => buttonAction(index),
      child: Container(
          margin: EdgeInsets.only(left: spacing),
          width: _width,
          height: _height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imageName,
                width: 24,
                height: 24,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1.5,
                color: MainAppColor.secondaryTextColor,
                indent: 15,
                endIndent: 15,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _title,
                style: TextStyle(fontSize: 12),
              ),
            ],
          )),
    );
  }

  Future buttonAction(int index) async {
    if (index == 0) {
      //里程信息
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        Get.toNamed(Routes.WEBVIEW, arguments: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.MilesInfoPage
        });
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 1) {
      //e路无忧
      CommonModel _model = await DioManager()
          .request<CommonModel>(DioManager.GET, Api.ePushJudgeUrl);
      if (_model.status) {
        Get.toNamed(Routes.WEBVIEW, arguments: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.ServicePackageIntroduction
        });
      } else {
        Get.toNamed(Routes.WEBVIEW, arguments: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.ServicePackage
        });
      }
    } else if (index == 2) {
      //附近电桩
      Get.toNamed(Routes.NEARDZMAP);
    } else if (index == 3) {
      //一键救援
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        //拨号
        if (await canLaunch('tel:400-830-8999')) {
          launch('tel:400-830-8999');
        }
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    }
  }
}
