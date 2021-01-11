import 'package:flutter/material.dart';
import 'package:flutterautotext/index.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF3F3F3),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
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
                                colors: [Color(0xFF2659FF), Color(0xFF01D4D7)],
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
                                '剩余电量',
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
                    FlutterAutoText(
                      text: '70',
                      width: 70,
                      textSize: 47,
                      textColor: Color(0xFF2673FB),
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
                    FlutterAutoText(
                      text: '280',
                      width: 70,
                      textSize: 47,
                      textColor: Color(0xFF2673FB),
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
                _buildToolBtn(3, 'assets/images/wow/yjjy.png'),
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
        onPressed: () {},
      ),
    );
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
