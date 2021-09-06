import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/img_model.dart';
import 'package:ws_app_flutter/models/enjoy/product_detail_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';

class ProductDetailController extends GetxController {
  final String productid = Get.arguments['product_id'];
  var model = ProductDetailModel().obs;

  @override
  void onInit() async {
    super.onInit();
    ProductDetailModel _model = await DioManager().request<ProductDetailModel>(
        DioManager.POST, 'm/integralmalldetail-$productid.html');
    ImgListModel imgListModel = await DioManager()
        .request<ImgListModel>(DioManager.POST, 'openapi/storager/m', params: {
      'images': [_model.dataDetail!.product!.imageId!]
    });
    _model.dataDetail!.product!.imagePath = imgListModel.data?.first;
    model.value = _model;
  }

  void clickExchange() {
    if (int.parse(Get.find<UserController>().userInfo.value.member!.integral!) >
            model.value.relgoods!.deduction! &&
        int.parse(Get.find<UserController>().userInfo.value.member!.integral!) >
            model.value.relgoods!.integral!) {
      Get.toNamed(Routes.EXCHANGEPRODUCT,arguments: {'product_id':productid});
    } else {
      EasyLoading.showToast('积分不足',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
