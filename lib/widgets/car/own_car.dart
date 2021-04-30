import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/eletric_controller.dart';
import 'package:ws_app_flutter/widgets/car/flash_view.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class OwnCarWidget extends GetView<EletricController> {
  final List<Map<String, dynamic>> _gridData = [
    {'image': 'assets/images/car/car_cdz.png', 'title': '附近电桩'},
    {'image': 'assets/images/car/car_map_nav.png', 'title': '实时导航'},
    {'image': 'assets/images/car/car_part.png', 'title': '爱车配件'},
    {'image': 'assets/images/car/car_360.png', 'title': '电池诊断'},
    {'image': 'assets/images/car/car_miles.png', 'title': '里程信息'},
    {'image': 'assets/images/car/car_illegal.png', 'title': '违章查询'},
    {'image': 'assets/images/car/car_baoyang.png', 'title': '预约保养'},
    {'image': 'assets/images/car/car_sos.png', 'title': '一键救援'},
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Obx(() => Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'assets/images/car/car_flash.png',
                      width: ScreenUtil.getInstance().getWidth(250),
                      height:
                          ScreenUtil.getInstance().getWidth(250) * 766 / 502,
                      fit: BoxFit.fitHeight,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Text(
                            controller.carDataModel.value.datas.rspBody.soc
                                    .toString() +
                                '%',
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        ),
                        Text(
                          controller.charging.value ? '充电中' : '剩余电量',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        if (controller
                                .carDataModel.value.datas.fcarColorURL.length >
                            0)
                          Container(
                            margin: const EdgeInsets.only(top: 25),
                            child: CachedNetworkImage(
                                imageUrl: controller
                                    .carDataModel.value.datas.fcarColorURL),
                          ),
                        Container(
                          margin: const EdgeInsets.only(top: 25),
                          child: Text(
                            controller.carDataModel.value.datas.fcarColor,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/car/car_dashboard.png',
                                width: 21.5,
                                height: 13.5,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '可续航里程 ',
                                    style: TextStyle(
                                        color: Color(0xFF2674FB), fontSize: 15),
                                    children: [
                                      TextSpan(
                                          text: controller.carDataModel.value
                                              .datas.rspBody.rangMileage
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(0xFF1B7DF4),
                                              fontSize: 24)),
                                      TextSpan(
                                        text: ' km',
                                        style: TextStyle(
                                            color: Color(0xFF2674FB),
                                            fontSize: 15),
                                      )
                                    ]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Offstage(
                      offstage: !controller.charging.value,
                      child: FlashView(
                        height:
                            ScreenUtil.getInstance().getWidth(250) * 766 / 502,
                      ),
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              height: Get.width / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: GridView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _gridData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> _item = _gridData[index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFF3F3F3), width: 0.5)),
                        child: CustomButton(
                          image: _item['image'],
                          imageH: 28,
                          imageW: 28,
                          title: _item['title'],
                          fontSize: 12,
                          imagePosition: XJImagePosition.XJImagePositionTop,
                          onPressed: () => buttonAction(index),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future buttonAction(int index) async {
    if (index == 0) {
      //附近电桩
      Get.toNamed(Routes.NEARDZMAP);
    } else if (index == 1) {
      //实时导航
      Get.toNamed(Routes.NAVMAP);
    } else if (index == 2) {
      //爱车配件
      Get.toNamed(Routes.WEBVIEW, arguments: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.CarPartsPage
      });
    } else if (index == 3) {
      //电池诊断
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        Get.toNamed(Routes.WEBVIEW, arguments: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.BatteryDiagonisPage
        });
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 4) {
      //里程信息
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        Get.toNamed(Routes.WEBVIEW, arguments: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.MilesInfoPage
        });
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 5) {
      //违章查询
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        Get.toNamed(Routes.WEBVIEW, arguments: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.ViolationPage
        });
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 6) {
      //预约保养
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        CommonModel _model = await DioManager().request<CommonModel>(
            DioManager.POST, Api.reservationMaintainUrl,
            params: {
              'unionId':
                  Get.find<UserController>().userInfo.value.member.unionid,
              'vin': Get.find<UserController>().userInfo.value.member.fVIN
            });
        if (_model.datas != null && _model.datas.length > 0) {
          Get.toNamed(Routes.WEBVIEW, arguments: {
            'url': _model.datas,
            'title': '预约保养',
            'hasNav': true,
          });
        } else {
          EasyLoading.showToast(_model.message,
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    } else if (index == 7) {
      //一键救援
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        //拨号
        if (await canLaunch('tel:400-830-8999')) {
          launch('tel:400-830-8999');
        }
      } else {
        CommonUtil.userNotVechileToast('认证车主才可以使用此功能哦，先去认证成为车主吧！');
      }
    }
  }
}
