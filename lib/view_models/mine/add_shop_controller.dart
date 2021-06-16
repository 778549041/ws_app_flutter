import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/shop_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/shop_list_controller.dart';

class AddShopController extends GetxController {
  var model = ShopAddressModel().obs;
  var isDefault = false.obs;
  var area = ''.obs;

  @override
  void onInit() {
    final ShopAddressModel shopModel =
        Get.arguments == null ? null : Get.arguments['model']; //修改地址传过来的参数
    if (shopModel != null) {
      model.value = shopModel;
      isDefault.value = shopModel.isDefault;
      area.value = (shopModel.area.contains('mainland')
          ? shopModel.area.split(':')[1]
          : shopModel.area);
    } else {
      area.value = '请选城市';
    }
    super.onInit();
  }

  //选择地址
  void selectAddress() async {
    Pickers.showAddressPicker(
      Get.context,
      initTown: '',
      addAllItem: false,
      onConfirm: (province, city, town) {
        area.value = province + '/' + city + '/' + town;
      },
    );
  }

  Future submitted() async {
    if (model.value.name.length == 0 ||
        model.value.mobile.length == 0 ||
        area.value.length == 0 ||
        model.value.addr.length == 0) {
      EasyLoading.showToast('信息不完善',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    if (!RegexUtil.isMobileExact(model.value.mobile)) {
      EasyLoading.showToast('手机号格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    Map<String, dynamic> _params = Map<String, String>();
    if (model.value.addrId.length > 0) {
      _params['maddr[addr_id]'] = model.value.addrId;
    }
    _params['maddr[name]'] = model.value.name;
    _params['maddr[addr]'] = model.value.addr;
    _params['maddr[mobile]'] = model.value.mobile;
    _params['maddr[is_default]'] = isDefault.value.toString();
    _params['maddr[area]'] = model.value.area;
    await DioManager().request(DioManager.POST, Api.changedTakeGoodsAddressUrl,
        params: _params);
    EasyLoading.showToast('保存成功',
        toastPosition: EasyLoadingToastPosition.bottom);
    Future.delayed(Duration(seconds: 1)).then((value) async {
      await Get.find<ShopListController>().refresh();
      Get.back();
    });
  }
}
