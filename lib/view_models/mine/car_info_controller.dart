import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/control_bind_info_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class CarInfoController extends GetxController {
  var data = [].obs;

  @override
  void onInit() {
    super.onInit();
    getCarInfo();
  }

  void getCarInfo() async {
    ControlBindInfoModel model = await DioManager()
        .request<ControlBindInfoModel>(DioManager.GET, Api.carInfoUrl);
    data.assignAll([
      {
        "title": "姓名",
        "content": model.data?.name == null
            ? ''
            : model.data!.name!
      },
      {
        "title": "身份证号",
        "content": (model.data?.id_card == null || model.data!.id_card! == '')
            ? ''
            : model.data!.id_card!.length > 10
                ? model.data!.id_card!.replaceRange(3, 10, '*******')
                : model.data!.id_card!,
      },
      {
        "title": "手机号",
        "content": (model.data?.mobile == null || model.data!.mobile! == '')
            ? ''
            : model.data!.mobile!.length > 10
                ? model.data!.mobile!.replaceRange(3, 7, '****')
                : model.data!.mobile!
      },
      {
        "title": "发动机号码",
        "content": (model.data?.engine_number == null ||
                model.data!.engine_number! == '')
            ? ''
            : model.data!.engine_number!.length > 6
                ? model.data!.engine_number!.replaceRange(2, 6, '****')
                : model.data!.engine_number!,
      },
      {
        "title": "车架号",
        "content": Get.find<UserController>()
            .userInfo
            .value
            .member!
            .fVIN!
            .replaceRange(5, 12, '*******')
      },
      {
        "title": "品牌型号",
        "content": model.data?.brand == null ? '' : model.data!.brand!
      },
    ]);
  }

  void submitAction() {
    Get.toNamed(Routes.UNBINDCAR);
  }
}
