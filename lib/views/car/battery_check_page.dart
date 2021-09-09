import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/car/battery_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'dart:math' as math;

class BatteryCheckPage extends GetView<BatteryController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '电池诊断',
      child: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
          child: controller.model.value.datas == null
              ? Container()
              : Column(
                  children: <Widget>[
                    _buildBatteryItem(),
                    _buildCheckItem(),
                    _buildCommentItem(),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        '*该报告为近30天数据分析结果',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildBatteryItem() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          'assets/images/car/chartyuan.png',
          width: Get.width - 60,
          height: (Get.width - 60) * 497 / 570,
          fit: BoxFit.cover,
        ),
        Positioned(
          child: Transform.rotate(
            angle: (math.pi /
                2 *
                (controller.model.value.datas!.healthValue! - 50) /
                50),
            child: Image.asset(
              'assets/images/car/chartjiantou.png',
              height: (Get.width - 60) * 390 / 570,
              width: 30,
            ),
          ),
        ),
        Positioned(
          child: RichText(
            text: TextSpan(
              text: controller.model.value.datas!.healthValue!.toString(),
              style: TextStyle(color: Color(0xFF3777aa), fontSize: 48),
              children: [
                TextSpan(
                  text: '%',
                  style: TextStyle(color: Color(0xFF3777aa), fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: (Get.width - 60) * 497 / 570 - 40,
          child: Text(
            '电池指数',
            style: TextStyle(color: Color(0xFF0045d0), fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 4,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return _buildGridItem(index);
        },
        itemCount: 9,
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: index.isEven
              ? [Color(0xFFD5DBF5), Color(0xFFD1DFF5), Color(0xFFCEE3F6)]
              : [Color(0xFF2E4ACF), Color(0xFF0876D0)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      _getItemImgName(index),
                      width: 24,
                      height: 19,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    AutoSizeText(
                      _getItemTitle(index),
                      minFontSize: 6,
                      style: TextStyle(
                          color:
                              index.isEven ? Color(0xFF0045D0) : Colors.white,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.white,
            width: 1.0,
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: Center(
                child: index == 0 || index == 1 || index == 2
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _getItemValue(index),
                            style: TextStyle(
                                color: index.isEven
                                    ? Color(0xFF0045D0)
                                    : Colors.white,
                                fontSize: 16),
                          ),
                          Text(
                            _getItemValueTag(index),
                            style: TextStyle(
                              color: index.isEven
                                  ? Color(0xFF0045D0)
                                  : Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    : RichText(
                        text: TextSpan(
                          text: _getItemValue(index),
                          style: TextStyle(
                            color:
                                index.isEven ? Color(0xFF0045D0) : Colors.white,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: _getItemValueTag(index),
                              style: TextStyle(
                                color: index.isEven
                                    ? Color(0xFF0045D0)
                                    : Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getItemImgName(int index) {
    if (index == 0) {
      return 'assets/images/car/miles_day.png';
    } else if (index == 1) {
      return 'assets/images/car/time_day.png';
    } else if (index == 2) {
      return 'assets/images/car/speed_avg.png';
    } else if (index == 3) {
      return 'assets/images/car/charge_count_month.png';
    } else if (index == 4) {
      return 'assets/images/car/rapid_acc.png';
    } else if (index == 5) {
      return 'assets/images/car/rapid_slow.png';
    } else if (index == 6) {
      return 'assets/images/car/charge_begin_soc.png';
    } else if (index == 7) {
      return 'assets/images/car/charge_slow.png';
    } else {
      return 'assets/images/car/charge_fast.png';
    }
  }

  String _getItemTitle(int index) {
    if (index == 0) {
      return '日均行驶里程';
    } else if (index == 1) {
      return '日均行驶时长';
    } else if (index == 2) {
      return '平均速度';
    } else if (index == 3) {
      return '月均充电次数';
    } else if (index == 4) {
      return '急加速次数';
    } else if (index == 5) {
      return '急减速次数';
    } else if (index == 6) {
      return '起始充电量';
    } else if (index == 7) {
      return '慢充占比';
    } else {
      return '快充占比';
    }
  }

  String _getItemValue(int index) {
    if (index == 0) {
      return controller.model.value.datas!.milesDay!;
    } else if (index == 1) {
      return controller.model.value.datas!.timeDay!;
    } else if (index == 2) {
      return controller.model.value.datas!.speedAvg!;
    } else if (index == 3) {
      return controller.model.value.datas!.chargeTimeMonth!;
    } else if (index == 4) {
      return controller.model.value.datas!.rapidAcc!;
    } else if (index == 5) {
      return controller.model.value.datas!.rapidSlow!;
    } else if (index == 6) {
      var v1 = controller.model.value.datas!.socCharge! * 100;
      var v2 = v1.toInt();
      return (controller.model.value.datas!.socCharge! * 100).toInt().toString();
    } else if (index == 7) {
      return (controller.model.value.datas!.chargeSlow! * 100).toInt().toString();
    } else {
      return (controller.model.value.datas!.chargeFast! * 100).toInt().toString();
    }
  }

  String _getItemValueTag(int index) {
    if (index == 0) {
      return 'km';
    } else if (index == 1) {
      return 'h';
    } else if (index == 2) {
      return 'km/h';
    } else if (index == 3) {
      return '次';
    } else if (index == 4) {
      return '次';
    } else if (index == 5) {
      return '次';
    } else if (index == 6) {
      return '%';
    } else if (index == 7) {
      return '%';
    } else {
      return '%';
    }
  }

  Widget _buildCommentItem() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [Color(0xFF2E4ACF), Color(0xFF0876D0)],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minHeight: 80),
                width: 10,
                margin: const EdgeInsets.only(left: 10),
                child: Center(
                  child: Text(
                    '行驶建议',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    controller.model.value.datas!.comments!,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 30,
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
