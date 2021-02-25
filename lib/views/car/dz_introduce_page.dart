import 'package:amap_map_fluttify/amap_map_fluttify.dart' hide controller;
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/wow/near_dz_map_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';

class DZIntroducePage extends GetView<NearDZMapController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '电桩充电',
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, top: 30, right: 15, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '家用电桩，免费赠送安装',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '为了确保车主的用车便利性和保障性，在购买VE-1后的一年时间内，广汽本田免费提供行业领先的充电桩产品（壁挂式7kW充电桩）以及30米内的免费安装服务，并随车赠送5米应急充电线，让车主充电更加随心，用车生活更加随性。',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            Image.asset('assets/images/car/dz_map_kv.png'),
            SizedBox(
              height: 30,
            ),
            Text(
              '出行充电，电桩分布',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
              leftWidget: Image.asset(
                'assets/images/wow/map_search.png',
                scale: 2.0,
              ),
              hintText: '定位不准？试试输入搜索',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5)),
              submitCallBack: (value) => controller.inputSearch(value),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 240,
              child: Stack(
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      return AmapView(
                        // 地图类型 (可选)
                        mapType: MapType.Standard,
                        showCompass: false,
                        // 缩放级别 (可选)
                        zoomLevel: 14,
                        // 标识点击回调 (可选)
                        onMarkerClicked: (IMarker marker) =>
                            controller.onMarkerClicked(marker),
                        // 地图点击回调 (可选)
                        onMapClicked: (LatLng coord) =>
                            controller.onMapClicked(coord),
                        // 地图拖动开始 (可选)
                        onMapMoveStart: (MapMove move) =>
                            controller.onMapMoveStart(move),
                        // 地图拖动结束 (可选)
                        onMapMoveEnd: (MapMove move) =>
                            controller.onMapMoveEnd(move),
                        // 地图创建完成回调 (可选)
                        onMapCreated: (mapController) =>
                            controller.onMapCreated(mapController),
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Obx(
                      () => Offstage(
                        offstage: controller.searchData.length == 0,
                        child: Container(
                          color: Colors.white,
                          width: Get.width,
                          height: Get.height -
                              (ScreenUtil.getInstance().statusBarHeight +
                                  ScreenUtil.getInstance().appBarHeight),
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 20),
                              itemCount: controller.searchData.length,
                              itemBuilder: (BuildContext context, int index) {
                                InputTip item = controller.searchData[index];
                                return GestureDetector(
                                  onTap: () =>
                                      controller.searchResultClick(index),
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    height: 44,
                                    color: Colors.white,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            height: 0.5,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
