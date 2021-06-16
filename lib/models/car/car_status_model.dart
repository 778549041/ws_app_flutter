//EVCC返回的车辆状态数据模型
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CarStatusModel {
  String code;
  String message;
  CarStatusData datas;

  CarStatusModel({this.code = '0', this.message = ''})
      : datas = CarStatusData();

  CarStatusModel.fromJson(Map<String, dynamic> json) {
    code = asT<String>(json['code'], '0');
    message = asT<String>(json['message'], '');
    datas = CarStatusData.fromJson(
        asT<Map<String, dynamic>>(json['datas'], Map<String, dynamic>()));
  }
}

class CarStatusData {
  String engineLockStatus; //引擎锁开关 1表示开，2表示关，255无法获取
  String extendVehiclesStatus; //车辆启动状态 1：车辆启动状态；2:熄火；3：其他状态；254表示异常，255表示无效
  String doorlockRfStatus; //右前门锁 1表示开，2表示关，255无法获取
  String doorRfStatus; //右前门 1表示开，2表示关，255无法获取
  String doorlockRbStatus; //右后门锁 1表示开，2表示关，255无法获取
  String doorLfStatus; //左前门 1表示开，2表示关，255无法获取。
  String doorlockLfStatus; //左前门锁 1表示开，2表示关，255无法获取
  String doorlockLbStatus; //左后门锁 1表示开，2表示关，255无法获取
  String doorLbStatus; //左后门 1表示开，2表示关，255无法获取
  String doorRbStatus; //右后门 1表示开，2表示关，255无法获取
  String trunkStatus; //车厢开关状态 1表示开，2表示关，255无法获取。
  String carOverStatus; //前机盖状态 1表示开，2表示关，255无法获取。
  String waterPumpState; //电动水泵工作状态 1表示开，2表示关，255无法获取
  String positionLightStatus; //位置灯开关状态 1表示开，2表示关，255无法获取
  String warnningLightStatus; //告警灯开关状态 1表示开，2表示关，255无法获取
  String
      cruiseControlStatus; //巡航控制系统状态 0: ALL OFF1: MAIN SW ON2: CANCEL SW ON3: SET SW ON4: RESUME SW ON5:6: HARNESS OPEN7: HARNESS SHORT255无法获取
  String airConditionStatus; //空调开关状态 1表示开，2表示关，255无法获取
  String airConditionFan; //空调风扇状态 0 FAN0，1 FAN1，
  String airLoopStatus; //空调循环状态 1表示内循环，2表示外循环，255无法获取
  String airConditionMode; //空调模式 1关闭2吹脚+除霜；3吹脚；4吹面+吹脚；5吹面；255无法获取。
  String temperatureInCar; //车内的温度(℃)
  String airConditionTemp; //设定的温度 0：off1：Hi（无上限）2：Lo（无下限）16~31 单位：1℃
  String rangMileage; //续航里程（KM）
  String chargingStatus; //充电状态 1：停车充电；2：行驶充电；3：未充电状态；4：充电完成；254表示异常，255表示无效
  String soc1; //SOC（百分比）
  String sendingTime; //数据上传时间
  String soh;
  int airSocCreateValue; //电池SOC百分比
  int startTime; //启动倒计时,服务端会倒计时，每次返回的值会变化
  int runTime; //运行倒计时,服务端会倒计时，每次返回的值会变化
  int airTimingOpenDuration; //设置的启动倒计时时长，固定值
  int airWorkDuration; //设置的运行时长，固定值

  String carLaunchStr; //启动状态显示文本
  int allDoorStatus; //所有车门总状态，全部开启为1，全部关闭为2，其他情况为3
  String doorOpenStr; //车门开关状态显示文本
  int allLockStatus; //所有车锁总状态，全部开启为1，全部关闭为2，其他情况为3
  String lockOpenStr; //车锁开关状态显示文本
  String airOpenStr; //空调开关状态显示文本
  String warnLightStr; //警告灯开关状态显示文本
  String positionLightStr; //位置灯开关状态显示文本

  bool airOpenStatus; //空调开关状态(上面的airConditionStatus不能作为判断条件)
  String airLoopImage; //空调循环图片
  String airLoopTitle; //空调循环标题
  String airModeImage; //空调模式图片
  bool doorLockUnable; //是否门锁状态无法获取

  CarStatusData({
    this.engineLockStatus = '255',
    this.extendVehiclesStatus = '255',
    this.doorlockRfStatus = '255',
    this.doorlockRbStatus = '255',
    this.doorlockLbStatus = '255',
    this.doorlockLfStatus = '255',
    this.doorRfStatus = '255',
    this.doorLfStatus = '255',
    this.doorLbStatus = '255',
    this.doorRbStatus = '255',
    this.trunkStatus = '255',
    this.carOverStatus = '255',
    this.waterPumpState = '255',
    this.positionLightStatus = '255',
    this.warnningLightStatus = '255',
    this.cruiseControlStatus = '255',
    this.airConditionStatus = '255',
    this.airConditionFan = '255',
    this.airLoopStatus = '255',
    this.airConditionMode = '255',
    this.temperatureInCar = '- - ℃',
    this.airConditionTemp = '',
    this.rangMileage = '0',
    this.chargingStatus = '255',
    this.soc1 = '0',
    this.sendingTime = '0',
    this.soh = '0',
    this.airSocCreateValue = 0,
    this.startTime = 0,
    this.runTime = 0,
    this.airTimingOpenDuration = 0,
    this.airWorkDuration = 0,
    this.carLaunchStr = '获取中',
    this.allDoorStatus = 2,
    this.doorOpenStr = '获取中',
    this.allLockStatus = 2,
    this.lockOpenStr = '获取中',
    this.airOpenStr = '获取中',
    this.warnLightStr = '获取中',
    this.positionLightStr = '获取中',
    this.airOpenStatus = false,
    this.airLoopImage = '',
    this.airLoopTitle = '',
    this.airModeImage = '',
    this.doorLockUnable = true,
  });

  CarStatusData.fromJson(Map<String, dynamic> json) {
    engineLockStatus = asT<String>(json['engine_lock_status'], '255');
    extendVehiclesStatus = asT<String>(json['extend_vehicles_status'], '255');
    doorlockRfStatus = asT<String>(json['doorlock_rf_status'], '255');
    doorlockRbStatus = asT<String>(json['doorlock_rb_status'], '255');
    doorlockLfStatus = asT<String>(json['doorlock_lf_status'], '255');
    doorlockLbStatus = asT<String>(json['doorlock_lb_status'], '255');
    doorRfStatus = asT<String>(json['door_rf_status'], '255');
    doorLfStatus = asT<String>(json['door_lf_status'], '255');
    doorLbStatus = asT<String>(json['door_lb_status'], '255');
    doorRbStatus = asT<String>(json['door_rb_status'], '255');
    trunkStatus = asT<String>(json['trunk_status'], '255');
    carOverStatus = asT<String>(json['car_over_status'], '255');
    waterPumpState = asT<String>(json['water_pump_state'], '255');
    positionLightStatus = asT<String>(json['position_light_status'], '255');
    warnningLightStatus = asT<String>(json['warnning_light_status'], '255');
    cruiseControlStatus = asT<String>(json['cruise_control_status'], '255');
    airConditionStatus = asT<String>(json['air_condition_status'], '255');
    airConditionFan = asT<String>(json['air_condition_fan'], '255');
    airLoopStatus = asT<String>(json['air_loop_status'], '255');
    airConditionMode = asT<String>(json['air_condition_mode'], '255');
    temperatureInCar = asT<String>(json['temperature_in_car'], '- - ℃');
    airConditionTemp = asT<String>(json['air_condition_temp'], '');
    rangMileage = asT<String>(json['rang_mileage'], '470');
    chargingStatus = asT<String>(json['charging_status']);
    soc1 = asT<String>(json['soc1'], '100');
    sendingTime = asT<String>(json['sendingTime'], '0');
    soh = asT<String>(json['SOH'], '100');
    airSocCreateValue = asT<int>(json['airSocCreateValue'], 0);
    startTime = asT<int>(json['startTime'], 0);
    runTime = asT<int>(json['runTime'], 0);
    airTimingOpenDuration = asT<int>(json['airTimingOpenDuration'], 0);
    airWorkDuration = asT<int>(json['airWorkDuration'], 0);
    //车辆启动状态
    if (extendVehiclesStatus == '1') {
      carLaunchStr = '启动';
    } else if (extendVehiclesStatus == '2') {
      carLaunchStr = '熄火';
    } else if (extendVehiclesStatus == '3') {
      carLaunchStr = '其他';
    } else if (extendVehiclesStatus == '254') {
      carLaunchStr = '异常';
    } else {
      carLaunchStr = '获取中';
    }
    //所有车门开关状态
    if (doorLbStatus == '2' &&
        doorLfStatus == '2' &&
        doorRbStatus == '2' &&
        doorRfStatus == '2' &&
        trunkStatus == '2' &&
        carOverStatus == '2') {
      allDoorStatus = 2;
      doorOpenStr = '车门关';
    } else if (doorLbStatus == '1' &&
        doorLfStatus == '1' &&
        doorRbStatus == '1' &&
        doorRfStatus == '1' &&
        trunkStatus == '1' &&
        carOverStatus == '1') {
      allDoorStatus = 1;
      doorOpenStr = '车门开';
    } else {
      allDoorStatus = 3;
      doorOpenStr = '车门开';
    }
    //所有车锁状态
    if (doorlockLbStatus == '2' &&
        doorlockLfStatus == '2' &&
        doorlockRfStatus == '2' &&
        doorlockRfStatus == '2') {
      allLockStatus = 2;
      lockOpenStr = '车锁关';
    } else if (doorlockLbStatus == '1' &&
        doorlockLfStatus == '1' &&
        doorlockRfStatus == '1' &&
        doorlockRfStatus == '1') {
      allLockStatus = 1;
      lockOpenStr = '车锁开';
    } else {
      allLockStatus = 3;
      lockOpenStr = '车锁开';
    }
    //门锁状态是否无法获取，任意状态为255则表示无法获取
    if (doorLbStatus == '255' ||
        doorLfStatus == '255' ||
        doorRbStatus == '255' ||
        doorRfStatus == '255' ||
        trunkStatus == '255' ||
        carOverStatus == '255' ||
        doorlockLbStatus == '255' ||
        doorlockLfStatus == '255' ||
        doorlockRfStatus == '255' ||
        doorlockRfStatus == '255') {
      doorLockUnable = true;
    } else {
      doorLockUnable = false;
    }
    //空调开关状态文案
    if (airConditionFan == '1' ||
        airConditionFan == '2' ||
        airConditionFan == '3' ||
        airConditionFan == '4' ||
        airConditionFan == '5' ||
        airConditionFan == '6' ||
        airConditionFan == '7') {
      airOpenStatus = true;
      airOpenStr = '空调运行中';
    } else if (airConditionFan == '0' || airConditionFan == '8') {
      airOpenStatus = false;
      if (startTime > 0) {
        airOpenStr = '定时启动功能已开启';
      } else {
        airOpenStr = '空调已关闭';
      }
    } else {
      airOpenStatus = false;
      airOpenStr = '远程空调不可设定';
    }
    //告警灯
    if (warnningLightStatus == '1') {
      warnLightStr = '警告灯开';
    } else if (warnningLightStatus == '2') {
      warnLightStr = '警告灯关';
    } else {
      warnLightStr = '获取中';
    }
    //位置灯
    if (positionLightStatus == '1') {
      positionLightStr = '位置灯开';
    } else if (positionLightStatus == '2') {
      positionLightStr = '位置灯关';
    } else {
      positionLightStr = '获取中';
    }
    //空调循环图片
    if (airLoopStatus == '1') {
      airLoopImage = 'assets/images/chekong/air_cycle_icon.png';
      airLoopTitle = '内循环';
    } else if (airLoopStatus == '2') {
      airLoopImage = 'assets/images/chekong/air_cycle_out.png';
      airLoopTitle = '外循环';
    } else {
      airLoopImage = 'assets/images/chekong/air_cycle_out.png';
      airLoopTitle = '获取中';
    }
    //空调模式图片
    if (airConditionMode == '2') {
      airModeImage = 'assets/images/chekong/air_blow_foot_defrost.png';
    } else if (airConditionMode == '3') {
      airModeImage = 'assets/images/chekong/air_blow_foot.png';
    } else if (airConditionMode == '4') {
      airModeImage = 'assets/images/chekong/air_blow_face_foot.png';
    } else if (airConditionMode == '5') {
      airModeImage = 'assets/images/chekong/air_blow_face.png';
    } else {
      airModeImage = 'assets/images/chekong/air_blow_face.png';
    }
  }
}
