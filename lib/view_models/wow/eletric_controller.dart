import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/car/car_status_model.dart';
import 'package:ws_app_flutter/models/car/control_cmd_model.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class EletricController extends BaseController {
  TimerUtil _statusTimer;
  TimerUtil _cmdResultTimer;
  var carDataModel = CarDataModel().obs; //电量信息数据
  var carStatusModel = CarStatusModel().obs; //车辆状态数据
  var cmdResultModel = ControlCmdModel().obs; //指令状态结果
  var charging = true.obs; //充电状态
  var progressValue = 0.0.obs; //当前电量百分比
  String _vin;

  @override
  void onInit() {
    _vin = Get.find<UserController>().userInfo.value.member.fVIN;
    super.onInit();
  }

  @override
  void onReady() {
    addAllTimer();
    super.onReady();
  }

  //添加（重置）所有定时器
  void addAllTimer() {
    if (Get.find<UserController>().userInfo.value.member.isVehicle == 'true') {
      //如果是车主才请求电量信息数据和车辆状态数据
      addStatusTimer();
    }

    if (Get.find<UserController>()
            .userInfo
            .value
            .member
            .memberInfo
            .vehicleControlBind ==
        1) {
      //如果已经绑定车控车辆（绑定必有车控功能），才查询车控指令状态
      addCmdResultTimer();
    }
  }

  //添加(重置)车辆状态数据查询定时器
  void addStatusTimer() {
    //电量信息，车辆状态
    _statusTimer = TimerUtil(mInterval: 60 * 1000);
    _statusTimer.setOnTimerTickCallback((millisUntilFinished) {
      // requestElectricityData();
      requestCarStatusData();
    });
    _statusTimer.startTimer();
  }

  //添加(重置)指令结果查询定时器
  void addCmdResultTimer() {
    //指令结果
    _cmdResultTimer = TimerUtil(mInterval: 5 * 1000);
    _cmdResultTimer.setOnTimerTickCallback((millisUntilFinished) {
      requestCmdResult();
    });
    _cmdResultTimer.startTimer();
  }

  //取消所有定时器
  void cancelAllTimer() {
    cancelStatusTimer();
    cancelCmdResultTimer();
  }

  //取消车辆状态数据查询定时器
  void cancelStatusTimer() {
    if (_statusTimer != null) {
      _statusTimer.cancel();
      _statusTimer = null;
    }
  }

  //取消指令结果查询定时器
  void cancelCmdResultTimer() {
    if (_cmdResultTimer != null) {
      _cmdResultTimer.cancel();
      _cmdResultTimer = null;
    }
  }

  //电量信息查询
  void requestElectricityData() async {
    carDataModel.value = await DioManager().request<CarDataModel>(
        DioManager.POST, Api.vechileEleDataUrl,
        queryParamters: {
          "member_id": Get.find<UserController>()
              .userInfo
              .value
              .member
              .memberInfo
              .memberIdStr
        });
    if (carDataModel.value.datas.rspBody.chargingStatus == 1 ||
        carDataModel.value.datas.rspBody.chargingStatus == 2) {
      charging.value = true;
    } else {
      charging.value = false;
    }
    progressValue.value = carDataModel.value.datas.rspBody.soc / 100;
  }

  //车辆状态查询
  void requestCarStatusData() async {
    carStatusModel.value = await DioManager().request<CarStatusModel>(
        DioManager.POST, 'wsapp/vehicle/getVehicleAllStatus',
        params: {'carVin': _vin});
  }

  //指令结果查询
  void requestCmdResult() async {
    cmdResultModel.value = await DioManager().request<ControlCmdModel>(
        DioManager.POST, 'wsapp/vehicle/getCommandStateVal',
        params: {'carVin': _vin});
  }
}
