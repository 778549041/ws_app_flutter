import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/view_models/car/car_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class UnOwnCarWidget extends StatefulWidget {
  @override
  UnOwnCarWidgetState createState() => UnOwnCarWidgetState();
}

class UnOwnCarWidgetState extends State<UnOwnCarWidget>
    with WidgetsBindingObserver {
  final CarController controller = Get.put<CarController>(CarController());

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
            GestureDetector(
              onTap: () => controller.buttonAction(1000),
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                child: Image.asset('assets/images/car/car_uncertify_dz_kv.png'),
              ),
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
                clickInterval: 0,
                backgroundColor: Colors.transparent,
                width: 28,
                height: (Get.width - 80) * 36 / 75,
                image: 'assets/images/car/car_left_arrow.png',
                imageW: 9,
                imageH: 14,
                onPressed: () => controller.switchCarImageAction(false),
              ),
              Container(
                  width: Get.width - 80,
                  height: (Get.width - 80) * 36 / 75,
                  child: Obx(() => Swiper(
                      key: UniqueKey(),
                      controller: controller.swiperController,
                      // viewportFraction: 0.8,
                      //视图宽度，即显示的item的宽度屏占比
                      //scale: 0.9,
                      //两侧item的缩放比
                      onTap: (int index) => controller.buttonAction(1001),
                      loop: true,
                      onIndexChanged: (index) {
                        controller.currentIndex.value = index;
                        controller.colorSwiperController.move(index);
                      },
                      itemCount: controller.carImageList.length,
                      itemBuilder: (context, index) {
                        String _imageName = controller.carImageList[index];
                        return Image.asset(_imageName);
                      }))),
              CustomButton(
                backgroundColor: Colors.transparent,
                clickInterval: 0,
                width: 28,
                height: (Get.width - 80) * 36 / 75,
                image: 'assets/images/car/car_right_arrow.png',
                imageW: 9,
                imageH: 14,
                onPressed: () => controller.switchCarImageAction(true),
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
            onPressed: () => controller.buttonAction(1001),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 205,
          height: 10,
          child: Obx(() => Swiper(
              key: UniqueKey(),
              physics: NeverScrollableScrollPhysics(),
              controller: controller.colorSwiperController,
              viewportFraction: 1 / 7,
              //视图宽度，即显示的item的宽度屏占比
              scale: 0.5,
              //两侧item的缩放比
              onTap: (int index) {
                controller.swiperController.move(index);
              },
              itemCount: controller.carColorList.length,
              itemBuilder: (context, index) {
                var _item = controller.carColorList[index];
                return Container(
                  margin: const EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: _item['colors']),
                      border: index == 3
                          ? Border.all(color: Colors.black, width: 0.5)
                          : null),
                );
              })),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Image.asset(
            'assets/images/car/car_up_arrow.png',
            width: 6.5,
            height: 4,
          ),
        ),
        Obx(() => Text(
              controller.carColorList.length > 0
                  ? controller.carColorList[controller.currentIndex.value]
                      ['name']
                  : '',
              style: TextStyle(fontSize: 10),
            )),
      ],
    );
  }

  Widget _buildConfigItem() {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => controller.selectCarConfig(),
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
                Obx(() => Row(
                      children: <Widget>[
                        if (controller.currentConfig.value.imageName != null)
                          Image.asset(
                            controller.currentConfig.value.imageName,
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
                    ))
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
              Obx(() => Text(
                    controller.currentConfig.value.price,
                    style: TextStyle(fontSize: 12),
                  )),
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
            onPressed: () => controller.buttonAction(1002),
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
              onPressed: () => controller.buttonAction(1003),
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
                    onPressed: () =>
                        controller.refreshLocation(reloadLocation: true),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        controller.refreshLocation();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didUpdateWidget(UnOwnCarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
