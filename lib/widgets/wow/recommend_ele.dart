import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/gradient_progress.dart';
import 'package:ws_app_flutter/widgets/global/turnbox.dart';

class RecommendEle extends StatefulWidget {
  @override
  RecommendEleState createState() => RecommendEleState();
}

class RecommendEleState extends State<RecommendEle>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  TimerUtil _timerUtil;
  bool _charging = true;
  double _progressValue = 1.0;
  CarDataModel _carDataModel = CarDataModel();
  List<Color> _colors = [Color(0xFF2659FF), Color(0xFF01D4D7)];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF3F3F3),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                      width: 60,
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            height: 60,
                            top: 0,
                            child: TurnBox(
                              turns: 0.50,
                              child: GradientCircularProgressIndicator(
                                colors: _colors,
                                radius: 30,
                                strokeWidth: 3,
                                value: _animationController.value,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 30,
                              child: Text(
                                _charging ? '充电中' : '剩余电量',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _carDataModel.datas.rspBody.soc.toString(),
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
                      _carDataModel.datas.rspBody.rangMileage.toString(),
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

  @override
  void initState() {
    _timerUtil = TimerUtil(mInterval: 120 * 1000);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _requestElectricityData();
    super.initState();
  }

  //请求电量信息数据
  void _requestElectricityData() {
    if (Get.find<UserController>().userInfo.value.member.isVehicle == 'true') {
      _timerUtil.setOnTimerTickCallback((millisUntilFinished) async {
        CarDataModel obj = await DioManager().request<CarDataModel>(
            DioManager.POST, Api.vechileEleDataUrl, queryParamters: {
          "member_id": Get.find<UserController>().userInfo.value.member.memberId
        });
        setState(() {
          _carDataModel = obj;
          if (obj.datas.rspBody.chargingStatus == 1 ||
              obj.datas.rspBody.chargingStatus == 2) {
            _charging = true;
            _progressValue = 1.0;
            _colors = [Color(0xFF2659FF), Color(0xFF01D4D7)];
          } else {
            _progressValue = obj.datas.rspBody.soc / 100;
            _charging = false;
            if (_progressValue <= 0.25) {
              _colors = [Color(0xFFE80016), Color(0xFFE80016)];
            } else if (_progressValue <= 0.50) {
              _colors = [Color(0xFFF2AE2C), Color(0xFFF2AE2C)];
            } else {
              _colors = [Color(0xFF1EE623), Color(0xFF1EE623)];
            }
          }
          _animationController = AnimationController(
              vsync: this,
              duration: Duration(seconds: 2),
              upperBound: _progressValue);
          if (_charging) {
            _animationController.repeat();
          } else {
            _animationController.forward();
          }
        });
      });
      _timerUtil.startTimer();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (_timerUtil != null) _timerUtil.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(RecommendEle oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
