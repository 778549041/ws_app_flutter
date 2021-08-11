import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/wow/category_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/view_models/wow/wow_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class CommonUtil {
  //获取uuid
  static String sid() {
    String? sid = SpUtil.getString(SID_KEY);
    if (ObjectUtil.isEmptyString(sid)) {
      sid = Uuid().v1();
      SpUtil.putString(SID_KEY, sid);
    }
    //b55b8c00-85d7-11ea-af6d-09351c0892b3
    return sid!;
  }

  //检查密码格式
  static bool checkPwd(String? input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp("^([A-Za-z0-9]){6,12}\$").hasMatch(input);
  }

  //检查支付密码格式
  static bool checkPayPwd(String? input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp("([0-9])\1{1}").hasMatch(input);
  }

  //检查字符串是否包含url地址
  static bool containsLink(String? source) {
    if (source == null || source.isEmpty) return false;
    return new RegExp(
            r"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)")
        .hasMatch(source);
  }

  //检查字符串是否为空或全为空格
  static bool isBlank(String? source) {
    if (source == null || source.isEmpty) return true;
    source = source.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    if (source.length == 0) return true;
    return false;
  }

  //非车主用户操作车主功能弹框提示
  static void userNotVechileToast(String message) {
    Get.dialog(
        BaseDialog(
          title: '提示',
          rightText: '马上认证',
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(message, style: TextStyle(fontSize: 16.0)),
          ),
          onConfirm: () {
            Get.find<UserController>().certifyVechile();
          },
        ),
        barrierDismissible: false);
  }

  //服务端接口控制跳转页面
  static void serviceControlPushPage(
      {String? type, String? detailId, String? url, bool? hasNav}) {
    if (type == 'H5' && url != null) {
      Get.toNamed(Routes.WEBVIEW, arguments: {
        'url': url,
        'hasNav': hasNav,
      });
    } else if (type == "zixun_list") {
      //资讯列表
      CategoryModel model = CategoryModel();
      model.nodeId = detailId!;
      Get.toNamed(Routes.CATENEWSLIST, arguments: {'model': model});
    } else if (type == "zixun_detail") {
      //资讯详情
      Get.toNamed(Routes.NEWSDETAIL, arguments: {'article_id': detailId});
    } else if (type == "huodong_list") {
      //活动列表
      if (Get.currentRoute != Routes.HOME) {
        Get.until((route) => Get.currentRoute == Routes.HOME);
      }
      Get.find<MainController>().onItemTap(0);
      Get.find<WowController>().tabClick(1);
    } else if (type == "dianzhaung") {
      //附近电桩
      Get.toNamed(Routes.NEARDZMAP);
    } else if (type == "topic_list") {
      //话题圈子列表
      Get.toNamed(Routes.CIRCLTOPICLIST, arguments: {'topcid': detailId});
    } else if (type == "topic_detail") {
      //圈子详情
      Get.toNamed(Routes.CIRCLEDETAIL, arguments: {'circle_id': detailId});
    } else if (type == "customerService") {
      //在线客服
      //TODO
    }
  }

  //图片地址转id
  static Future getCoveridsString(
      List<String> imgUrlList, String fileType) async {
    String imgIDListStr = '';
    for (var i = 0; i < imgUrlList.length; i++) {
      CommonModel model = await DioManager().request<CommonModel>(
          DioManager.POST, Api.convertIDToUrl,
          params: {'url': imgUrlList[i], 'type': fileType});
      if (i == 0) {
        imgIDListStr = model.id!;
      } else {
        imgIDListStr = imgIDListStr + '|' + model.id!;
      }
    }
    return imgIDListStr;
  }

  //图片路径
  static String qnImageFilePatName() {
    String now =
        DateUtil.formatDateStr(DateUtil.getNowDateStr(), format: 'yyyyMMdd');
    String name = 'Picture/$now/${DateUtil.getNowDateMs()}${Uuid().v1()}.jpg';
    return name;
  }

  //视频路径
  static String qnVideoFilePatName() {
    String now =
        DateUtil.formatDateStr(DateUtil.getNowDateStr(), format: 'yyyyMMdd');
    String name = 'Video/$now/${DateUtil.getNowDateMs()}${Uuid().v1()}.mp4';
    return name;
  }
}
