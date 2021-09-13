import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/enjoy/gallery_mall_model.dart';
import 'package:ws_app_flutter/view_models/enjoy/enjoy_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class EnjoyPage extends GetView<EnjoyController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/common/bg.png',
          width: Get.width,
          height: Get.height / 2,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: ScreenUtil.getInstance().statusBarHeight + 60,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFF3F3F3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight,
              left: 15,
              right: 15),
          width: Get.width,
          height: 60,
          child: _buildHeader(),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().statusBarHeight + 60),
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: Get.width,
          child: _buildBody(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              //头像
              GestureDetector(
                onTap: () => controller.buttonAction(1000),
                child: Stack(
                  children: <Widget>[
                    Obx(() => RoundAvatar(
                          imageUrl: Get.find<UserController>()
                              .userInfo
                              .value
                              .member
                              ?.headImg,
                          borderWidth: 0,
                          borderColor: Colors.transparent,
                          height: 40,
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Offstage(
                          offstage: !(Get.find<UserController>()
                              .userInfo
                              .value
                              .member!
                              .isVehicle!),
                          child: Image.asset(
                            'assets/images/mine/vip_tag.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          )),
                    )
                  ],
                ),
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Obx(() => Text(
                      (Get.find<UserController>()
                                  .userInfo
                                  .value
                                  .member!
                                  .showName!
                                  .length >
                              11)
                          ? Get.find<UserController>()
                              .userInfo
                              .value
                              .member!
                              .showName!
                              .substring(0, 11)
                          : Get.find<UserController>()
                              .userInfo
                              .value
                              .member!
                              .showName!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
              )),
              // 销售员或者勋章标签
              if (Get.find<UserController>()
                  .userInfo
                  .value
                  .member!
                  .memberInfo!
                  .showTag!)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: MedalWidget(
                    medalBtnImage: Get.find<UserController>()
                        .userInfo
                        .value
                        .member!
                        .memberInfo!
                        .medalOrSaleImageName!,
                    medalToastImage: Get.find<UserController>()
                        .userInfo
                        .value
                        .member!
                        .memberInfo!
                        .medalOrSaleDescImageName!,
                    isSales: Get.find<UserController>()
                            .userInfo
                            .value
                            .member!
                            .memberInfo!
                            .isSales ==
                        1,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: <Widget>[
              Obx(() => CustomButton(
                    backgroundColor: Colors.transparent,
                    image: 'assets/images/circle/enjoy_point.png',
                    imageH: 18,
                    imageW: 18,
                    title: TextUtil.formatComma3(Get.find<UserController>()
                        .userInfo
                        .value
                        .member!
                        .integral!),
                    titleColor: Colors.white,
                    fontSize: 12,
                    onPressed: () => controller.buttonAction(1002),
                  )),
              SizedBox(
                width: 5,
              ),
              CustomButton(
                width: 80,
                height: 34,
                backgroundColor: Colors.transparent,
                radius: 17,
                borderWidth: 1.0,
                borderColor: Colors.white,
                title: '积分规则',
                titleColor: Colors.white,
                fontSize: 13,
                onPressed: () => controller.buttonAction(1003),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.refresh(),
        enablePullUp: true,
        onLoading: () => controller.loadMore(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 2, right: 2, bottom: 18),
                    child: GestureDetector(
                      onTap: () => controller.elwyKVClickAction(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Obx(() => NetImageWidget(
                              width: Get.width - 34,
                              height: (Get.width - 34) * 220 / 341,
                              imageUrl:
                                  controller.futcModel.value.list?.imageUrl,
                              fit: BoxFit.contain,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomButton(
                          width: (Get.width - 60) / 3,
                          height: 40,
                          image: 'assets/images/enjoy/enjoy_switch_by.png',
                          imageW: (Get.width - 60) / 3,
                          imageH: 40,
                          onPressed: () => controller.buttonAction(1004),
                        ),
                        CustomButton(
                          width: (Get.width - 60) / 3,
                          height: 40,
                          image: 'assets/images/enjoy/enjoy_big_awards.png',
                          imageW: (Get.width - 60) / 3,
                          imageH: 40,
                          onPressed: () => controller.buttonAction(1005),
                        ),
                        CustomButton(
                          width: (Get.width - 60) / 3,
                          height: 40,
                          image: 'assets/images/enjoy/enjoy_wish.png',
                          imageW: (Get.width - 60) / 3,
                          imageH: 40,
                          onPressed: () => controller.buttonAction(1006),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                    height: 0.5,
                    color: Color(0xFFDADADA),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/enjoy/enjoy_wow.png',
                              width: 40,
                              height: 13.5,
                            ),
                            Text(
                              '·兑换',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        CustomButton(
                          backgroundColor: Colors.transparent,
                          width: 70,
                          height: 20,
                          title: '更多',
                          fontSize: 12,
                          image: 'assets/images/enjoy/enjoy_right_arrow.png',
                          imageW: 9,
                          imageH: 15,
                          imagePosition: XJImagePosition.XJImagePositionRight,
                          onPressed: () => controller.buttonAction(1007),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => SliverStaggeredGrid.countBuilder(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  return _buildGridItem(index);
                },
                itemCount: controller.list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    ShopModel model = controller.list[index];
    return GestureDetector(
        onTap: () => controller.pushDetailH5(model),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  NetImageWidget(
                    imageUrl: model.image,
                    width: (Get.width - 50) / 3,
                    height: (Get.width - 50) / 3,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Offstage(
                      offstage: !model.typeVip!,
                      child: Image.asset(
                        'assets/images/enjoy/icon_car_owner.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10),
              ),
            ),
            Offstage(
              offstage: int.parse(model.deduction!) == 0,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/enjoy/enjoy_price_point_red.png',
                    width: 7.5,
                    height: 8,
                  ),
                  Flexible(
                    child: Text(
                      TextUtil.formatComma3(model.deduction!),
                      style: TextStyle(color: Color(0xFFE30052), fontSize: 12),
                    ),
                  ),
                  Image.asset(
                    'assets/images/enjoy/car_owner_tag.png',
                    width: 40,
                    height: 11,
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: int.parse(model.integral!) == 0,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/enjoy/enjoy_price_point.png',
                    width: 7.5,
                    height: 8,
                  ),
                  Flexible(
                    child: Text(
                      TextUtil.formatComma3(model.integral!),
                      style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 12),
                    ),
                  ),
                  Image.asset(
                    'assets/images/enjoy/normal_user_tag.png',
                    width: 40,
                    height: 11,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
