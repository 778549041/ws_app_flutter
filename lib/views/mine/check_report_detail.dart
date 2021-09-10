import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/report_list_model.dart';
import 'package:ws_app_flutter/view_models/mine/check_report_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'dart:math' as math;

class CheckReportDetail extends GetView<CheckReportDetailController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'EV车辆健康检查表',
      bgColor: MainAppColor.mainSilverColor,
      child: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: controller.model.value.info == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildFirstItem(),
                    _buildExteriorItem(),
                    _buildInteriorItem(),
                    _buildFunctionItem(),
                    _buildFreeItem(),
                    _buildPayItem(),
                  ],
                ),
        ),
      ),
    );
  }

  //动力检查相关
  Widget _buildFirstItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          _buildEngieBatteryItem(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: _buildBatteryItem(),
            ),
          ),
          _buildCheckItem(),
          _buildCommentItem(),
          _buildHabitComment(),
          _buildChargeComment(),
        ],
      ),
    );
  }

  //姓名、日期、车架号
  Widget _buildEngieBatteryItem() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '姓名：' + controller.model.value.info!.name!,
                        style: TextStyle(
                            color: MainAppColor.secondaryTextColor,
                            fontSize: 13),
                      ),
                    ),
                    Text(
                      '日期：' + controller.model.value.info!.Date!,
                      style: TextStyle(
                          color: MainAppColor.secondaryTextColor, fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '车架号：' + controller.model.value.info!.VIN!,
                  style: TextStyle(
                      color: MainAppColor.secondaryTextColor, fontSize: 13),
                ),
              ],
            ),
          ),
          Divider(
            color: MainAppColor.seperatorLineColor,
            height: 0.5,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '动力电池检查',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  //电池指数
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
          //彩色进度条宽度为18
          top:
              ((Get.width - 60) * 497 / 570 - 18 * (Get.width - 60) / 570) / 2 -
                  (Get.width - 60) * 390 / 570 / 2 +
                  18 * (Get.width - 60) / 570,
          child: Transform.rotate(
            angle: (math.pi /
                2 *
                (controller.model.value.info!.Fraction! - 50) /
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
              text: controller.model.value.info!.Fraction!.toString(),
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

  //行驶参数
  Widget _buildCheckItem() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
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
        itemCount: 6,
      ),
    );
  }

  //行驶参数item
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
                child: RichText(
                  text: TextSpan(
                    text: _getItemValue(index),
                    style: TextStyle(
                      color: index.isEven ? Color(0xFF0045D0) : Colors.white,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: _getItemValueTag(index),
                        style: TextStyle(
                          color:
                              index.isEven ? Color(0xFF0045D0) : Colors.white,
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
      return 'assets/images/car/rapid_acc.png';
    } else if (index == 3) {
      return 'assets/images/car/charge_count_month.png';
    } else if (index == 4) {
      return 'assets/images/car/charge_begin_soc.png';
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
      return '急加速次数';
    } else if (index == 3) {
      return '月均充电次数';
    } else if (index == 4) {
      return '起始充电量';
    } else {
      return '快充占比';
    }
  }

  String _getItemValue(int index) {
    if (index == 0) {
      return controller.model.value.info!.Mileage!;
    } else if (index == 1) {
      return controller.model.value.info!.Timelength!;
    } else if (index == 2) {
      return controller.model.value.info!.Accelerate!;
    } else if (index == 3) {
      return controller.model.value.info!.ChargeCount!;
    } else if (index == 4) {
      return controller.model.value.info!.InitialCharge!;
    } else {
      return controller.model.value.info!.FastChargeRatio!;
    }
  }

  String _getItemValueTag(int index) {
    if (index == 0) {
      return 'km';
    } else if (index == 1) {
      return 'h';
    } else if (index == 2) {
      return '次';
    } else if (index == 3) {
      return '次';
    } else if (index == 4) {
      return '%';
    } else {
      return '%';
    }
  }

  //行驶建议
  Widget _buildCommentItem() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [Color(0xFF2E4ACF), Color(0xFF0876D0)],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  '行驶建议',
                  style: TextStyle(color: Colors.white, fontSize: 13),
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
                    controller.model.value.info?.Evaluation == null
                        ? ''
                        : controller.model.value.info!.Evaluation!,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 70,
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

  //驾驶习惯建议
  Widget _buildHabitComment() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '关于驾驶习惯：',
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          Expanded(
            child: Text(
              controller.model.value.info?.HabitsAdvice == null
                  ? ''
                  : controller.model.value.info!.HabitsAdvice!,
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  //充电建议
  Widget _buildChargeComment() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '关于充电：',
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          Expanded(
            child: Text(
              controller.model.value.info?.ChargeAdvice == null
                  ? ''
                  : controller.model.value.info!.ChargeAdvice!,
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  //外观检查
  Widget _buildExteriorItem() {
    List<Widget> children = <Widget>[];
    children.add(
      Image.asset(
        'assets/images/car/chart_car.png',
        width: Get.width - 30,
        height: (Get.width - 30) * 334 / 624,
      ),
    );
    controller.model.value.info!.data!.forEach((element) {
      children.add(
        Positioned(
          top: element.dy! * (Get.width - 30) / 624 * 1.5 - 11,
          left: element.dx! * (Get.width - 30) / 624 * 1.5 + 15 - 22,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                element.ItemNo!,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      );
    });
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Stack(
              children: children,
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/car/chart_exterior.png',
                  width: 100,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: AutoSizeText(
                    'A-凹陷 D-掉漆 H-划痕 L-裂痕 P-破损 X-锈蚀',
                    minFontSize: 6,
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //内饰检查
  Widget _buildInteriorItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                CheckDataItem item =
                    controller.model.value.info!.neishi![index];
                return __buildInteriorGridItem(item);
              },
              itemCount: controller.model.value.info!.neishi!.length,
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/car/chart_interior.png',
                  width: 100,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '正常划',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                      children: [
                        TextSpan(
                          text: '√',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                        TextSpan(
                          text: '，异常划',
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        TextSpan(
                          text: '×',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget __buildInteriorGridItem(CheckDataItem item) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AutoSizeText(
            item.name!,
            minFontSize: 6,
            style: TextStyle(fontSize: 10),
            maxLines: 1,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Image.asset(
            item.value!
                ? 'assets/images/car/chart_dui.png'
                : 'assets/images/car/chart_cuo.png',
            width: 10,
            height: 10,
          ),
        ),
      ],
    );
  }

  //功能检查
  Widget _buildFunctionItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                return __buildFunctionGridItem(index);
              },
              itemCount: 8,
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/car/chart_function.png',
                  width: 100,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '正常划',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                      children: [
                        TextSpan(
                          text: '√',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                        TextSpan(
                          text: '，异常划',
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        TextSpan(
                          text: '×',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget __buildFunctionGridItem(int index) {
    List<CheckDataItem> list = _getFunctionGridItemDataList(index);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _getFunctionGridItemTitle(index),
          style: TextStyle(color: Color(0xFF0045d0), fontSize: 10),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, idx) {
            CheckDataItem item = list[idx];
            return __buildInteriorGridItem(item);
          },
        ),
      ],
    );
  }

  String _getFunctionGridItemTitle(int index) {
    if (index == 0) {
      return '动力系统：';
    } else if (index == 1) {
      return '灯光：';
    } else if (index == 2) {
      return '仪表与操作：';
    } else if (index == 3) {
      return '空调系统：';
    } else if (index == 4) {
      return '油水检查：';
    } else if (index == 5) {
      return '车窗玻璃：';
    } else if (index == 6) {
      return '音响系统：';
    } else if (index == 7) {
      return '悬挂、制动：';
    } else {
      return '';
    }
  }

  List<CheckDataItem> _getFunctionGridItemDataList(int index) {
    if (index == 0) {
      return controller.model.value.info!.dongli!;
    } else if (index == 1) {
      return controller.model.value.info!.dengguang!;
    } else if (index == 2) {
      return controller.model.value.info!.yibiao!;
    } else if (index == 3) {
      return controller.model.value.info!.kongtiao!;
    } else if (index == 4) {
      return controller.model.value.info!.youshui!;
    } else if (index == 5) {
      return controller.model.value.info!.chechuang!;
    } else if (index == 6) {
      return controller.model.value.info!.yinxiang!;
    } else if (index == 7) {
      return controller.model.value.info!.xuangua!;
    } else {
      return <CheckDataItem>[];
    }
  }

  //免费修复项目
  Widget _buildFreeItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: 200),
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Text(
              controller.model.value.info!.Free!,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Positioned(
            left: 10,
            child: Image.asset(
              'assets/images/car/chart_free.png',
              width: 120,
            ),
          ),
        ],
      ),
    );
  }

  //付费修复项目
  Widget _buildPayItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: 200),
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Text(
              controller.model.value.info!.Toll!,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Positioned(
            left: 10,
            child: Image.asset(
              'assets/images/car/chart_pay.png',
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}
