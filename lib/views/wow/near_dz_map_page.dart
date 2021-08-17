// import 'package:amap_map_fluttify/amap_map_fluttify.dart' hide controller;
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/third_config.dart';
import 'package:ws_app_flutter/view_models/wow/near_dz_map_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';

class NearDZMapPage extends GetView<NearDZMapController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      titleWidget: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        alignment: Alignment.center,
        height: 40,
        child: CustomTextField(
          leftWidget: Image.asset(
            'assets/images/wow/map_search.png',
            scale: 2.0,
          ),
          hintText: '定位不准？试试输入搜索',
          // submitCallBack: (value) => controller.inputSearch(value),
        ),
      ),
      child: Stack(
        children: <Widget>[
          AMapWidget(
            apiKey: amapApiKeys,
            
          ),
          // AmapView(
          //   // 地图类型 (可选)
          //   mapType: MapType.Standard,
          //   showCompass: false,
          //   // 缩放级别 (可选)
          //   zoomLevel: 14,
          //   // 标识点击回调 (可选)
          //   onMarkerClicked: (IMarker marker) =>
          //       controller.onMarkerClicked(marker),
          //   // 地图点击回调 (可选)
          //   onMapClicked: (LatLng coord) => controller.onMapClicked(coord),
          //   // 地图拖动开始 (可选)
          //   onMapMoveStart: (MapMove move) => controller.onMapMoveStart(move),
          //   // 地图拖动结束 (可选)
          //   onMapMoveEnd: (MapMove move) => controller.onMapMoveEnd(move),
          //   // 地图创建完成回调 (可选)
          //   onMapCreated: (mapController) =>
          //       controller.onMapCreated(mapController),
          // ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Obx(
          //     () => Offstage(
          //       offstage: controller.searchData.length == 0,
          //       child: Container(
          //         color: Colors.white,
          //         width: Get.width,
          //         height: Get.height -
          //             (ScreenUtil.getInstance().statusBarHeight +
          //                 ScreenUtil.getInstance().appBarHeight),
          //         child: ListView.builder(
          //             padding: EdgeInsets.only(top: 20),
          //             itemCount: controller.searchData.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               InputTip item = controller.searchData[index];
          //               return GestureDetector(
          //                 onTap: () => controller.searchResultClick(index),
          //                 behavior: HitTestBehavior.translucent,
          //                 child: Container(
          //                   height: 44,
          //                   color: Colors.white,
          //                   child: Container(
          //                     margin: EdgeInsets.only(left: 10, right: 10),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: <Widget>[
          //                         Text(
          //                           item.name,
          //                           maxLines: 1,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: TextStyle(
          //                               fontSize: 15, color: Colors.black),
          //                         ),
          //                         Container(
          //                           height: 0.5,
          //                           color: Colors.grey,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             }),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
