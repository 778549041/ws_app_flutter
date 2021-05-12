import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/car/car_status_model.dart';
import 'package:ws_app_flutter/models/car/control_cmd_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class EletricController extends BaseController {
  TimerUtil _statusTimer;
  TimerUtil _cmdResultTimer;
  String _vin;
  var carDataModel = CarDataModel().obs; //电量信息数据
  var carStatusModel = CarStatusModel().obs; //车辆状态数据
  var charging = true.obs; //充电状态
  var progressValue = 0.0.obs; //当前电量百分比
  var currentCmdTitle = ''.obs; //当前指令名称
  var currentCmdType = 0.obs; //当前指令类型
  var currentCmdStatus = 0.obs; //当前指令状态
  var openLock = true.obs; //是否是开锁
  var disabledLock = false.obs; //是否禁用开落锁按钮
  var showLoadingView = false.obs; //是否展示指令弹框

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
    if (carStatusModel.value.datas.chargingStatus == '1') {
      charging.value = true;
    } else {
      charging.value = false;
    }
    if (int.parse(carStatusModel.value.datas.soc1) <= 100) {
      progressValue.value = int.parse(carStatusModel.value.datas.soc1) / 100;
    }
    if (carStatusModel.value.datas.allDoorStatus == 2 &&
        carStatusModel.value.datas.allLockStatus != 2) {
      openLock.value = false;
    } else {
      openLock.value = true;
      if (carStatusModel.value.datas.allLockStatus == 1) {
        disabledLock.value = true;
      } else {
        disabledLock.value = false;
      }
    }
    // if (carStatusModel.value.datas == null) {

    // }
  }

  //指令结果查询
  void requestCmdResult() async {
    ControlCmdModel cmdResultModel = await DioManager()
        .request<ControlCmdModel>(
            DioManager.POST, 'wsapp/vehicle/getCommandStateVal',
            params: {'carVin': _vin});
    currentCmdTitle.value = cmdResultModel.datas.loadingTitle;
    currentCmdType.value = cmdResultModel.datas.cmdType;
    if (cmdResultModel.datas.value == '0') {
      currentCmdStatus.value = 0;
      showLoadingView.value = false;
    } else {
      showLoadingView.value = true;
      if (cmdResultModel.datas.value == '1') {
        currentCmdStatus.value = 3;
      } else {
        if (cmdResultModel.datas.value == '2') {
          currentCmdStatus.value = 4;
        } else if (cmdResultModel.datas.value == '3' ||
            cmdResultModel.datas.value == '4') {
          currentCmdStatus.value = 5;
        } else if (cmdResultModel.datas.value == '5') {
          currentCmdStatus.value = 2;
        }
        Future.delayed(Duration(seconds: 3)).then((value) {
          showLoadingView.value = false;
        });
      }
    }
  }

  // 发送车控指令
  // controlType 控制类型 1、远程空调 2、开/落锁 3、寻车
  // cmdType 指令类型 (远程空调--1.开启 2.关闭 开/落锁--1.开启 2.关闭 寻车--3.鸣笛 4.闪灯 5.鸣笛+闪灯)
  void sendControlCmd(int controlType, int cmdType) async {
    cancelCmdResultTimer();
    currentCmdType.value = controlType;
    if (controlType == 1) {
      if (cmdType == 1) {
        currentCmdTitle.value = '正在开启远程空调';
      } else if (cmdType == 2) {
        currentCmdTitle.value = '正在关闭远程空调';
      }
    } else if (controlType == 2) {
      if (cmdType == 1) {
        currentCmdTitle.value = '正在开锁';
      } else if (cmdType == 2) {
        currentCmdTitle.value = '正在落锁';
      }
    } else if (controlType == 3) {
      currentCmdTitle.value = '正在寻车';
    }
    currentCmdStatus.value = 1;
    showLoadingView.value = true;

    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, 'wsapp/vehicle/sendVehicleCmd', params: {
      'carVin': _vin,
      'controlType': controlType,
      'cmdType': cmdType
    });
    if (model.code != '200') {
      currentCmdStatus.value = 2;
      Future.delayed(Duration(seconds: 3)).then((value) {
        showLoadingView.value = false;
      });
    }
    addCmdResultTimer();
  }

  // 远程空调设置
  // controlType 控制类型 4、运行时长设置 5、电量安全值设置
  // value 预设值 （运行时长、电量安全值）
  void sendKTSetCmd(int controlType, String value) async {
    cancelCmdResultTimer();
    currentCmdType.value = controlType;
    if (controlType == 4) {
      currentCmdTitle.value = '正在设置运行时长';
    } else if (controlType == 5) {
      currentCmdTitle.value = '正在设置电池SOC';
    }
    currentCmdStatus.value = 1;
    showLoadingView.value = true;

    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, 'wsapp/vehicle/sendSetCmd',
        params: {'carVin': _vin, 'controlType': controlType, 'value': value});
    if (model.code != '200') {
      currentCmdStatus.value = 2;
      Future.delayed(Duration(seconds: 3)).then((value) {
        showLoadingView.value = false;
      });
    }
    addCmdResultTimer();
  }

  // 设置空调定时启动
  // value 定时启动时间
  void sentTimingLaunch(String value) async {
    currentCmdTitle.value = '正在设置定时启动';
    currentCmdStatus.value = 1;
    showLoadingView.value = true;

    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, 'wsapp/vehicle/sendAirTimingOpenDuration',
        params: {'carVin': _vin, 'value': value});
    if (model.code == '200') {
      currentCmdStatus.value = 4;
    } else {
      currentCmdStatus.value = 2;
    }
    Future.delayed(Duration(seconds: 3)).then((value) {
      showLoadingView.value = false;
    });
  }

  // 取消定时启动
  void cancelTimingLaunch() async {
    currentCmdTitle.value = '正在设置取消定时';
    currentCmdStatus.value = 1;
    showLoadingView.value = true;

    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, 'wsapp/vehicle/cancelTiming',
        params: {
          'carVin': _vin,
        });
    if (model.code == '200') {
      currentCmdStatus.value = 4;
    } else {
      currentCmdStatus.value = 2;
    }
    Future.delayed(Duration(seconds: 3)).then((value) {
      showLoadingView.value = false;
    });
  }
}
