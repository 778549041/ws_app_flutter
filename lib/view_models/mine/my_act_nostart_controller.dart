import 'package:ws_app_flutter/models/common/img_model.dart';
import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class MyActNostartController extends RefreshListController<ActivityModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<ActivityModel>?> loadData({int pageNum = 1}) async {
    ActivityListModel model = await DioManager().request<ActivityListModel>(
        DioManager.GET, 'm/huodong-my-$pageNum-10-nostart.html');
    for (var newmodel in model.list!) {
      ImgListModel imgListModel = await DioManager().request<ImgListModel>(
          DioManager.POST, 'openapi/storager/m',
          params: {
            'images': [newmodel.imageId]
          });
      newmodel.imgUrl = imgListModel.data?.first;
    }
    return model.list;
  }
}