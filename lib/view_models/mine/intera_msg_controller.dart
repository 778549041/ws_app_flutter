import 'package:ws_app_flutter/models/common/img_model.dart';
import 'package:ws_app_flutter/models/mine/intera_msg_model.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class InteraMsgController extends RefreshListController<InteraModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<InteraModel>?> loadData({int pageNum = 1}) async {
    InteraMsgModel model = await DioManager().request<InteraMsgModel>(
        DioManager.GET, 'm/friends-interaction-$pageNum-10.html');
    for (var interaModel in model.list!) {
      if (model.memberList != null) {
        Map? member = model.memberList![interaModel.proMemberId];
        if (member == null) {
          interaModel.avatar = null;
          interaModel.name = '无昵称';
        } else {
          String? avatar = asT<String?>(member['avatar']);
          if (avatar == null) {
            interaModel.avatar = null;
          } else {
            ImgListModel imgListModel = await DioManager()
                .request<ImgListModel>(DioManager.POST, 'openapi/storager/m',
                    params: {
                  'images': [
                    model.memberList![interaModel.proMemberId]['avatar']
                  ]
                });
            interaModel.avatar = imgListModel.data?.first;
          }

          interaModel.name =
              model.memberList![interaModel.proMemberId]?['name'];
        }
      }
    }
    return model.list;
  }
}
