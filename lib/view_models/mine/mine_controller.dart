import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/common/test_drive_receive.dart';
import 'package:ws_app_flutter/models/mine/favor.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class MineController extends BaseController {
  List<Map<String, String>> data = <Map<String, String>>[];
  var favorModel = FavorModel().obs;
  bool shouldShowTestDrive = false;//是否显示用户试驾菜单

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  void initData() {
    _requestFavorData();
    _requestTestDrive();
  }

  //收藏、活动数据
  void _requestFavorData() async {
    favorModel.value = await DioManager()
        .request<FavorModel>(DioManager.GET, Api.mineFavorActivityUrl);
  }

  //用户试驾
  void _requestTestDrive() async {
    TestDriveReceive res = await DioManager().request<TestDriveReceive>(DioManager.GET,'gq/api/employee/state/${Get.find<UserController>().userInfo.value.member?.memberId}');
    shouldShowTestDrive = res.data!;
    configListData();
  }

  void configListData() {
    if (shouldShowTestDrive) {
      data = [
      {"imageName": "", "title": ""},
      {"imageName": "assets/images/mine/mine_circle.png", "title": "我的好友"},
      {"imageName": "assets/images/mine/mine_faq.png", "title": "我的问答"},
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
    } else {

    }
  }

  void pushAction(int actionTag) {
    if (actionTag == 1) {
      //我的好友
      Get.find<UserController>().requestIMInfoAndLogin().then((value) {
        if (value) {
          Get.toNamed(Routes.MINEFRIENDS)?.then((value) {
            _requestFavorData();
            Get.find<UserController>().requestNewMessage();
          });
        }
      });
    } else if (actionTag == 2) {
      //我的问答
      Get.toNamed(Routes.MINEFAQ)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 3) {
      //每日签到
      Get.toNamed(Routes.SIGNPAGE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 4) {
      //常见问题
      Get.toNamed(Routes.NORMALQUESTIONPAGE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 5) {
      //认证信息
      if (Get.find<UserController>().userInfo.value.member!.isVehicle!) {
        Get.toNamed(Routes.CERTIFYINFOPAGE)?.then((value) {
          _requestFavorData();
          Get.find<UserController>().requestNewMessage();
        });
      } else {
        Get.find<UserController>().certifyVechile();
      }
    } else if (actionTag == 6) {
      //检查报告
      Get.toNamed(Routes.CHECKREPORTPAGE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 7) {
      //e路无忧
      Get.toNamed(Routes.ELWYPAGE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 8) {
      //中奖记录
      Get.toNamed(Routes.WINLISTRECORD)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 9) {
      //兑换订单
      Get.toNamed(Routes.ORDERLISTROUTE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 10) {
      //设置
      Get.toNamed(Routes.SETTING)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1000) {
      //扫一扫
      Get.toNamed(Routes.SCAN)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1001) {
      //我的客服
      //TODO
    } else if (actionTag == 1002) {
      //消息中心
      Get.find<UserController>().requestIMInfoAndLogin().then((value) {
        if (value) {
          Get.toNamed(Routes.MSGCENTER)?.then((value) {
            _requestFavorData();
            Get.find<UserController>().requestNewMessage();
          });
        }
      });
    } else if (actionTag == 1003) {
      //个人信息
      Get.toNamed(Routes.MINEINFO)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1005) {
      //圈子
      Get.toNamed(Routes.MINECIRCLE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1006) {
      //收藏
      Get.toNamed(Routes.MYFAVORPAGE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1007) {
      //活动
      Get.toNamed(Routes.MYACTIVITYPAGE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    } else if (actionTag == 1008) {
      //积分
      Get.toNamed(Routes.INTEGRALPAGE)?.then((value) {
        _requestFavorData();
        Get.find<UserController>().requestNewMessage();
      });
    }
  }
}
