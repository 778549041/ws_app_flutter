import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/car/config_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class ConfigDetailPage extends GetView<ConfigDetailController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '配置详情',
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15),
        child: Obx(
          () => Column(
            children: <Widget>[
              Image.asset(
                'assets/images/car/config_detail_title.png',
                width: 113,
                height: 47,
              ),
              _buildVE1ConfigContainer(),
              _buildVE1SConfigContainer(),
              _buildVersionHeader(),
              _buildExpandableWidget('基础参数', _jccsExpandedWidget()),
              _buildExpandableWidget('动力系统', _dlxtExpandedWidget()),
              _buildExpandableWidget('底盘系统', _dpxtExpandedWidget()),
              _buildExpandableWidget('安全系统', _aqxtExpandedWidget()),
              _buildExpandableWidget('外观', _wgExpandedWidget()),
              _buildExpandableWidget('内饰', _nsExpandedWidget()),
              _buildExpandableWidget('舒适及便利配置', _ssblExpandedWidget()),
              _buildExpandableWidget('智能互联', _znhlExpandedWidget()),
              _buildExpandableWidget('车身颜色及内饰规格', _csysExpandedWidget()),
            ],
          ),
        ),
      ),
    );
  }

  //VE-1选择框
  Widget _buildVE1ConfigContainer() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Row(
        children: <Widget>[
          Container(
            width: 75,
            height: 40,
            color: MainAppColor.mainBlueBgColor,
            child: Center(
              child: Image.asset(
                'assets/images/car/config_detail_VE-1.png',
                width: 43,
                height: 12,
              ),
            ),
          ),
          Container(
            width: Get.width - 105,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.only(right: 10),
            height: 40,
            decoration: BoxDecoration(
              border:
                  Border.all(color: MainAppColor.mainBlueBgColor, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCheckboxRow(0, '出行版'),
                _buildCheckboxRow(1, '舒适版'),
                _buildCheckboxRow(2, '豪华版'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //VE-1S选择框
  Widget _buildVE1SConfigContainer() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        children: <Widget>[
          Container(
            width: 75,
            height: 40,
            color: MainAppColor.mainBlueBgColor,
            child: Center(
              child: Image.asset(
                'assets/images/car/config_detail_VE-1S.png',
                width: 43,
                height: 12,
              ),
            ),
          ),
          Container(
            width: Get.width - 105,
            margin: const EdgeInsets.only(left: 10),
            height: 40,
            decoration: BoxDecoration(
              border:
                  Border.all(color: MainAppColor.mainBlueBgColor, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCheckboxRow(3, '湃锐版'),
                _buildCheckboxRow(4, '湃锐豪华版'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //选择框checkbox行
  Widget _buildCheckboxRow(int index, String title) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: controller.selectTypes.contains(index),
            onChanged: (value) => controller.checkboxValueChanged(index, value),
          ),
          Expanded(
            child: AutoSizeText(
              title,
              minFontSize: 8,
              maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  //版本行
  Widget _buildVersionHeader() {
    List<Widget> children = [];
    children.add(_buildTableCellContent('版本', textColor: Colors.white));
    List<Widget> cells = [];
    cells.add(_buildTableCellContent('市场指导价(补贴后售价)'));
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      children.add(_buildTableCellContent(
          controller.convertTypeToVersionString(item),
          textColor: Colors.white));
      cells.add(
          _buildTableCellContent(controller.convertTypeToVersionPrice(item)));
    }
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            color: MainAppColor.mainBlueBgColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children,
            ),
          ),
          Table(
            border: TableBorder.all(color: MainAppColor.seperatorLineColor),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: cells,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //表格单元格
  Widget _buildTableCellContent(String content,
      {Color textColor = Colors.black}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Center(
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: 13),
        ),
      ),
    );
  }

  //展开收起视图
  Widget _buildExpandableWidget(String title, Widget child) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: false,
          ),
          header: Container(
            height: 40,
            child: Column(
              children: <Widget>[
                Container(
                  height: 39,
                  color: MainAppColor.mainBlueBgColor,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      ExpandableIcon(
                        theme: const ExpandableThemeData(
                          expandIcon: Icons.arrow_drop_down,
                          collapseIcon: Icons.arrow_drop_up,
                          iconColor: Colors.white,
                          iconSize: 30,
                          iconRotationAngle: math.pi / 2,
                          iconPadding: EdgeInsets.only(left: 5, right: 15),
                          hasIcon: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 1.0,
                ),
              ],
            ),
          ),
          collapsed: Container(),
          expanded: child,
        ),
      ),
    );
  }

  //基础参数
  Widget _jccsExpandedWidget() {
    List<Widget> ckgcells = [], //长宽高
        zjCells = [], //轴距（mm）
        ljCells = [], //前/后轮距（mm）
        ltCells = [], //轮胎规格
        lgCells = [], //轮辋尺寸
        minCells = [], //最小转弯半径（m）
        rjCells = [], //电池高精度智能控温系统
        zlCells = []; //电池防尘防水等级
    ckgcells.add(_buildTableCellContent('长x宽x高（mm）'));
    zjCells.add(_buildTableCellContent('轴距（mm）'));
    ljCells.add(_buildTableCellContent('前/后轮距（mm）'));
    ltCells.add(_buildTableCellContent('轮胎规格'));
    lgCells.add(_buildTableCellContent('轮辋尺寸'));
    minCells.add(_buildTableCellContent('最小转弯半径（m）'));
    rjCells.add(_buildTableCellContent('电池高精度智能控温系统'));
    zlCells.add(_buildTableCellContent('电池防尘防水等级'));
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      ckgcells.add(
          _buildTableCellContent(controller.convertTypeToVersionCKG(item)));
      zjCells.add(_buildTableCellContent('2610'));
      ljCells.add(_buildTableCellContent('1535/1540'));
      ltCells.add(_buildTableCellContent('215/55 R17 94V'));
      lgCells
          .add(_buildTableCellContent(controller.convertTypeToVersionLG(item)));
      minCells.add(_buildTableCellContent('5.6'));
      rjCells.add(_buildTableCellContent('437/1214'));
      zlCells
          .add(_buildTableCellContent(controller.convertTypeToVersionZL(item)));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: ckgcells,
        ),
        TableRow(
          children: zjCells,
        ),
        TableRow(
          children: ljCells,
        ),
        TableRow(
          children: ltCells,
        ),
        TableRow(
          children: lgCells,
        ),
        TableRow(
          children: minCells,
        ),
        TableRow(
          children: rjCells,
        ),
        TableRow(
          children: zlCells,
        ),
      ],
    );
  }

  //动力系统
  Widget _dlxtExpandedWidget() {
    List<Widget> djcells = [], //电机类型
        glCells = [], //电机最大功率（kW）
        njCells = [], //电机最大扭矩（N∙m）
        dclxCells = [], //电池类型
        dcrlCells = [], //电池容量（kWh）
        hdCells = [], //百公里耗电（kWh/100km）
        wkCells = [], //电池高精度智能控温系统
        fsCells = [], //电池防尘防水等级
        kcCells = [], //快速充电时间（30%~80%，min）※
        bzcdCells = [], //标准充电时间（5%~100%，h）※
        maxsdCells = [], //最高车速（km/h）
        jsCells = [], //0-50km/h加速时间（s）
        xhCells = []; //NEDC综合工况续航里程（km）
    djcells.add(_buildTableCellContent('电机类型'));
    glCells.add(_buildTableCellContent('电机最大功率（kW）'));
    njCells.add(_buildTableCellContent('电机最大扭矩（N∙m）'));
    dclxCells.add(_buildTableCellContent('电池类型'));
    dcrlCells.add(_buildTableCellContent('电池容量（kWh）'));
    hdCells.add(_buildTableCellContent('百公里耗电（kWh/100km）'));
    wkCells.add(_buildTableCellContent('电池高精度智能控温系统'));
    fsCells.add(_buildTableCellContent('电池防尘防水等级'));
    kcCells.add(_buildTableCellContent('快速充电时间（30%~80%，min）※'));
    bzcdCells.add(_buildTableCellContent('标准充电时间（5%~100%，h）※'));
    maxsdCells.add(_buildTableCellContent('最高车速（km/h）'));
    jsCells.add(_buildTableCellContent('0-50km/h加速时间（s）'));
    xhCells.add(_buildTableCellContent('NEDC综合工况续航里程（km）'));
    for (var i = 0; i < controller.selectTypes.length; i++) {
      djcells.add(_buildTableCellContent('永磁同步电机'));
      glCells.add(_buildTableCellContent('120'));
      njCells.add(_buildTableCellContent('280'));
      dclxCells.add(_buildTableCellContent('三元锂离子电池'));
      dcrlCells.add(_buildTableCellContent('61.3'));
      hdCells.add(_buildTableCellContent('≤14'));
      wkCells.add(_buildTableCellContent('液冷'));
      fsCells.add(_buildTableCellContent('IP67'));
      kcCells.add(_buildTableCellContent('约30'));
      bzcdCells.add(_buildTableCellContent('约10.5'));
      maxsdCells.add(_buildTableCellContent('140'));
      jsCells.add(_buildTableCellContent('≤4'));
      xhCells.add(_buildTableCellContent('470'));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: djcells,
        ),
        TableRow(
          children: glCells,
        ),
        TableRow(
          children: njCells,
        ),
        TableRow(
          children: dclxCells,
        ),
        TableRow(
          children: dcrlCells,
        ),
        TableRow(
          children: hdCells,
        ),
        TableRow(
          children: wkCells,
        ),
        TableRow(
          children: fsCells,
        ),
        TableRow(
          children: kcCells,
        ),
        TableRow(
          children: bzcdCells,
        ),
        TableRow(
          children: maxsdCells,
        ),
        TableRow(
          children: jsCells,
        ),
        TableRow(
          children: xhCells,
        ),
      ],
    );
  }

  //底盘系统
  Widget _dpxtExpandedWidget() {
    List<Widget> xgcells = [_buildTableCellContent('悬挂系统（前/后）')], //悬挂系统（前/后）
        zdCells = [_buildTableCellContent('制动系统（前/后）')], //制动系统（前/后）
        zxCells = [_buildTableCellContent('转向系统')]; //转向系统
    for (var i = 0; i < controller.selectTypes.length; i++) {
      xgcells.add(_buildTableCellContent('麦弗逊独立悬架/扭力梁式半独立悬架'));
      zdCells.add(_buildTableCellContent('通风盘式/盘式'));
      zxCells.add(_buildTableCellContent('EPS电子助力转向系统'));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: xgcells,
        ),
        TableRow(
          children: zdCells,
        ),
        TableRow(
          children: zxCells,
        ),
      ],
    );
  }

  //安全系统
  Widget _aqxtExpandedWidget() {
    List<Widget> firstcells = [_buildTableCellContent('电池前保护横梁')], //电池前保护横梁
        secondCells = [
          _buildTableCellContent('“H"型电池包防侧面碰撞结构')
        ], //“H"型电池包防侧面碰撞结构
        thirdCells = [_buildTableCellContent('前后保险杠防撞梁')], //前后保险杠防撞梁
        fourthCells = [_buildTableCellContent('车门内置防护梁')], //车门内置防护梁
        fiveCells = [_buildTableCellContent('ABS防抱死制动系统')], //ABS防抱死制动系统
        sixCells = [_buildTableCellContent('EBD电子制动力分配系统')], //EBD电子制动力分配系统
        sevenCells = [_buildTableCellContent('VSA车辆稳定性控制系统')], //VSA车辆稳定性控制系统
        eightCells = [_buildTableCellContent('TCS牵引力控制系统')], //TCS牵引力控制系统
        nineCells = [_buildTableCellContent('BA制动辅助系统')], //BA制动辅助系统
        tenCells = [_buildTableCellContent('BOS刹车优先系统')], //BOS刹车优先系统
        elevenCells = [_buildTableCellContent('HSA斜坡起动辅助系统')], //HSA斜坡起动辅助系统
        twiveCells = [_buildTableCellContent('EPB电子驻车制动系统')], //EPB电子驻车制动系统
        thirteenCells = [_buildTableCellContent('ABH自动驻车系统')], //ABH自动驻车系统
        fourteenCells = [_buildTableCellContent('ESS紧急刹车警示系统')], //ESS紧急刹车警示系统
        fiveteenCells = [
          _buildTableCellContent('高灵敏泊车雷达（后4探头）')
        ], //高灵敏泊车雷达（后4探头）
        sixteenCells = [
          _buildTableCellContent('豪华后视摄像显示系统(广角/标准/俯视三种模式）')
        ], //豪华后视摄像显示系统(广角/标准/俯视三种模式）
        seventeenCells = [
          _buildTableCellContent('前排i-SRS智能双安全气囊')
        ], //前排i-SRS智能双安全气囊
        eighteenCells = [
          _buildTableCellContent('前排侧安全气囊＋乘员感知装置')
        ], //前排侧安全气囊＋乘员感知装置
        nineteenCells = [_buildTableCellContent('侧安全气帘')], //侧安全气帘
        twentyCells = [
          _buildTableCellContent('前排座椅三点式ELR安全带（带预紧功能）')
        ], //前排座椅三点式ELR安全带（带预紧功能）
        twentyOneCells = [_buildTableCellContent('前排安全带未系提醒功能')], //前排安全带未系提醒功能
        twentyTwoCells = [
          _buildTableCellContent('后排座椅三点式ELR安全带')
        ], //后排座椅三点式ELR安全带
        twentyThreeCells = [_buildTableCellContent('胎压监测系统')], //胎压监测系统
        twentyFourCells = [_buildTableCellContent('儿童安全门锁')], //儿童安全门锁
        twentyFiveCells = [
          _buildTableCellContent('ISO FIX儿童安全座椅固定装置')
        ], //ISO FIX儿童安全座椅固定装置
        twentySixCells = [_buildTableCellContent('碰撞感应自动解锁')], //碰撞感应自动解锁
        twentySevenCells = [_buildTableCellContent('智能防盗启动锁止系统')], //智能防盗启动锁止系统
        twentyEightCells = [_buildTableCellContent('防盗报警系统')]; //防盗报警系统
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      firstcells.add(_buildTableCellContent('●'));
      secondCells.add(_buildTableCellContent('●'));
      thirdCells.add(_buildTableCellContent('●'));
      fourthCells.add(_buildTableCellContent('●'));
      fiveCells.add(_buildTableCellContent('●'));
      sixCells.add(_buildTableCellContent('●'));
      sevenCells.add(_buildTableCellContent('●'));
      eightCells.add(_buildTableCellContent('●'));
      nineCells.add(_buildTableCellContent('●'));
      tenCells.add(_buildTableCellContent('●'));
      elevenCells.add(_buildTableCellContent('●'));
      twiveCells.add(_buildTableCellContent('●'));
      thirteenCells.add(_buildTableCellContent('●'));
      fourteenCells.add(_buildTableCellContent('●'));
      fiveteenCells
          .add(_buildTableCellContent(controller.convertTypeToVersionLD(item)));
      sixteenCells.add(
          _buildTableCellContent(controller.convertTypeToVersionHSSXT(item)));
      seventeenCells.add(_buildTableCellContent('●'));
      eighteenCells.add(_buildTableCellContent('●'));
      nineteenCells.add(
          _buildTableCellContent(controller.convertTypeToVersionCAQQL(item)));
      twentyCells.add(_buildTableCellContent('●'));
      twentyOneCells.add(_buildTableCellContent('●'));
      twentyTwoCells.add(_buildTableCellContent('●'));
      twentyThreeCells.add(_buildTableCellContent('●'));
      twentyFourCells.add(_buildTableCellContent('●'));
      twentyFiveCells.add(_buildTableCellContent('●'));
      twentySixCells.add(_buildTableCellContent('●'));
      twentySevenCells.add(_buildTableCellContent('●'));
      twentyEightCells.add(_buildTableCellContent('●'));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: firstcells,
        ),
        TableRow(
          children: secondCells,
        ),
        TableRow(
          children: thirdCells,
        ),
        TableRow(
          children: fourthCells,
        ),
        TableRow(
          children: fiveCells,
        ),
        TableRow(
          children: sixCells,
        ),
        TableRow(
          children: sevenCells,
        ),
        TableRow(
          children: eightCells,
        ),
        TableRow(
          children: nineCells,
        ),
        TableRow(
          children: tenCells,
        ),
        TableRow(
          children: elevenCells,
        ),
        TableRow(
          children: twiveCells,
        ),
        TableRow(
          children: thirteenCells,
        ),
        TableRow(
          children: fourteenCells,
        ),
        TableRow(
          children: fiveteenCells,
        ),
        TableRow(
          children: sixteenCells,
        ),
        TableRow(
          children: seventeenCells,
        ),
        TableRow(
          children: eighteenCells,
        ),
        TableRow(
          children: nineteenCells,
        ),
        TableRow(
          children: twentyCells,
        ),
        TableRow(
          children: twentyOneCells,
        ),
        TableRow(
          children: twentyTwoCells,
        ),
        TableRow(
          children: twentyThreeCells,
        ),
        TableRow(
          children: twentyFourCells,
        ),
        TableRow(
          children: twentyFiveCells,
        ),
        TableRow(
          children: twentySixCells,
        ),
        TableRow(
          children: twentySevenCells,
        ),
        TableRow(
          children: twentyEightCells,
        ),
      ],
    );
  }

  //外观
  Widget _wgExpandedWidget() {
    return Container();
  }

  //内饰
  Widget _nsExpandedWidget() {
    return Container();
  }

  //舒适及便利配置
  Widget _ssblExpandedWidget() {
    return Container();
  }

  //智能互联
  Widget _znhlExpandedWidget() {
    return Container();
  }

  //车身颜色及内饰规格
  Widget _csysExpandedWidget() {
    return Container();
  }
}
