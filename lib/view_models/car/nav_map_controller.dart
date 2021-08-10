// import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';
import 'package:ws_app_flutter/widgets/global/custom_sheet.dart';

class NavMapController extends GetxController {
  // AmapController mapController;
  // LatLng startLatLng; //当前位置经纬度
  // var searchData = <InputTip>[].obs; //输入搜索tips
  // LatLng endLatlng; //终点位置经纬度(调起第三方所需数据)
  // String destination; //终点位置(调起第三方所需数据)

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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
  //   Get.focusScope.unfocus();
  //   InputTip item = searchData[index];
  //   endLatlng = item.coordinate;
  //   destination = item.name;
  //   mapController?.clear();
  //   mapController?.addMarker(
  //     MarkerOption(
  //       coordinate: endLatlng,
  //       title: '终点',
  //       iconProvider: AssetImage('assets/images/wow/endPoint.png'),
  //     ),
  //   );
  //   // mapController.zoomToSpan(
  //   //   [startLatLng, endLatlng],
  //   //   padding: EdgeInsets.all(20),
  //   // );
  //   _caculateDrivePathAndShowBestPath();
  //   searchData.assignAll([]);
  // }

  // // 地图创建完成回调
  // Future onMapCreated(AmapController controller) async {
  //   mapController = controller;
  //   await initData();
  // }

  // //初始化
  // Future initData() async {
  //   // requestPermission是权限请求方法, 需要你自己实现
  //   // 如果不知道怎么处理, 可以参考example工程的实现, example工程依赖了`permission_handler`插件.
  //   if (await PermissionManager().requestPermission(Permission.location)) {
  //     await mapController?.showMyLocation(MyLocationOption(
  //       myLocationType: MyLocationType.Locate,
  //       iconProvider: AssetImage('assets/images/wow/icon_current_location.png'),
  //     ));
  //     startLatLng = await mapController?.getLocation();
  //   }
  // }

  // void _caculateDrivePathAndShowBestPath() async {
  //   final routeResult = await AmapSearch.instance.searchDriveRoute(
  //     from: startLatLng,
  //     to: endLatlng,
  //   );
  //   List<DrivePath> paths = await routeResult.drivePathList;
  //   List<DriveStep> steps = await paths.first.driveStepList;
  //   List<LatLng> points = <LatLng>[];
  //   for (var step in steps) {
  //     var tms = await step.tmsList;
  //     for (var tmc in tms) {
  //       var polyling = await tmc.polyline;
  //       for (var point in polyling) {
  //         points.add(point);
  //       }
  //     }
  //   }
  //   print(points);
  //   await mapController?.addPolyline(PolylineOption(
  //       coordinateList: points, width: 10, strokeColor: Colors.green));
  // }

  // //调起第三方地图
  // Future callThirdMap() async {
  //   if (endLatlng == null) {
  //     EasyLoading.showToast('请先选择目的地',
  //         toastPosition: EasyLoadingToastPosition.bottom);
  //     return;
  //   }
  //   List<String> titles, urls;
  //   if (GetPlatform.isIOS) {
  //     titles = ['苹果地图', '高德地图', '百度地图', '腾讯地图'];
  //     urls = [
  //       'http://maps.apple.com/?q=${Uri.encodeComponent(destination)}&sll=${endLatlng.latitude}},${endLatlng.longitude}&z=10&t=s',
  //       'iosamap://path?sourceApplication=WOWSTATION&sid=BGVIS1&did=BGVIS2&dlat=${endLatlng.latitude}&dlon=${endLatlng.longitude}&dname=${Uri.encodeComponent(destination)}&dev=0&t=0',
  //       'baidumap://map/direction?origin={{${Uri.encodeComponent('我的位置')}}&destination=${Uri.encodeComponent('目的地')}:${Uri.encodeComponent(destination)}|latlng:${endLatlng.latitude},${endLatlng.longitude}&mode=driving&coord_type=gcj02',
  //       'qqmap://map/routeplan?type=drive&from=${Uri.encodeComponent('我的位置')}&to=${Uri.encodeComponent(destination)}&tocoord=${endLatlng.latitude},${endLatlng.longitude}&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77',
  //     ];
  //   } else if (GetPlatform.isAndroid) {
  //     titles = ['高德地图', '百度地图', '腾讯地图'];
  //     urls = [
  //       'androidamap://navi?sourceApplication=appname&poiname=wow_flutter&lat=${endLatlng.latitude}&lon=${endLatlng.longitude}&dev=1&style=2',
  //       'bdapp://map/direction?region=beijing&origin=${startLatLng.latitude},${startLatLng.longitude}&destination=${endLatlng.latitude},${endLatlng.longitude}&coord_type=bd09ll&mode=driving',
  //       'qqmap://map/routeplan?type=drive&from=${Uri.encodeComponent('我的位置')}&to=${Uri.encodeComponent(destination)}&tocoord=${endLatlng.latitude},${endLatlng.longitude}&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77',
  //     ];
  //   }
  //   Get.bottomSheet(
  //     CustomSheet(
  //       title: '打开第三方地图',
  //       dataArr: titles,
  //       clickCallback: (selectIndex, selectText) {
  //         if (selectIndex == 0) {
  //           return;
  //         }
  //         launchThirdApp(urls[selectIndex - 1]);
  //       },
  //     ), //设置圆角
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(10),
  //       ),
  //     ),
  //     // 抗锯齿
  //     clipBehavior: Clip.antiAlias,
  //   );
  // }

  // //打开第三方应用
  // void launchThirdApp(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     EasyLoading.showToast('请先安装应用',
  //         toastPosition: EasyLoadingToastPosition.bottom);
  //   }
  // }
}
