import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/cache_manager/cache_manager.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class SettingController extends GetxController {
  var data = List().obs;

  @override
  void onInit() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String cache = await CacheManager().loadCache();
    data.assignAll([
      {"title": "管理密码", "content": ""},
      {"title": "清除缓存", "content": cache},
      {"title": "意见反馈", "content": ""},
      {"title": "版本信息", "content": ''},
      {"title": "隐私政策", "content": version}
    ]);
    super.onInit();
  }

  void listItemClick(int index) {
    if (index == 0) {
    } else if (index == 1) {
      CacheManager().clearCache().then((result) {
        if (result) {
          onInit();
        }
      });
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {}
  }

  Future deleteUser() async {
    CommonModel _model =  await DioManager().request<CommonModel>(DioManager.GET, Api.unbindVechileUrl);
    if (_model.result) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        Get.offAllNamed(Routes.LOGIN);
      });
    }
  }

  //拨号
  void callPhoneNumber() async {
    if (await canLaunch('tel:400-830-8999')) {
      launch('tel:400-830-8999');
    }
  }
}
