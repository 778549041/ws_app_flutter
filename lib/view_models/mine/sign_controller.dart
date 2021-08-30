import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/sign_data.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';

class SignController extends GetxController {
  final DateTime firstDay = DateTime(1970, 1, 1);
  final DateTime lastDay = DateTime(DateTime.now().year + 10, 12, 31);
  var hasSign = false.obs; //是否签到
  var tipScore = ''.obs; //签到积分
  var signDays = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getSignData();
  }

  void getSignData() async {
    SignData data =
        await DioManager().request<SignData>(DioManager.GET, Api.signDataUrl);
    hasSign.value = data.hasSignin!;
    if (data.signinLogs != null) {
      Signin_logs signin_logs = data.signinLogs![0];
      tipScore.value = signin_logs.rewardsTitle!;
      for (var signLog in data.signinLogs!) {
        String tempDateStr = signLog.currentYear! + signLog.currentMonth! + signLog.currentDay!;
        signDays.add(tempDateStr);
      }
      print(signDays);
    }
  }

  void signEvent() async {
    SignEventResult result = await DioManager()
        .request<SignEventResult>(DioManager.GET, Api.signEventUrl);
    if (result.success != null) {
      getSignData();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
