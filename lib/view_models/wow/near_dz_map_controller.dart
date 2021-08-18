import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/models/wow/cdz_info_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/location_manager.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';
import 'package:ws_app_flutter/widgets/global/custom_sheet.dart';
import 'package:ws_app_flutter/widgets/wow/dz_info_view.dart';
import 'package:ws_app_flutter/widgets/wow/store_info_view.dart';

class NearDZMapController extends GetxController {
  AMapController? mapController;
  LatLng? startLatLng; //当前位置经纬度
  LocationManager locationManager = LocationManager();
  // var searchData = <InputTip>[].obs; //输入搜索tips
  LatLng? currenSelecttLatLng; //当前选择的位置经纬度(调起第三方所需数据)
  String? currentSelectTitle; //当前选择的位置(调起第三方所需数据)
  var markers = Map<String, Marker>().obs; //所有标注点

  @override
  void onInit() async {
    super.onInit();
    PermissionManager().requestPermission(Permission.location);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    locationManager.dispose();
    super.onClose();
  }

  /// 设置地图中心点
  void _moveToCenter(LatLng latLng) {
    mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          //中心点
          target: latLng,
          //缩放级别
          zoom: 14,
        ),
      ),
      animated: true,
    );
  }

  // //输入搜索提示
  // Future inputSearch(String searchKey) async {
  //   if (searchKey.length == 0) {
  //     searchData.assignAll([]);
  //     return;
  //   }
  //   final inputTipList = await AmapSearch.instance.fetchInputTips(searchKey);
  //   searchData.assignAll(inputTipList);
  // }

  // //输入提示单行点击
  // Future searchResultClick(int index) async {
  //   Get.focusScope?.unfocus();
  //   InputTip item = searchData[index];
  //   if (item.poiId.length == 0 && item.coordinate == null) {
  //     if (item.address.length > 0) {
  //       final poiList = await AmapSearch.instance.searchKeyword(item.address);
  //       Poi poi = poiList.first;
  //       _moveToCenter(LatLng(poi.latLng.latitude, poi.latLng.longitude));
  //       await getCurrentDZMarkerData(poi.latLng.longitude, poi.latLng.latitude);
  //       await getCurrentStoreMarkerData(
  //           poi.latLng.longitude, poi.latLng.latitude);
  //     }
  //   } else {
  //     _moveToCenter(
  //         LatLng(item.coordinate.latitude, item.coordinate.longitude));
  //     await getCurrentDZMarkerData(
  //         item.coordinate.longitude, item.coordinate.latitude);
  //     await getCurrentStoreMarkerData(
  //         item.coordinate.longitude, item.coordinate.latitude);
  //   }
  //   searchData.assignAll([]);
  // }

  ///位置回调
  Future onLocationChanged(AMapLocation location) async {
    startLatLng = location.latLng;
    _moveToCenter(startLatLng!);
    await getCurrentDZMarkerData(startLatLng!.longitude, startLatLng!.latitude);
    await getCurrentStoreMarkerData(
        startLatLng!.longitude, startLatLng!.latitude);
  }

  // 地图点击回调
  Future onMapClicked(LatLng latLng) async {
    Get.focusScope?.unfocus();
  }

  // 地图拖动开始
  Future onMapMoveStart(CameraPosition position) async {
    Get.focusScope?.unfocus();
  }

  // 地图拖动结束
  Future<void> onMapMoveEnd(CameraPosition position) async {
    await getCurrentDZMarkerData(
        position.target.longitude, position.target.latitude);
    await getCurrentStoreMarkerData(
        position.target.longitude, position.target.latitude);
  }

  // 地图创建完成回调
  Future onMapCreated(AMapController controller) async {
    mapController = controller;
  }

  //获取当前位置周边电桩标注数据
  Future getCurrentDZMarkerData(double lng, double lat) async {
    // LatLng loc = LatLng(lat, lng);
    // ReGeocode res = await AmapSearch.instance.searchReGeocode(loc);
    CDZListModel _model = await DioManager().request<CDZListModel>(
        DioManager.GET, Api.mapCDZListUrl,
        queryParamters: {
          'longitude': lng.toString(),
          'latitude': lat.toString(),
          'distance': '10',
          // 'city': res.cityName,
        });
    if (_model.list != null && _model.list!.length > 0) {
      _model.list!.forEach((CDZInfo element) async {
        final Marker marker = Marker(
          position: LatLng(double.parse(element.stationLat!),
              double.parse(element.stationLng!)),
          infoWindowEnable: false,
          icon: await _markerIcon(element.serviceType!),
          onTap: (id) async {
            currenSelecttLatLng = LatLng(double.parse(element.stationLat!),
                double.parse(element.stationLng!));
            currentSelectTitle = element.stationName!;
            await getSingleDZDetailData(
                element.stationID!, element.serviceType!);
          },
        );
        markers[marker.id] = marker;
      });
    }
  }

  //获取当前位置周边特约店标注数据
  Future getCurrentStoreMarkerData(double lng, double lat) async {
    NearStoreListModel _model = await DioManager().request<NearStoreListModel>(
        DioManager.GET, Api.mapCDZStoreListUrl,
        queryParamters: {
          'longitude': lng.toString(),
          'latitude': lat.toString(),
          'distance': '10',
        });
    if (_model.data != null && _model.data!.length > 0) {
      _model.data!.forEach((NearStoreModel element) async {
        final Marker marker = Marker(
          position: LatLng(
              double.parse(element.fShopLat!), double.parse(element.fShopLng!)),
          infoWindowEnable: false,
          icon: await BitmapDescriptor.fromIconPath('assets/images/wow/dz_store_anno.png'),
          onTap: (id) {
            currenSelecttLatLng = LatLng(double.parse(element.fShopLat!),
                double.parse(element.fShopLng!));
            currentSelectTitle = element.fShopName!;
            //展示特约店详细弹窗
            Get.bottomSheet(
              StoreInfoView(
                info: element,
                mapNavCallback: () => callThirdMap(
                    currenSelecttLatLng!.longitude,
                    currenSelecttLatLng!.latitude,
                    currentSelectTitle!),
              ),
              barrierColor: Colors.transparent,
              // 抗锯齿
              clipBehavior: Clip.antiAlias,
            );
          },
        );
        markers[marker.id] = marker;
      });
    }
  }

  //获取单个电桩详细数据
  Future getSingleDZDetailData(String stationID, String serviceType) async {
    SingleCDZInfoModel _model = await DioManager().request<SingleCDZInfoModel>(
        DioManager.GET, Api.mapSingleCDZUrl,
        queryParamters: {'StationID': stationID, 'ServiceType': serviceType});
    if (_model.result!) {
      //展示电桩详细弹窗
      Get.bottomSheet(
        DZInfoView(
          info: _model.list!,
          jumpListCallback: () {
            Get.back();
            Get.toNamed(Routes.NEARDZLIST, arguments: {
              'stationID': stationID,
              'serviceType': serviceType
            });
          },
          mapNavCallback: () => callThirdMap(currenSelecttLatLng!.longitude,
              currenSelecttLatLng!.latitude, currentSelectTitle!),
        ),
        barrierColor: Colors.transparent,
        // 抗锯齿
        clipBehavior: Clip.antiAlias,
      );
    }
  }

  //标注图片
  Future<BitmapDescriptor> _markerIcon(String type) async {
    String operatorImage = '';
    if (type == '1') {
      operatorImage = 'assets/images/wow/icon_cdz_tld.png';
    } else if (type == '2') {
      operatorImage = 'assets/images/wow/icon_cdz_gh.png';
    } else if (type == '3') {
      operatorImage = 'assets/images/wow/icon_cdz_xx.png';
    }
    return BitmapDescriptor.fromIconPath(operatorImage);
  }

  //调起第三方地图
  Future callThirdMap(num lng, num lat, String destination) async {
    Get.back();
    late List<String> titles, urls;
    if (GetPlatform.isIOS) {
      titles = ['苹果地图', '高德地图', '百度地图', '腾讯地图'];
      urls = [
        'http://maps.apple.com/?q=${Uri.encodeComponent(destination)}&sll=$lat,$lng&z=10&t=s',
        'iosamap://path?sourceApplication=WOWSTATION&sid=BGVIS1&did=BGVIS2&dlat=$lat&dlon=$lng&dname=${Uri.encodeComponent(destination)}&dev=0&t=0',
        'baidumap://map/direction?origin={{${Uri.encodeComponent('我的位置')}}&destination=${Uri.encodeComponent('目的地')}:${Uri.encodeComponent(destination)}|latlng:$lat,$lng&mode=driving&coord_type=gcj02',
        'qqmap://map/routeplan?type=drive&from=${Uri.encodeComponent('我的位置')}&to=${Uri.encodeComponent(destination)}&tocoord=$lat,$lng&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77',
      ];
    } else if (GetPlatform.isAndroid) {
      titles = ['高德地图', '百度地图', '腾讯地图'];
      urls = [
        'androidamap://navi?sourceApplication=appname&poiname=wow_flutter&lat=$lat&lon=$lng&dev=1&style=2',
        'bdapp://map/direction?region=beijing&origin=${startLatLng!.latitude},${startLatLng!.longitude}&destination=$lat,$lng&coord_type=bd09ll&mode=driving',
        'qqmap://map/routeplan?type=drive&from=${Uri.encodeComponent('我的位置')}&to=${Uri.encodeComponent(destination)}&tocoord=$lat,$lng&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77',
      ];
    }
    Get.bottomSheet(
      CustomSheet(
        title: '打开第三方地图',
        dataArr: titles,
        clickCallback: (selectIndex, selectText) {
          if (selectIndex == 0) {
            return;
          }
          launchThirdApp(urls[selectIndex - 1]);
        },
      ), //设置圆角
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
    );
  }

  //打开第三方应用
  void launchThirdApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      EasyLoading.showToast('请先安装应用',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
