import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/mine/shop_list_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class ShopListController extends ListController<ShopAddressModel> {
  @override
  Future<List<ShopAddressModel>?> loadData() async {
    ShopAddressListModel _model = await DioManager()
        .request<ShopAddressListModel>(
            DioManager.POST, Api.mineTakeGoodsAddressListUrl);
    return _model.list;
  }

  void editAction({ShopAddressModel? model}) {
    if (model == null) {
      Get.toNamed(Routes.MINEADDSHOP,
          arguments: {'addnew': true});
    } else {
      Get.toNamed(Routes.MINEADDSHOP,
          arguments: {'model': model, 'addnew': false});
    }
  }

  void deleteAction(ShopAddressModel model) {
    Get.dialog(
        BaseDialog(
          title: '删除收货地址',
          content: Text(
            '确认删除？',
            style: TextStyle(fontSize: 16),
          ),
          onConfirm: () async {
            CommonModel _model = await DioManager().request<CommonModel>(
                DioManager.POST, 'm/my-receiver-delete-${model.addrId}.html');
            if (_model.success != null) {
              list.remove(model);
            } else if (_model.error != null) {
              EasyLoading.showToast(_model.error!,
                  toastPosition: EasyLoadingToastPosition.bottom);
            }
          },
        ),
        barrierDismissible: false);
  }
}
