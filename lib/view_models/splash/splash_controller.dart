import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/models/splash/splash_model.dart';
import 'package:ws_app_flutter/routes/routes.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class SplashController extends BaseController {
  TimerUtil _timerUtil;

  var splashModel = SplashModel(data: SplashData()).obs;
  var count = 3.obs;
  var firstLaunch = true.obs;

  @override
  void onInit() {
    super.onInit();
    firstLaunch.value = SpUtil.getBool(CacheKey.FIRSTLAUNCH, defValue: true);
  }

  @override
  void onReady() {
    super.onReady();
    if (firstLaunch.value) {
      //首次安装应用,引导页
      SpUtil.putBool(CacheKey.FIRSTLAUNCH, false);
    } else {
      DioManager().request<SplashModel>(
        DioManager.POST,
        Api.aDImageDataUrl,
        success: (SplashModel obj) {
          splashModel.value = obj;
          doCountDown();
        },
        error: (error) {
          showErrorMessage();
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (_timerUtil != null) _timerUtil.cancel();
  }

  void doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      count.value = _tick.toInt();
      if (_tick == 0) {
        goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void goMain() {
    if (Get.find<UserController>().isLogin.value) {
      Get.offNamed(AppPages.HOME);
    } else {
      Get.offNamed(AppPages.LOGIN);
    }
  }
}
