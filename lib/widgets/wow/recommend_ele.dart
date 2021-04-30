import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
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
          Text(
            '车辆数据上传于：2021-4-30 10:17:17',
            style: TextStyle(color: Color(0xFF999999), fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          _buildCarControlView(),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: <Widget>[
                _buildToolBtn(0, 'assets/images/wow/neardz.png'),
                _buildToolBtn(1, 'assets/images/wow/eluwy.png'),
                _buildToolBtn(2, 'assets/images/wow/yyby.png'),
                _buildToolBtn(3, 'assets/images/wow/dczd.png'),
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
          CircularPercentIndicator(
            radius: 60,
            lineWidth: 3,
            animation: true,
            startAngle: 180,
            animationDuration: 2000,
            percent: controller.progressValue.value,
            rotateLinearGradient: true,
            restartAnimation: true,
            backgroundColor: Color(0xFFEEEEEE),
            circularStrokeCap: CircularStrokeCap.round,
            center: Container(
              width: 30,
              child: Text(
                controller.charging.value ? '充电中' : '剩余电量',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
            linearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: controller.colors,
            ),
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
            height: 65,
            color: Colors.black.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/wow/dashboard.png',
                  width: 40,
                  height: 27,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 45,
                  child: Text(
                    '可续航里程',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  controller.carDataModel.value.datas.rspBody.rangMileage.toString(),
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
      color: Colors.white,
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
    return Padding(
      padding: EdgeInsets.only(left: spacing),
      child: CustomButton(
        width: _width,
        height: _height,
        image: imageName,
        imageW: _width,
        imageH: _height,
        onPressed: () => buttonAction(index),
      ),
    );
  }

  Future buttonAction(int index) async {
    if (index == 0) {
      //附近电桩
      Get.toNamed(Routes.NEARDZMAP);
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
      //预约保养
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        CommonModel _model = await DioManager().request<CommonModel>(
            DioManager.POST, Api.reservationMaintainUrl,
            params: {
              'unionId':
                  Get.find<UserController>().userInfo.value.member.unionid,
              'vin': Get.find<UserController>().userInfo.value.member.fVIN
            });
        if (_model.datas != null && _model.datas.length > 0) {
          Get.toNamed(Routes.WEBVIEW, arguments: {
            'url': _model.datas,
            'title': '预约保养',
            'hasNav': true,
          });
        } else {
          EasyLoading.showToast(_model.message,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 3) {
      //电池诊断
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        Get.toNamed(Routes.WEBVIEW, arguments: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.BatteryDiagonisPage
        });
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    }
  }
}
