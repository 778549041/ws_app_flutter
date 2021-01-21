import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class OwnCarWidget extends StatefulWidget {
  @override
  OwnCarWidgetState createState() => OwnCarWidgetState();
}

class OwnCarWidgetState extends State<OwnCarWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  TimerUtil _timerUtil;
  bool _charging = true;
  CarDataModel _carDataModel = CarDataModel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      top: _animation.value,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                          'assets/images/car/car_charge_animate.png'),
                    );
                  },
                ),
                Image.asset(
                  'assets/images/car/car_flash.png',
                  width: ScreenUtil.getInstance().getWidth(250),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: <Widget>[
                          Text(
                            _carDataModel.datas.rspBody.soc.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                          Text(
                            '%',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _charging ? '充电中' : '剩余电量',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (_carDataModel.datas.fcarColorURL.length > 0)
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: CachedNetworkImage(
                            imageUrl: _carDataModel.datas.fcarColorURL),
                      ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: Text(
                        _carDataModel.datas.fcarColor,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/car/car_dashboard.png',
                            width: 21.5,
                            height: 13.5,
                          ),
                          RichText(
                            text: TextSpan(
                                text: '可续航里程 ',
                                style: TextStyle(
                                    color: Color(0xFF2674FB), fontSize: 15),
                                children: [
                                  TextSpan(
                                      text: _carDataModel
                                          .datas.rspBody.rangMileage
                                          .toString(),
                                      style: TextStyle(
                                          color: Color(0xFF1B7DF4),
                                          fontSize: 24)),
                                  TextSpan(
                                    text: ' km',
                                    style: TextStyle(
                                        color: Color(0xFF2674FB), fontSize: 15),
                                  )
                                ]),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              height: Get.width / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      return Container();
                    }),
              ),
            )
          ],
        ),
      ),
    );
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
          } else {
            _charging = false;
          }
          if (_charging) {
            _animationController.repeat();
          } else {
            _animationController.stop();
          }
        });
      });
      _timerUtil.startTimer();
    }
  }

  @override
  void initState() {
    _timerUtil = TimerUtil(mInterval: 120 * 1000);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animationController);
    _requestElectricityData();
    super.initState();
  }

  @override
  void dispose() {
    if (_timerUtil != null) _timerUtil.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OwnCarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
