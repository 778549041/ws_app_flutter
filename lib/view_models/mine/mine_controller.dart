import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/mine/favor.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class MineController extends BaseController {
  List<Map<String, String>> data = List<Map<String, String>>();
  var favorModel = FavorModel().obs;

  @override
  void onInit() {
    data = [
      {"imageName": "", "title": ""},
      {"imageName": "assets/images/mine/mine_circle.png", "title": "我的好友"},
      {"imageName": "assets/images/mine/mine_sign.png", "title": "每日签到"},
      {
        "imageName": "assets/images/mine/mine_normal_question.png",
        "title": "常见问题"
      },
      {
        "imageName": "assets/images/mine/mine_certify_info.png",
        "title": "认证信息"
      },
      {
        "imageName": "assets/images/mine/mine_check_report.png",
        "title": "检查报告"
      },
      {"imageName": "assets/images/mine/mine_elwy.png", "title": "e路无忧"},
      {"imageName": "assets/images/mine/mine_win_list.png", "title": "中奖记录"},
      {"imageName": "assets/images/mine/mine_order.png", "title": "兑换订单"},
      {"imageName": "assets/images/mine/mine_setting.png", "title": "设置"},
    ];
    super.onInit();
  }

  @override
  void onReady() {
    requestFavorData();
    super.onReady();
  }

  Future requestFavorData() async {
    favorModel.value = await DioManager()
        .request<FavorModel>(DioManager.GET, Api.mineFavorActivityUrl);
  }

  void pushAction(int actionTag) {
    if (actionTag == 1) {
      //我的好友
      Get.toNamed(Routes.MINEFRIENDS);
    } else if (actionTag == 2) {
      //每日签到
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.DaylySignPage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 3) {
      //常见问题
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.FAQPage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 4) {
      //认证信息
      if (Get.find<UserController>().userInfo.value.member.isVehicle ==
          'true') {
        pushH5Page(args: {
          'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.CarOwnerCertifyInfoPage,
        }).then((value) async {
          requestFavorData();
          await Get.find<UserController>().requestNewMessage();
        });
      } else {
        Get.find<UserController>().certifyVechile();
      }
    } else if (actionTag == 5) {
      //检查报告
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.CheckReportPage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 6) {
      //e路无忧
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.MyServicePackagePage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 7) {
      //中奖记录
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.WinrecordPage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 8) {
      //兑换订单
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.ExchangeOrderPage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 9) {
      //设置
      Get.toNamed(Routes.SETTING).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1000) {
      //扫一扫
      Get.toNamed(Routes.SCAN).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1001) {
      //我的客服
      //TODO
    } else if (actionTag == 1002) {
      //消息中心
      Get.find<UserController>().requestIMInfoAndLogin().then((value) {
        if (value) {
          Get.toNamed(Routes.MSGCENTER).then((value) async {
            requestFavorData();
            await Get.find<UserController>().requestNewMessage();
          });
        }
      });
    } else if (actionTag == 1003) {
      //个人信息
      Get.toNamed(Routes.MINEINFO).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1004) {
      //勋章
      //TODO
    } else if (actionTag == 1005) {
      //圈子
      Get.toNamed(Routes.SINGLECIRCLELIST, arguments: {
        'memberId': Get.find<UserController>().userInfo.value.member.memberId
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1006) {
      //收藏
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.MyFavortePage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1007) {
      //活动
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.MyActivityPage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1008) {
      //积分
      pushH5Page(args: {
        'url': CacheKey.SERVICE_URL_HOST + HtmlUrls.IntegralDetailPage,
      }).then((value) async {
        requestFavorData();
        await Get.find<UserController>().requestNewMessage();
      });
    }
  }
}
