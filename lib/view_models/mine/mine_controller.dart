import 'package:flustars/flustars.dart';
import 'package:ws_app_flutter/models/mine/favor.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';

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

  void listItemClick(int index) {
    LogUtil.v('点击了$index行');
    if (index == 9) {
      Get.toNamed(Routes.SETTING);
    }
  }
}
