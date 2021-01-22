import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
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

  @override
  void onInit() {
    super.onInit();
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
    DioManager().request(DioManager.POST, Api.carConfigUrl);
  }

  //拨号
  void callPhoneNumber(String phone) async {
    if (await canLaunch('tel:$phone')) {
      launch('tel:$phone');
    }
  }
}
