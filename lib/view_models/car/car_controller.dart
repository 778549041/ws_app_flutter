import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/models/car/car_config.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
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
  var carImageList = List<String>().obs;
  var carColorList = List().obs;
  List<String> _carConfigImageList = List<String>();
  SwiperController swiperController;
  SwiperController colorSwiperController;

  @override
  void onInit() {
    super.onInit();
    swiperController = SwiperController();
    colorSwiperController = SwiperController();
  }

  @override
  void onReady() {
    //非车主
    if (Get.find<UserController>().userInfo.value.member.isVehicle != 'true') {
      refreshLocation();
      requestCarConfigData();
    }
    super.onReady();
  }

  //刷新位置信息
  void refreshLocation() async {
    if (await PermissionManager().requestPermission(Permission.location)) {
      locationSuccess.value = true;
      final _location = await AmapLocation.instance.fetchLocation();
      await _requestNearStoreData(_location.latLng.longitude,
          _location.latLng.latitude, _location.city);
    } else {
      locationSuccess.value = false;
    }
  }

  //附近特约店数据
  Future _requestNearStoreData(double longitude, double latitude, String city,
      {bool reloadLocation = false}) async {
    nearStoreList.value = await DioManager().request<NearStoreListModel>(
        DioManager.POST, Api.carNearByStoreUrl, queryParamters: {
      "longitude": longitude,
      "latitude": latitude,
      "city": city
    });
    if (reloadLocation) {
      Fluttertoast.showToast(msg: '刷新位置成功');
    }
    return;
  }

  //车辆配置信息数据
  void requestCarConfigData() async {
    carConfigList.value = await DioManager()
        .request<CarConfigListModel>(DioManager.POST, Api.carConfigUrl);
    currentConfig.value = carConfigList.value.data[0];
    _carConfigImageList.clear();
    carConfigList.value.data.forEach((element) {
      _carConfigImageList.add(_selectConfigImage(element.conf));
    });
    _matchingCarImageAndColorData();
  }

  String _selectConfigImage(String config) {
    String _imageName;
    if (config == "出行版") {
      _imageName = "assets/images/car/select_ve_plus_cx.png";
    } else if (config == "舒适版") {
      _imageName = "assets/images/car/select_ve_plus_ss.png";
    } else if (config == "豪华版") {
      _imageName = "assets/images/car/select_ve_plus_hh.png";
    } else if (config == "湃锐版") {
      _imageName = "assets/images/car/select_ves_plus_pr.png";
    } else if (config == "湃锐豪华版") {
      _imageName = "assets/images/car/select_ves_plus_prhh.png";
    }
    return _imageName;
  }

  //根据车型匹配车辆图片和颜色数据
  void _matchingCarImageAndColorData() {
    String _version = currentConfig.value.version;
    if (_version == "VE-1") {
      carImageList.assignAll([
        "assets/images/car/car_ve_white_black.png",
        "assets/images/car/car_ve_red.png",
        "assets/images/car/car_ve_blue.png",
        "assets/images/car/car_ve_white.png",
        "assets/images/car/car_ve_black.png",
        "assets/images/car/car_ve_red_black.png",
        "assets/images/car/car_ve_blue_black.png"
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
          "name": "天空蓝",
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
          "name": "酷黑•天空蓝",
          "colors": [Color(0xFF000000), Color(0xFF8eb3cf)]
        }
      ]);
    } else if (_version == "VE-1+") {
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
    } else if (_version == "VE-1S+") {
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
    }
  }

  //选择车辆配置
  void selectCarConfig() {
    Picker(
      adapter: PickerDataAdapter(
          data: List.generate(
        _carConfigImageList.length,
        (index) => PickerItem(
            text: Image.asset(
          _carConfigImageList[index],
          scale: 2.0,
        )),
      )),
      selecteds: [carConfigList.value.data.indexOf(currentConfig.value)],
      itemExtent: 35,
      cancelText: '取消',
      cancelTextStyle: TextStyle(color: Colors.black, fontSize: 15),
      confirmText: '确认',
      confirmTextStyle: TextStyle(color: Colors.black, fontSize: 15),
      title: Text(
        '请选择车辆配置',
        style: TextStyle(color: Color(0xFFADADAD), fontSize: 15),
      ),
      onConfirm: (picker, selecteds) {
        currentConfig.value = carConfigList.value.data[selecteds[0]];
        _matchingCarImageAndColorData();
      },
    ).showModal(Get.context);
  }

  //切换车图
  void switchCarImageAction(bool isRight) {
    if (isRight) {
      if (currentIndex.value == 6) {
        currentIndex.value = 0;
      } else {
        currentIndex.value++;
      }
      swiperController.next();
      colorSwiperController.next();
    } else {
      if (currentIndex.value == 0) {
        currentIndex.value = 6;
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
}
