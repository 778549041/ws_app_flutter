import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/car/car_config.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/location_manager.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class CarController extends BaseController {
  var locationSuccess = true.obs;
  var nearStoreList = NearStoreListModel().obs;
  var carConfigList = CarConfigListModel().obs;
  var currentConfig = CarConfigModel().obs;
  var currentIndex = 0.obs;
  var carImageList = <String>[].obs;
  var carColorList = [].obs;
  List<String> _carConfigNameList = <String>[];
  late SwiperController swiperController;
  late SwiperController colorSwiperController;
  LocationManager locationManager = LocationManager();
  bool reloadLocation = false; //默认false，为true则弹出提示框

  @override
  void onInit() {
    super.onInit();
    swiperController = SwiperController();
    colorSwiperController = SwiperController();
  }

  @override
  void onReady() {
    //非车主
    if (Get.find<UserController>().userInfo.value.isLogin! &&
        !Get.find<UserController>().userInfo.value.member!.isVehicle!) {
      refreshLocation(false);
      requestCarConfigData();
    }
    locationManager.locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) async {
      LogUtil.d(result);
      await _requestNearStoreData(
          result['longitude'], result['latitude'], result['city'].toString(),
          reloadLocation: reloadLocation);
    });
    super.onReady();
  }

  //刷新位置信息
  void refreshLocation(bool reload) async {
    reloadLocation = reload;
    var hasPermission = false;
    if (!reloadLocation) {
      //首次进页面，请求定位权限
      hasPermission =
          await PermissionManager().requestPermission(Permission.location);
    } else {
      //直接获取定位权限
      hasPermission = (await Permission.location.status).isGranted;
    }

    if (hasPermission) {
      locationManager.startLocation();
    }
    locationSuccess.value = hasPermission;
  }

  //附近特约店数据
  Future _requestNearStoreData(dynamic longitude, dynamic latitude, String city,
      {bool reloadLocation = false}) async {
    nearStoreList.value = await DioManager().request<NearStoreListModel>(
        DioManager.POST, Api.carNearByStoreUrl, queryParamters: {
      "longitude": longitude,
      "latitude": latitude,
      "city": city
    });
    if (reloadLocation) {
      EasyLoading.showToast('刷新位置成功',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
    return;
  }

  //车辆配置信息数据
  void requestCarConfigData() async {
    carConfigList.value = await DioManager()
        .request<CarConfigListModel>(DioManager.POST, Api.carConfigUrl);
    currentConfig.value = carConfigList.value.data![0];
    _carConfigNameList.clear();
    carConfigList.value.data!.forEach((element) {
      _carConfigNameList.add(element.version! + ' | ' + element.conf!);
    });
    _matchingCarImageAndColorData();
  }

  //根据车型匹配车辆图片和颜色数据
  void _matchingCarImageAndColorData() {
    String _version =
        currentConfig.value.version!.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    if (_version == "VE-1") {
      carImageList.assignAll([
        "assets/images/car/car_ve_plus_white_black.png",
        "assets/images/car/car_ve_plus_red.png",
        "assets/images/car/car_ve_plus_blue.png",
        "assets/images/car/car_ve_plus_white.png",
        "assets/images/car/car_ve_plus_black.png",
        "assets/images/car/car_ve_plus_red_black.png",
        "assets/images/car/car_ve_plus_blue_black.png"
      ]);
      carColorList.assignAll([
        {
          "name": "酷黑•塔夫绸白",
          "colors": [Color(0xFF000000), Color(0xFFF3F3F3)]
        },
        {
          "name": "瑞丽红",
          "colors": [Color(0xFFC0161F), Color(0xFFC0161F)]
        },
        {
          "name": "天际蓝",
          "colors": [Color(0xFF8eb3cf), Color(0xFF8eb3cf)]
        },
        {
          "name": "塔夫绸白",
          "colors": [Color(0xFFF3F3F3), Color(0xFFF3F3F3)]
        },
        {
          "name": "玫瑰黑",
          "colors": [Color(0xFF000000), Color(0xFF000000)]
        },
        {
          "name": "酷黑•瑞丽红",
          "colors": [Color(0xFF000000), Color(0xFFC0161F)]
        },
        {
          "name": "酷黑•天际蓝",
          "colors": [Color(0xFF000000), Color(0xFF8eb3cf)]
        }
      ]);
    } else if (_version == "VE-1S") {
      carImageList.assignAll([
        "assets/images/car/car_ves_plus_white_black.png",
        "assets/images/car/car_ves_plus_red.png",
        "assets/images/car/car_ves_plus_orange.png",
        "assets/images/car/car_ves_plus_white.png",
        "assets/images/car/car_ves_plus_black.png",
        "assets/images/car/car_ves_plus_red_black.png",
        "assets/images/car/car_ves_plus_orange_black.png"
      ]);
      carColorList.assignAll([
        {
          "name": "酷黑•塔夫绸白",
          "colors": [Color(0xFF000000), Color(0xFFF3F3F3)]
        },
        {
          "name": "瑞丽红",
          "colors": [Color(0xFFC0161F), Color(0xFFC0161F)]
        },
        {
          "name": "绽放橙",
          "colors": [Color(0xFFE15B09), Color(0xFFE15B09)]
        },
        {
          "name": "塔夫绸白",
          "colors": [Color(0xFFF3F3F3), Color(0xFFF3F3F3)]
        },
        {
          "name": "玫瑰黑",
          "colors": [Color(0xFF000000), Color(0xFF000000)]
        },
        {
          "name": "酷黑•瑞丽红",
          "colors": [Color(0xFF000000), Color(0xFFC0161F)]
        },
        {
          "name": "酷黑•绽放橙",
          "colors": [Color(0xFF000000), Color(0xFFE15B09)]
        }
      ]);
    } else if (_version == "VE-1TA") {
      carImageList.assignAll([
        "assets/images/car/science_white.png",
        "assets/images/car/science_black.png",
        "assets/images/car/science_red.png",
        "assets/images/car/science_green.png",
        "assets/images/car/science_bluewhite.png",
        "assets/images/car/science_blackbluewhite.png",
        "assets/images/car/science_blackgreen.png",
        "assets/images/car/science_blackwhite.png",
        "assets/images/car/science_blackred.png",
      ]);
      carColorList.assignAll([
        {
          "name": "塔夫绸白",
          "colors": [Color(0xFFF3F3F3), Color(0xFFF3F3F3)]
        },
        {
          "name": "玫瑰黑",
          "colors": [Color(0xFF000000), Color(0xFF000000)]
        },
        {
          "name": "瑞丽红",
          "colors": [Color(0xFFC0161F), Color(0xFFC0161F)]
        },
        {
          "name": "碧光翠",
          "colors": [Color(0xFFcadad0), Color(0xFFcadad0)]
        },
        {
          "name": "格陵兰白",
          "colors": [Color(0xFFb4cdd6), Color(0xFFb4cdd6)]
        },
        {
          "name": "酷黑•格陵兰白",
          "colors": [Color(0xFF000000), Color(0xFFb4cdd6)]
        },
        {
          "name": "酷黑•碧光翠",
          "colors": [Color(0xFF000000), Color(0xFFcadad0)]
        },
        {
          "name": "酷黑•塔夫绸白",
          "colors": [Color(0xFF000000), Color(0xFFF3F3F3)]
        },
        {
          "name": "酷黑•瑞丽红",
          "colors": [Color(0xFF000000), Color(0xFFC0161F)]
        },
      ]);
    }
    if (currentIndex.value > carImageList.length - 1) {
      currentIndex.value = 0;
    }
  }

  //选择车辆配置
  void selectCarConfig() {
    Pickers.showSinglePicker(
      Get.context!,
      data: _carConfigNameList,
      selectData:
          currentConfig.value.version! + ' | ' + currentConfig.value.conf!,
      pickerStyle: PickerStyle(
        showTitleBar: true,
        title: Center(
          child: Text(
            '请选择车辆配置',
            style: TextStyle(color: Color(0xFFADADAD), fontSize: 15),
          ),
        ),
      ),
      onConfirm: (data, position) {
        currentConfig.value = carConfigList.value.data![position];
        _matchingCarImageAndColorData();
      },
    );
  }

  //切换车图
  void switchCarImageAction(bool isRight) {
    if (isRight) {
      if (currentIndex.value == carImageList.length - 1) {
        currentIndex.value = 0;
      } else {
        currentIndex.value++;
      }
      swiperController.next();
      colorSwiperController.next();
    } else {
      if (currentIndex.value == 0) {
        currentIndex.value = carImageList.length - 1;
      } else {
        currentIndex.value--;
      }
      swiperController.previous();
      colorSwiperController.previous();
    }
  }

  //拨号
  void callPhoneNumber(String phone) async {
    if (await canLaunch('tel:$phone')) {
      launch('tel:$phone');
    }
  }

  Future buttonAction(int index) async {
    if (index == 1000) {
      //电桩介绍页
      Get.toNamed(Routes.DZINTRODUCE);
    } else if (index == 1001) {
      //车辆配置
      late int _type;
      if (currentConfig.value.conf == "出行版") {
        _type = 0;
      } else if (currentConfig.value.conf == "湃锐版") {
        _type = 1;
      } else if (currentConfig.value.conf == "湃锐豪华版") {
        _type = 2;
      } else if (currentConfig.value.conf == "领锐版") {
        _type = 3;
      } else if (currentConfig.value.conf == "领锐豪华版") {
        _type = 4;
      }
      Get.toNamed(Routes.CONFIGDETAIL, arguments: {'type': _type});
    } else if (index == 1002) {
      //预约试驾
      Get.toNamed(Routes.TESTDRIVE);
    } else if (index == 1003) {
      //商城下订
      CommonModel _model = await DioManager()
          .request<CommonModel>(DioManager.POST, Api.mallReservationOrderUrl);
      if (_model.redirect != null && _model.redirect!.length > 0) {
        pushH5Page(args: {
          'url': _model.redirect,
          'hasNav': true,
        });
      } else if (_model.message != null) {
        EasyLoading.showToast(_model.message!,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else if (index == 1004) {
      //点击头像
      Get.toNamed(Routes.MINEINFO);
    } else if (index == 1006) {
      //点击积分
      //积分规则
      Get.toNamed(Routes.INTEGRALRULE);
    } else if (index == 1007) {
      //点击了解VE-1
      pushH5Page(args: {
        'url': Env.envConfig.serviceUrl + HtmlUrls.UnderstandVEPage,
        'hasNav': true,
      });
    } else if (index == 1008) {
      //点击车主认证
      Get.find<UserController>().certifyVechile();
    }
  }
}
