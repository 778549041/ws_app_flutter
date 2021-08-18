import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/third_config.dart';
import 'package:ws_app_flutter/view_models/car/nav_map_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';

class NavMapPage extends GetView<NavMapController> {
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
          hintText: '搜索你要去的地方',
          // submitCallBack: (value) => controller.inputSearch(value),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Obx(
            () => AMapWidget(
              apiKey: amapApiKeys,
              markers: Set<Marker>.of(controller.markers.values),

              ///自定义地图样式
              customStyleOptions: CustomStyleOptions(true),

              ///定位小蓝点
              myLocationStyleOptions: MyLocationStyleOptions(
                true,
                icon: BitmapDescriptor.fromIconPath(
                    'assets/images/wow/icon_current_location.png'),
              ),

              /// 地图单击事件的回调
              onTap: (LatLng latLng) => controller.onMapClicked(latLng),

              ///位置回调
              onLocationChanged: (AMapLocation location) =>
                  controller.onLocationChanged(location),

              /// 地图创建完成回调
              onMapCreated: (AMapController amapController) =>
                  controller.onMapCreated(amapController),
            ),
          ),
          Positioned(
            left: (ScreenUtil.getInstance().screenWidth - 80) / 2,
            bottom: 60,
            child: CustomButton(
              title: '导航',
              width: 80,
              height: 40,
              backgroundColor: Color(0xFF0045D0),
              titleColor: Colors.white,
              radius: 20,
              onPressed: () => controller.callThirdMap(),
            ),
          ),
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
