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
      child: Obx(
        () => Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Image.asset(
              'assets/images/car/config_detail_title.png',
              width: 113,
              height: 47,
            ),
            _buildVE1ConfigContainer(),
            _buildVE1SConfigContainer(),
            _buildVersionHeader(),
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildExpandableWidget('基础参数', _jccsExpandedWidget()),
                      _buildExpandableWidget('动力系统', _dlxtExpandedWidget()),
                      _buildExpandableWidget('底盘系统', _dpxtExpandedWidget()),
                      _buildExpandableWidget('安全系统', _aqxtExpandedWidget()),
                      _buildExpandableWidget('外观', _wgExpandedWidget()),
                      _buildExpandableWidget('内饰', _nsExpandedWidget()),
                      _buildExpandableWidget('舒适及便利配置', _ssblExpandedWidget()),
                      _buildExpandableWidget('智能互联', _znhlExpandedWidget()),
                      _buildExpandableWidget(
                          '车身颜色及内饰规格', _csysExpandedWidget()),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
    List<Widget> cells1 = [], //长宽高
        cells2 = [], //轴距（mm）
        cells3 = [], //前/后轮距（mm）
        cells4 = [], //轮胎规格
        cells5 = [], //轮辋尺寸
        cells6 = [], //最小转弯半径（m）
        cells7 = [], //电池高精度智能控温系统
        cells8 = []; //电池防尘防水等级
    cells1.add(_buildTableCellContent('长x宽x高（mm）'));
    cells2.add(_buildTableCellContent('轴距（mm）'));
    cells3.add(_buildTableCellContent('前/后轮距（mm）'));
    cells4.add(_buildTableCellContent('轮胎规格'));
    cells5.add(_buildTableCellContent('轮辋尺寸'));
    cells6.add(_buildTableCellContent('最小转弯半径（m）'));
    cells7.add(_buildTableCellContent('电池高精度智能控温系统'));
    cells8.add(_buildTableCellContent('电池防尘防水等级'));
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      cells1.add(
          _buildTableCellContent(controller.convertTypeToVersionCKG(item)));
      cells2.add(_buildTableCellContent('2610'));
      cells3.add(_buildTableCellContent('1535/1540'));
      cells4.add(_buildTableCellContent('215/55 R17 94V'));
      cells5
          .add(_buildTableCellContent(controller.convertTypeToVersionLG(item)));
      cells6.add(_buildTableCellContent('5.6'));
      cells7.add(_buildTableCellContent('437/1214'));
      cells8
          .add(_buildTableCellContent(controller.convertTypeToVersionZL(item)));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
        TableRow(
          children: cells4,
        ),
        TableRow(
          children: cells5,
        ),
        TableRow(
          children: cells6,
        ),
        TableRow(
          children: cells7,
        ),
        TableRow(
          children: cells8,
        ),
      ],
    );
  }

  //动力系统
  Widget _dlxtExpandedWidget() {
    List<Widget> cells1 = [], //电机类型
        cells2 = [], //电机最大功率（kW）
        cells3 = [], //电机最大扭矩（N∙m）
        cells4 = [], //电池类型
        cells5 = [], //电池容量（kWh）
        cells6 = [], //百公里耗电（kWh/100km）
        cells7 = [], //电池高精度智能控温系统
        cells8 = [], //电池防尘防水等级
        cells9 = [], //快速充电时间（30%~80%，min）※
        cells10 = [], //标准充电时间（5%~100%，h）※
        cells11 = [], //最高车速（km/h）
        cells12 = [], //0-50km/h加速时间（s）
        cells13 = []; //NEDC综合工况续航里程（km）
    cells1.add(_buildTableCellContent('电机类型'));
    cells2.add(_buildTableCellContent('电机最大功率（kW）'));
    cells3.add(_buildTableCellContent('电机最大扭矩（N∙m）'));
    cells4.add(_buildTableCellContent('电池类型'));
    cells5.add(_buildTableCellContent('电池容量（kWh）'));
    cells6.add(_buildTableCellContent('百公里耗电（kWh/100km）'));
    cells7.add(_buildTableCellContent('电池高精度智能控温系统'));
    cells8.add(_buildTableCellContent('电池防尘防水等级'));
    cells9.add(_buildTableCellContent('快速充电时间（30%~80%，min）※'));
    cells10.add(_buildTableCellContent('标准充电时间（5%~100%，h）※'));
    cells11.add(_buildTableCellContent('最高车速（km/h）'));
    cells12.add(_buildTableCellContent('0-50km/h加速时间（s）'));
    cells13.add(_buildTableCellContent('NEDC综合工况续航里程（km）'));
    for (var i = 0; i < controller.selectTypes.length; i++) {
      cells1.add(_buildTableCellContent('永磁同步电机'));
      cells2.add(_buildTableCellContent('120'));
      cells3.add(_buildTableCellContent('280'));
      cells4.add(_buildTableCellContent('三元锂离子电池'));
      cells5.add(_buildTableCellContent('61.3'));
      cells6.add(_buildTableCellContent('≤14'));
      cells7.add(_buildTableCellContent('液冷'));
      cells8.add(_buildTableCellContent('IP67'));
      cells9.add(_buildTableCellContent('约30'));
      cells10.add(_buildTableCellContent('约10.5'));
      cells11.add(_buildTableCellContent('140'));
      cells12.add(_buildTableCellContent('≤4'));
      cells13.add(_buildTableCellContent('470'));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
        TableRow(
          children: cells4,
        ),
        TableRow(
          children: cells5,
        ),
        TableRow(
          children: cells6,
        ),
        TableRow(
          children: cells7,
        ),
        TableRow(
          children: cells8,
        ),
        TableRow(
          children: cells9,
        ),
        TableRow(
          children: cells10,
        ),
        TableRow(
          children: cells11,
        ),
        TableRow(
          children: cells12,
        ),
        TableRow(
          children: cells13,
        ),
      ],
    );
  }

  //底盘系统
  Widget _dpxtExpandedWidget() {
    List<Widget> cells1 = [_buildTableCellContent('悬挂系统（前/后）')], //悬挂系统（前/后）
        cells2 = [_buildTableCellContent('制动系统（前/后）')], //制动系统（前/后）
        cells3 = [_buildTableCellContent('转向系统')]; //转向系统
    for (var i = 0; i < controller.selectTypes.length; i++) {
      cells1.add(_buildTableCellContent('麦弗逊独立悬架/扭力梁式半独立悬架'));
      cells2.add(_buildTableCellContent('通风盘式/盘式'));
      cells3.add(_buildTableCellContent('EPS电子助力转向系统'));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
      ],
    );
  }

  //安全系统
  Widget _aqxtExpandedWidget() {
    List<Widget> cells1 = [_buildTableCellContent('电池前保护横梁')], //电池前保护横梁
        cells2 = [_buildTableCellContent('“H"型电池包防侧面碰撞结构')], //“H"型电池包防侧面碰撞结构
        cells3 = [_buildTableCellContent('前后保险杠防撞梁')], //前后保险杠防撞梁
        cells4 = [_buildTableCellContent('车门内置防护梁')], //车门内置防护梁
        cells5 = [_buildTableCellContent('ABS防抱死制动系统')], //ABS防抱死制动系统
        cells6 = [_buildTableCellContent('EBD电子制动力分配系统')], //EBD电子制动力分配系统
        cells7 = [_buildTableCellContent('VSA车辆稳定性控制系统')], //VSA车辆稳定性控制系统
        cells8 = [_buildTableCellContent('TCS牵引力控制系统')], //TCS牵引力控制系统
        cells9 = [_buildTableCellContent('BA制动辅助系统')], //BA制动辅助系统
        cells10 = [_buildTableCellContent('BOS刹车优先系统')], //BOS刹车优先系统
        cells11 = [_buildTableCellContent('HSA斜坡起动辅助系统')], //HSA斜坡起动辅助系统
        cells12 = [_buildTableCellContent('EPB电子驻车制动系统')], //EPB电子驻车制动系统
        cells13 = [_buildTableCellContent('ABH自动驻车系统')], //ABH自动驻车系统
        cells14 = [_buildTableCellContent('ESS紧急刹车警示系统')], //ESS紧急刹车警示系统
        cells15 = [_buildTableCellContent('高灵敏泊车雷达（后4探头）')], //高灵敏泊车雷达（后4探头）
        cells16 = [
          _buildTableCellContent('豪华后视摄像显示系统(广角/标准/俯视三种模式）')
        ], //豪华后视摄像显示系统(广角/标准/俯视三种模式）
        cells17 = [_buildTableCellContent('前排i-SRS智能双安全气囊')], //前排i-SRS智能双安全气囊
        cells18 = [_buildTableCellContent('前排侧安全气囊＋乘员感知装置')], //前排侧安全气囊＋乘员感知装置
        cells19 = [_buildTableCellContent('侧安全气帘')], //侧安全气帘
        cells20 = [
          _buildTableCellContent('前排座椅三点式ELR安全带（带预紧功能）')
        ], //前排座椅三点式ELR安全带（带预紧功能）
        cells21 = [_buildTableCellContent('前排安全带未系提醒功能')], //前排安全带未系提醒功能
        cells22 = [_buildTableCellContent('后排座椅三点式ELR安全带')], //后排座椅三点式ELR安全带
        cells23 = [_buildTableCellContent('胎压监测系统')], //胎压监测系统
        cells24 = [_buildTableCellContent('儿童安全门锁')], //儿童安全门锁
        cells25 = [
          _buildTableCellContent('ISO FIX儿童安全座椅固定装置')
        ], //ISO FIX儿童安全座椅固定装置
        cells26 = [_buildTableCellContent('碰撞感应自动解锁')], //碰撞感应自动解锁
        cells27 = [_buildTableCellContent('智能防盗启动锁止系统')], //智能防盗启动锁止系统
        cells28 = [_buildTableCellContent('防盗报警系统')]; //防盗报警系统
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      cells1.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells2.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells3.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells4.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells5.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells6.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells7.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells8.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells9.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells10.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells11.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells12.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells13.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells14.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells15.add(
          _buildTableCellContent(controller.convertTypeToVersionLDAndQL(item)));
      cells16.add(
          _buildTableCellContent(controller.convertTypeToVersionHSSXT(item)));
      cells17.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells18.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells19.add(
          _buildTableCellContent(controller.convertTypeToVersionLDAndQL(item)));
      cells20.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells21.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells22.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells23.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells24.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells25.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells26.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells27.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells28.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
        TableRow(
          children: cells4,
        ),
        TableRow(
          children: cells5,
        ),
        TableRow(
          children: cells6,
        ),
        TableRow(
          children: cells7,
        ),
        TableRow(
          children: cells8,
        ),
        TableRow(
          children: cells9,
        ),
        TableRow(
          children: cells10,
        ),
        TableRow(
          children: cells11,
        ),
        TableRow(
          children: cells12,
        ),
        TableRow(
          children: cells13,
        ),
        TableRow(
          children: cells14,
        ),
        TableRow(
          children: cells15,
        ),
        TableRow(
          children: cells16,
        ),
        TableRow(
          children: cells17,
        ),
        TableRow(
          children: cells18,
        ),
        TableRow(
          children: cells19,
        ),
        TableRow(
          children: cells20,
        ),
        TableRow(
          children: cells21,
        ),
        TableRow(
          children: cells22,
        ),
        TableRow(
          children: cells23,
        ),
        TableRow(
          children: cells24,
        ),
        TableRow(
          children: cells25,
        ),
        TableRow(
          children: cells26,
        ),
        TableRow(
          children: cells27,
        ),
        TableRow(
          children: cells28,
        ),
      ],
    );
  }

  //外观
  Widget _wgExpandedWidget() {
    List<Widget> cells1 = [
          _buildTableCellContent('羽翼式全LED前大灯（高度可调）')
        ], //羽翼式全LED前大灯（高度可调）
        cells2 = [_buildTableCellContent('晶钻式LED前大灯（高度可调）')], //晶钻式LED前大灯（高度可调）
        cells3 = [_buildTableCellContent('反射式前大灯（高度可调）')], //反射式前大灯（高度可调）
        cells4 = [_buildTableCellContent('LED日间行车灯')], //LED日间行车灯
        cells5 = [_buildTableCellContent('自动前大灯')], //自动前大灯
        cells6 = [_buildTableCellContent('前大灯自动延时熄灭（锁车后）')], //前大灯自动延时熄灭（锁车后）
        cells7 = [_buildTableCellContent('电动调节外后视镜')], //电动调节外后视镜
        cells8 = [_buildTableCellContent('电动折叠外后视镜')], //电动折叠外后视镜
        cells9 = [_buildTableCellContent('外后视镜带转向灯')], //外后视镜带转向灯
        cells10 = [_buildTableCellContent('外后视镜加热功能')], //外后视镜加热功能
        cells11 = [_buildTableCellContent('豪华全景电动天窗')], //豪华全景电动天窗
        cells12 = [_buildTableCellContent('全车电动车窗')], //全车电动车窗
        cells13 = [_buildTableCellContent('驾驶席车窗一键式自动升降')], //驾驶席车窗一键式自动升降
        cells14 = [_buildTableCellContent('全车绿色隔热玻璃（除天窗）')], //全车绿色隔热玻璃（除天窗）
        cells15 = [_buildTableCellContent('多级式前挡风玻璃雨刮器')], //多级式前挡风玻璃雨刮器
        cells16 = [
          _buildTableCellContent('后挡风玻璃雨刮器（带清洗功能、倒车联动）')
        ], //后挡风玻璃雨刮器（带清洗功能、倒车联动）
        cells17 = [_buildTableCellContent('后雾灯')], //后雾灯
        cells18 = [_buildTableCellContent('行车示廓灯')], //行车示廓灯
        cells19 = [_buildTableCellContent('LED组合光导尾灯')], //LED组合光导尾灯
        cells20 = [_buildTableCellContent('LED高位刹车灯')], //LED高位刹车灯
        cells21 = [_buildTableCellContent('湃锐专属运动包围')], //湃锐专属运动包围
        cells22 = [_buildTableCellContent('蜂巢式动感前格栅')], //蜂巢式动感前格栅
        cells23 = [_buildTableCellContent('SPORT运动徽标（尾门）')]; //SPORT运动徽标（尾门）
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      cells1.add(
          _buildTableCellContent(controller.convertTypeToVersionWG1NS2(item)));
      cells2.add(
          _buildTableCellContent(controller.convertTypeToVersionWG2(item)));
      cells3.add(
          _buildTableCellContent(controller.convertTypeToVersionWG3NS13(item)));
      cells4.add(
          _buildTableCellContent(controller.convertTypeToVersionWG4WG5(item)));
      cells5.add(
          _buildTableCellContent(controller.convertTypeToVersionWG4WG5(item)));
      cells6.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells7.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells8.add(
          _buildTableCellContent(controller.convertTypeToVersionWG8910(item)));
      cells9.add(
          _buildTableCellContent(controller.convertTypeToVersionWG8910(item)));
      cells10.add(
          _buildTableCellContent(controller.convertTypeToVersionWG8910(item)));
      cells11.add(_buildTableCellContent(
          controller.convertTypeToVersionWG11NS16(item)));
      cells12.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells13.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells14.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells15.add(
          _buildTableCellContent(controller.convertTypeToVersionWG15(item)));
      cells16.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells17.add(
          _buildTableCellContent(controller.convertTypeToVersionWG17(item)));
      cells18.add(
          _buildTableCellContent(controller.convertTypeToVersionWG18(item)));
      cells19.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells20.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells21.add(_buildTableCellContent(
          controller.convertTypeToVersionWG212223(item)));
      cells22.add(_buildTableCellContent(
          controller.convertTypeToVersionWG212223(item)));
      cells23.add(_buildTableCellContent(
          controller.convertTypeToVersionWG212223(item)));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
        TableRow(
          children: cells4,
        ),
        TableRow(
          children: cells5,
        ),
        TableRow(
          children: cells6,
        ),
        TableRow(
          children: cells7,
        ),
        TableRow(
          children: cells8,
        ),
        TableRow(
          children: cells9,
        ),
        TableRow(
          children: cells10,
        ),
        TableRow(
          children: cells11,
        ),
        TableRow(
          children: cells12,
        ),
        TableRow(
          children: cells13,
        ),
        TableRow(
          children: cells14,
        ),
        TableRow(
          children: cells15,
        ),
        TableRow(
          children: cells16,
        ),
        TableRow(
          children: cells17,
        ),
        TableRow(
          children: cells18,
        ),
        TableRow(
          children: cells19,
        ),
        TableRow(
          children: cells20,
        ),
        TableRow(
          children: cells21,
        ),
        TableRow(
          children: cells22,
        ),
        TableRow(
          children: cells23,
        ),
      ],
    );
  }

  //内饰
  Widget _nsExpandedWidget() {
    List<Widget> cells1 = [
          _buildTableCellContent('澄净蓝色氛围内饰（蓝色缝线+饰件）')
        ], //澄净蓝色氛围内饰（蓝色缝线+饰件）
        cells2 = [
          _buildTableCellContent('湃锐专属运动内饰（红色缝线+饰件）')
        ], //湃锐专属运动内饰（红色缝线+饰件）
        cells3 = [_buildTableCellContent('SBW按键式电子换挡')], //SBW按键式电子换挡
        cells4 = [_buildTableCellContent('触控式中央控制台')], //触控式中央控制台
        cells5 = [_buildTableCellContent('多功能自发光式仪表')], //多功能自发光式仪表
        cells6 = [_buildTableCellContent('彩色TFT多功能信息显示屏')], //彩色TFT多功能信息显示屏
        cells7 = [
          _buildTableCellContent('多功能方向盘（带音响控制及4向调节）')
        ], //多功能方向盘（带音响控制及4向调节）
        cells8 = [_buildTableCellContent('防眩目内后视镜')], //防眩目内后视镜
        cells9 = [_buildTableCellContent('前排遮阳板（带化妆镜）')], //前排遮阳板（带化妆镜）
        cells10 = [_buildTableCellContent('车内照明系统')], //车内照明系统
        cells11 = [_buildTableCellContent('LED中央扶手照明')], //LED中央扶手照明
        cells12 = [_buildTableCellContent('高级皮质座椅')], //高级皮质座椅
        cells13 = [_buildTableCellContent('高级织物座椅')], //高级织物座椅
        cells14 = [_buildTableCellContent('驾驶席6向手动调节')], //驾驶席6向手动调节
        cells15 = [_buildTableCellContent('副驾驶席4向手动调节')], //副驾驶席4向手动调节
        cells16 = [_buildTableCellContent('前排座椅地图袋')], //前排座椅地图袋
        cells17 = [_buildTableCellContent('前排阅读灯')], //前排阅读灯
        cells18 = [_buildTableCellContent('后排座椅中央扶手')], //后排座椅中央扶手
        cells19 = [
          _buildTableCellContent('可折叠式后排座椅（4/6分割式）')
        ], //可折叠式后排座椅（4/6分割式）
        cells20 = [_buildTableCellContent('后排座椅三安全头枕')], //后排座椅三安全头枕
        cells21 = [_buildTableCellContent('行李厢LED照明灯')]; //行李厢LED照明灯
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      cells1.add(
          _buildTableCellContent(controller.convertTypeToVersionNS1(item)));
      cells2.add(
          _buildTableCellContent(controller.convertTypeToVersionWG1NS2(item)));
      cells3.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells4.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells5.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells6.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells7.add(
          _buildTableCellContent(controller.convertTypeToVersionNS7(item)));
      cells8.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells9.add(
          _buildTableCellContent(controller.convertTypeToVersionNS9(item)));
      cells10.add(
          _buildTableCellContent(controller.convertTypeToVersionNS10(item)));
      cells11.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells12.add(
          _buildTableCellContent(controller.convertTypeToVersionNS12(item)));
      cells13.add(
          _buildTableCellContent(controller.convertTypeToVersionWG3NS13(item)));
      cells14.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells15.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells16.add(_buildTableCellContent(
          controller.convertTypeToVersionWG11NS16(item)));
      cells17.add(
          _buildTableCellContent(controller.convertTypeToVersionNS17(item)));
      cells18.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells19.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells20.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells21.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
        TableRow(
          children: cells4,
        ),
        TableRow(
          children: cells5,
        ),
        TableRow(
          children: cells6,
        ),
        TableRow(
          children: cells7,
        ),
        TableRow(
          children: cells8,
        ),
        TableRow(
          children: cells9,
        ),
        TableRow(
          children: cells10,
        ),
        TableRow(
          children: cells11,
        ),
        TableRow(
          children: cells12,
        ),
        TableRow(
          children: cells13,
        ),
        TableRow(
          children: cells14,
        ),
        TableRow(
          children: cells15,
        ),
        TableRow(
          children: cells16,
        ),
        TableRow(
          children: cells17,
        ),
        TableRow(
          children: cells18,
        ),
        TableRow(
          children: cells19,
        ),
        TableRow(
          children: cells20,
        ),
        TableRow(
          children: cells21,
        ),
      ],
    );
  }

  //舒适及便利配置
  Widget _ssblExpandedWidget() {
    List<Widget> cells1 = [
          _buildTableCellContent('N（舒适）/S（运动）/B （强能量回收） 自由切换驾驶模式')
        ], //N（舒适）/S（运动）/B （强能量回收） 自由切换驾驶模式
        cells2 = [_buildTableCellContent('定速巡航系统')], //定速巡航系统
        cells3 = [
          _buildTableCellContent('国家标准快慢充接口（带LED照明）')
        ], //国家标准快慢充接口（带LED照明）
        cells4 = [_buildTableCellContent('充电状态显示灯')], //充电状态显示灯
        cells5 = [
          _buildTableCellContent('Smart Entry智能无钥匙进入系统')
        ], //Smart Entry智能无钥匙进入系统
        cells6 = [_buildTableCellContent('一键式启动系统')], //一键式启动系统
        cells7 = [_buildTableCellContent('中央控制门锁')], //中央控制门锁
        cells8 = [_buildTableCellContent('数字化触控式自动空调')], //数字化触控式自动空调
        cells9 = [_buildTableCellContent('高效PM2.5空气净化系统')], //高效PM2.5空气净化系统
        cells10 = [_buildTableCellContent('高保真扬声器系统')], //高保真扬声器系统
        cells11 = [
          _buildTableCellContent('USB和iPod多源输入音响系统')
        ], //USB和iPod多源输入音响系统
        cells12 = [
          _buildTableCellContent('四USB接口（前排2个、后排2个）')
        ], //四USB接口（前排2个、后排2个）
        cells13 = [_buildTableCellContent('12V电源接口（前排、行李厢）')], //12V电源接口（前排、行李厢）
        cells14 = [_buildTableCellContent('SVC音量与车速联动系统')]; //SVC音量与车速联动系统
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      cells1.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells2.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells3.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells4.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells5.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells6.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells7.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells8.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells9.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells10.add(
          _buildTableCellContent(controller.convertTypeToVersionSSBL10(item)));
      cells11.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells12.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells13.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells14.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
        TableRow(
          children: cells4,
        ),
        TableRow(
          children: cells5,
        ),
        TableRow(
          children: cells6,
        ),
        TableRow(
          children: cells7,
        ),
        TableRow(
          children: cells8,
        ),
        TableRow(
          children: cells9,
        ),
        TableRow(
          children: cells10,
        ),
        TableRow(
          children: cells11,
        ),
        TableRow(
          children: cells12,
        ),
        TableRow(
          children: cells13,
        ),
        TableRow(
          children: cells14,
        ),
      ],
    );
  }

  //智能互联
  Widget _znhlExpandedWidget() {
    List<Widget> cells1 = [_buildTableCellContent('8英寸彩色智能触控屏')], //8英寸彩色智能触控屏
        cells2 = [
          _buildTableCellContent('车载Carlife智能互联（通讯、音乐等）')
        ], //车载Carlife智能互联（通讯、音乐等）
        cells3 = [_buildTableCellContent('车载全时导航系统')], //车载全时导航系统
        cells4 = [_buildTableCellContent('远程实时安全监测')], //远程实时安全监测
        cells5 = [_buildTableCellContent('充电桩智能查询')], //充电桩智能查询
        cells6 = [_buildTableCellContent('车载蓝牙系统')]; //车载蓝牙系统
    for (var i = 0; i < controller.selectTypes.length; i++) {
      int item = controller.selectTypes[i];
      cells1.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells2.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells3.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells4.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells5.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
      cells6.add(_buildTableCellContent(
          controller.convertTypeToVersionCommonYuan(item)));
    }
    return Table(
      border: TableBorder.all(color: MainAppColor.seperatorLineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: cells1,
        ),
        TableRow(
          children: cells2,
        ),
        TableRow(
          children: cells3,
        ),
        TableRow(
          children: cells4,
        ),
        TableRow(
          children: cells5,
        ),
        TableRow(
          children: cells6,
        ),
      ],
    );
  }

  //车身颜色及内饰规格
  Widget _csysExpandedWidget() {
    return Image.asset('assets/images/car/config_detail_color.jpg');
  }
}
