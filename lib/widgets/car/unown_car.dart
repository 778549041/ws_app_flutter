import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class UnOwnCarWidget extends GetView<CarController> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildCarIVItem(),
            _buildConfigItem(),
            _buildBtnItem(),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
              child: Image.asset('assets/images/car/car_uncertify_dz_kv.png'),
            ),
            _buildNearStoreItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarIVItem() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
          child: Row(
            children: <Widget>[
              CustomButton(
                backgroundColor: Colors.transparent,
                width: 28,
                height: (Get.width - 80) * 36 / 75,
                image: 'assets/images/car/car_left_arrow.png',
                imageW: 9,
                imageH: 14,
                onPressed: () {},
              ),
              Container(
                  width: Get.width - 80,
                  height: (Get.width - 80) * 36 / 75,
                  child: Swiper(
                      // viewportFraction: 0.8,
                      //视图宽度，即显示的item的宽度屏占比
                      //scale: 0.9,
                      //两侧item的缩放比
                      onTap: (int index) {
                        //点击事件，返回下标
                      },
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.red,
                        );
                      })),
              CustomButton(
                backgroundColor: Colors.transparent,
                width: 28,
                height: (Get.width - 80) * 36 / 75,
                image: 'assets/images/car/car_right_arrow.png',
                imageW: 9,
                imageH: 14,
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 0, left: Get.width - 115, right: 15),
          child: CustomButton(
            backgroundColor: Colors.transparent,
            width: 100,
            height: 20,
            image: 'assets/images/car/car_kv_360.png',
            imageW: 15,
            imageH: 15,
            imagePosition: XJImagePosition.XJImagePositionRight,
            title: '了解配置详情',
            fontSize: 12,
            onPressed: () {},
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 205,
          height: 10,
          child: Swiper(
              viewportFraction: 1 / 7,
              //视图宽度，即显示的item的宽度屏占比
              scale: 0.9,
              //两侧item的缩放比
              onTap: (int index) {
                //点击事件，返回下标
              },
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.primaries[index],
                );
              }),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Image.asset(
            'assets/images/car/car_up_arrow.png',
            width: 6.5,
            height: 4,
          ),
        ),
        Text(
          'aaaaaaaaa',
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildConfigItem() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '车辆配置',
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/car/select_ve_plus_cx.png',
                      scale: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Image.asset(
                        'assets/images/mine/mine_right_arrow.png',
                        width: 7.5,
                        height: 11,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
          height: 0.5,
          color: Color(0xFFD7D7D7),
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '补贴后售价',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '17.38万元',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
          height: 0.5,
          color: Color(0xFFD7D7D7),
        ),
      ],
    );
  }

  Widget _buildBtnItem() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
      child: Row(
        children: <Widget>[
          CustomButton(
            width: (Get.width - 75) / 2,
            height: 34,
            radius: 17,
            borderColor: Color(0xFF1C7AF4),
            borderWidth: 1.0,
            title: '预约试驾',
            titleColor: Color(0xFF1C7AF4),
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: CustomButton(
              backgroundColor: Color(0xFF1C7AF4),
              width: (Get.width - 75) / 2,
              height: 34,
              radius: 17,
              title: '商城下订',
              titleColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearStoreItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '附近特约店',
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Obx(() => CustomButton(
                    backgroundColor: Colors.transparent,
                    image: 'assets/images/wow/active_addr_grey.png',
                    imageW: 13,
                    imageH: 17,
                    title: controller.locationSuccess.value
                        ? '刷新位置'
                        : '定位失败，点击重新定位',
                    fontSize: 12,
                    titleColor: Color(0xFFA0A0A0),
                    onPressed: () => controller.refreshLocation(),
                  )),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Image.asset('assets/images/car/car_store_kv.png'),
          ),
          Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.nearStoreList.value.data.length,
              itemBuilder: ((context, index) {
                NearStoreModel _model =
                    controller.nearStoreList.value.data[index];
                return _buildSingleStoreItem(index, _model);
              }))),
        ],
      ),
    );
  }

  Widget _buildSingleStoreItem(int index, NearStoreModel model) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.fShopName,
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Image.asset(
                                'assets/images/wow/active_addr_blue.png',
                                width: 11,
                                height: 13,
                              ),
                            ),
                            Expanded(
                                child: Text(
                              model.fShopAddr,
                              style: TextStyle(fontSize: 12),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CustomButton(
                backgroundColor: Colors.transparent,
                image: 'assets/images/car/car_store_phone.png',
                imageH: 37,
                imageW: 37,
                onPressed: () => controller.callPhoneNumber(model.fSalesPhone),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            height: (index == 1) ? 0 : 0.5,
            color: Color(0xFFADADAD),
          ),
        ],
      ),
    );
  }
}