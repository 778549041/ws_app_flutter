import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/common/img_model.dart';
import 'package:ws_app_flutter/models/enjoy/product_detail_model.dart';
import 'package:ws_app_flutter/models/mine/shop_list_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/widgets/enjoy/notset_paycode.dart';
import 'package:ws_app_flutter/widgets/enjoy/paycode_alert.dart';

class ExchangeProductController extends GetxController {
  final String productid = Get.arguments['product_id'];
  var model = ProductDetailModel().obs;
  var currentAddress = ShopAddressModel().obs;
  var count = 1.obs;
  String paycode = '';

  @override
  void onInit() async {
    super.onInit();
    ProductDetailModel _model = await DioManager().request<ProductDetailModel>(
        DioManager.POST, 'm/integralmallexchange-$productid-1.html');
    ImgListModel imgListModel = await DioManager()
        .request<ImgListModel>(DioManager.POST, 'openapi/storager/m', params: {
      'images': [_model.goods!.product!.imageId!]
    });
    _model.goods!.product!.imagePath = imgListModel.data?.first;
    model.value = _model;
    currentAddress.value = _model.member_addrs!.first;
  }

  void pushAddressList() {
    Get.toNamed(Routes.MINESHOPADDRLIST, arguments: {'shouldBack': true})!
        .then((value) {
      currentAddress.value = value;
    });
  }

  void exchangeProduct() {
    Get.dialog(
      PayCodeAlert(model.value.relgoods!.deduction! * count.value),
      barrierDismissible: true,
    );
  }

  void confirmExchange() async {
    Get.back();
    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.POST, 'm/integralmallexchange-crate_order.html',
        params: {
          'product_id': productid,
          'quantity': count.value,
          'pay_password': paycode,
          'isvirtual': model.value.goods!.isVirtual!,
          'addr_id': currentAddress.value.addrId!,
          'dlytype_id': '1',
          'payapp_id': 'integraldeduction'
        });
    if (result.error == '未设置支付密码') {
      Get.dialog(
        NotsetPaycodeAlert(),
        barrierDismissible: false,
      );
    } else if (result.error == '支付密码错误') {
      EasyLoading.showToast('支付密码错误',
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast('兑换失败',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
