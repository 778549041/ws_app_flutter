import 'dart:convert';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/models/wow/cdz_info_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';
import 'package:ws_app_flutter/widgets/global/custom_sheet.dart';

class NearDZMapController extends GetxController {
  AmapController mapController;
  LatLng startLatLng; //当前位置经纬度
  List<CDZInfo> dzMarkerList = []; //充电站标注
  List<NearStoreModel> storeMarkerList = []; //特约店标注
  SingleCDZInfo currentcdzInfo; //当前充电站详细信息
  List<Map> searchData = []; //输入搜索tips
  bool showDZInfoView = false;
  LatLng currenSelecttLatLng; //当前选择的位置经纬度(调起第三方所需数据)
  String currentSelectTitle; //当前选择的位置(调起第三方所需数据)

  @override
  void onInit() async {
    if (await PermissionManager().requestPermission(Permission.location)) {
      final _location = await AmapLocation.instance.fetchLocation();
      startLatLng = _location.latLng;
      print(startLatLng);
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //输入搜索提示
  Future inputSearch(String searchKey) async {
    if (searchKey.length == 0) {
      return;
    }
    searchData.clear();
    final inputTipList = await AmapSearch.instance.fetchInputTips(searchKey);
    for (var value in inputTipList) {
      var name = await value.name;
      var pos = await value.coordinate;
      Map map = {'name': name, 'location': pos};
      print(map);
      searchData.add(map);
    }
  }

  //标识点击回调
  Future onMarkerClicked(IMarker marker) async {
    if (Get.isBottomSheetOpen) {
      Get.back();
    }
    LatLng location = await marker.coordinate;
    await mapController.setCenterCoordinate(location);
    if (await marker.title == '当前位置') return;
    currenSelecttLatLng = location;
    currentSelectTitle = await marker.title;
    await getSingleDZDetailData(await marker.snippet, '');
  }

  // 地图点击回调
  Future onMapClicked(LatLng coord) async {
    if (Get.isBottomSheetOpen) {
      Get.back();
    }
  }

  // 地图拖动开始
  Future onMapMoveStart(MapMove move) async {
    if (Get.isBottomSheetOpen) {
      Get.back();
    }
  }

  // 地图拖动结束
  Future onMapMoveEnd(MapMove move) async {
    await mapController.getCenterCoordinate().then((value) async {
      await getCurrentDZMarkerData(value.longitude, value.latitude);
      await getCurrentStoreMarkerData(value.longitude, value.latitude);
    });
    return;
  }

  // 地图创建完成回调
  Future onMapCreated(AmapController controller) async {
    mapController = controller;
    // requestPermission是权限请求方法, 需要你自己实现
    // 如果不知道怎么处理, 可以参考example工程的实现, example工程依赖了`permission_handler`插件.
    if (await PermissionManager().requestPermission(Permission.location)) {
      await mapController?.showMyLocation(MyLocationOption(
        myLocationType: MyLocationType.Locate,
        iconProvider: AssetImage('assets/images/wow/icon_current_location.png'),
      ));
      await getCurrentDZMarkerData(startLatLng.longitude, startLatLng.latitude);
      await getCurrentStoreMarkerData(
          startLatLng.longitude, startLatLng.latitude);
    }
  }

  //调起第三方地图
  Future callThirdMap(num lng, num lat, String destination) async {
    print('跳转三方地图');
    if (Get.isBottomSheetOpen) {
      Get.back();
    }
    List<String> titles, urls;
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
        'bdapp://map/direction?region=beijing&origin=${startLatLng.latitude},${startLatLng.longitude}&destination=$lat,$lng&coord_type=bd09ll&mode=driving',
        'qqmap://map/routeplan?type=drive&from=${Uri.encodeComponent('我的位置')}&to=${Uri.encodeComponent(destination)}&tocoord=$lat,$lng&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77',
      ];
    }
    Get.bottomSheet(
      CustomSheet(
        title: '打开第三方地图',
        dataArr: titles,
        clickCallback: (selectIndex, selectText) {
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

  //添加电桩标注
  Future addDZMarkers() async {
    List<MarkerOption> markers = dzMarkerList.map((CDZInfo info) {
      return MarkerOption(
        coordinate: LatLng(
            double.parse(info.stationLat), double.parse(info.stationLng)),
        title: info.stationName,
        snippet: info.stationID,
        object: json.encode(info.toJson()),
        infoWindowEnabled: false,
        iconProvider: AssetImage(_markerIcon(info.serviceType)),
      );
    }).toList();
    await mapController.addMarkers(markers);
  }

  //添加特约店标注
  Future addStoreMarkers() async {
    List<MarkerOption> markers = storeMarkerList.map((NearStoreModel info) {
      return MarkerOption(
        coordinate:
            LatLng(double.parse(info.fShopLat), double.parse(info.fShopLng)),
        title: info.fShopName,
        object: json.encode(info.toJson()),
        infoWindowEnabled: false,
        iconProvider: AssetImage('assets/images/wow/dz_store_anno.png'),
      );
    }).toList();
    await mapController.addMarkers(markers);
  }

  //标注图片
  String _markerIcon(String type) {
    String operatorImage = '';
    if (type == '1') {
      operatorImage = 'assets/images/wow/icon_cdz_tld.png';
    } else if (type == '2') {
      operatorImage = 'assets/images/wow/icon_cdz_gh.png';
    } else if (type == '3') {
      operatorImage = 'assets/images/wow/icon_cdz_xx.png';
    }
    return operatorImage;
  }

  //获取当前位置周边电桩标注数据
  Future getCurrentDZMarkerData(num lng, num lat) async {
    CDZListModel _model = await DioManager().request<CDZListModel>(
        DioManager.GET, Api.mapCDZListUrl,
        queryParamters: {
          'longitude': lng.toString(),
          'latitude': lat.toString(),
          'distance': '10',
          'city': ''
        });
    dzMarkerList.clear();
    dzMarkerList.addAll(_model.list);
    addDZMarkers();
  }

  //获取当前位置周边特约店标注数据
  Future getCurrentStoreMarkerData(num lng, num lat) async {
    NearStoreListModel _model = await DioManager().request<NearStoreListModel>(
        DioManager.GET, Api.mapCDZStoreListUrl,
        queryParamters: {
          'longitude': lng.toString(),
          'latitude': lat.toString(),
          'distance': '10',
        });
    storeMarkerList.clear();
    storeMarkerList.addAll(_model.data);
    addStoreMarkers();
  }

  //获取单个电桩详细数据
  Future getSingleDZDetailData(String stationID, String serviceType) async {
    SingleCDZInfoModel _model = await DioManager().request<SingleCDZInfoModel>(
        DioManager.GET, Api.mapSingleCDZUrl,
        queryParamters: {'StationID': stationID, 'ServiceType': serviceType});
    if (_model.result) {
      //展示电桩详细弹窗
      currentcdzInfo = _model.list;
    }
  }
}
