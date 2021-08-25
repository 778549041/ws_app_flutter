import 'package:ws_app_flutter/models/common/img_model.dart';
import 'package:ws_app_flutter/models/mine/order_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class OrderListController extends RefreshListController<OrderModel> {

  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<OrderModel>?> loadData({int pageNum = 1}) async {
    OrderListModel model = await DioManager().request<OrderListModel>(
        DioManager.GET, 'm/my-orders-all-$pageNum.html');
    for (var orderModel in model.orderList!) {
      if (model.orderItemsGroup != null) {
        ImgListModel imgListModel = await DioManager().request<ImgListModel>(
            DioManager.POST, 'openapi/storager/m',
            params: {
              'images': [
                model.orderItemsGroup![orderModel.orderId][0]['image_id']
              ]
            });
        orderModel.imageurl = imgListModel.data?.first;
        orderModel.name = model.orderItemsGroup![orderModel.orderId][0]['name'];
        orderModel.ticketCode =
            model.orderItemsGroup![orderModel.orderId][0]['ticket_code'];
      }
    }
    return model.orderList;
  }
}
