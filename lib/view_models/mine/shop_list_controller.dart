import 'package:ws_app_flutter/models/mine/shop_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';

class ShopListController extends ListController {
  @override
  Future<List> loadData() async {
    ShopAddressListModel _model = await DioManager()
        .request<ShopAddressListModel>(
            DioManager.POST, Api.mineTakeGoodsAddressListUrl);
    return _model.list;
  }
}
