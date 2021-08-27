import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/common/img_model.dart';
import 'package:ws_app_flutter/models/mine/intera_msg_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
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

  void pushAction(int index, InteraModel model) {
    if (index == 0) {
      //点击整行row，跳转好友详情
      Get.toNamed(Routes.USERPROFILE, arguments: {
        'user_id': model.proMemberId == null ? '' : model.proMemberId
      });
    } else if (index == 1) {
      //点击查看按钮
      Get.toNamed(Routes.NEWSDETAIL, arguments: {'article_id': model.relId});
    } else {
      addAction(model.interactionId!, index);
    }
  }

  Future addAction(String id, int status) async {
    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.GET, 'm/friends-interactionAction-$id-$status.html');
    if (model.success != null) {
      EasyLoading.showToast('操作成功',
          toastPosition: EasyLoadingToastPosition.bottom);
      for (var i = 0; i < list.length; i++) {
        InteraModel interaModel = list[i];
        if (interaModel.interactionId == id) {
          list.remove(interaModel);
          interaModel.status = status;
          list.insert(i, interaModel);
        }
      }
    } else {
      EasyLoading.showToast(model.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
