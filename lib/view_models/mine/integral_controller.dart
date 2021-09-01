import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';
import 'package:ws_app_flutter/view_models/mine/integral_income_controller.dart';
import 'package:ws_app_flutter/view_models/mine/integral_outcome_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class IntegralController extends GetxController {
  @override
  void onInit() {
    Get.lazyPut<IntegralIncomeController>(() => IntegralIncomeController());
    Get.lazyPut<IntegralOutcomeController>(() => IntegralOutcomeController());

    Get.find<UserController>().getUserInfo();
    super.onInit();
  }

  //选择日期
  void selectDate() {
    Pickers.showDatePicker(
      Get.context!,
      mode: DateMode.YM,
      onConfirm: (res) async {
        var selectDate;
        if (res.month! < 10) {
          selectDate = '${res.year!}-0${res.month!}';
        } else {
          selectDate = '${res.year!}-${res.month!}';
        }
        Get.find<IntegralIncomeController>().selectDate = selectDate;
        Get.find<IntegralIncomeController>().refresh();
        Get.find<IntegralOutcomeController>().selectDate = selectDate;
        Get.find<IntegralOutcomeController>().refresh();
      },
    );
  }

  void pushAction(int index) {
    if (index == 0) {
      //使用积分
      Get.back();
      Get.find<MainController>().onItemTap(3);
    } else if (index == 1) {
      //积分规则
      Get.toNamed(Routes.INTEGRALRULE);
    }
  }
}
