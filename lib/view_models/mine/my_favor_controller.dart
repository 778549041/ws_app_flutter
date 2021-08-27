import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class MyFavorController extends RefreshListController<NewModel> {
  @override
  void onInit() {
    super.onInit();
    pageSize = 10;
  }

  @override
  Future<List<NewModel>?> loadData({int pageNum = 1}) async {
    NewsListModel model = await DioManager().request<NewsListModel>(
        DioManager.POST, Api.myFavorUrl,
        queryParamters: {'page': pageNum});
    return model.list;
  }

  void pushAction(NewModel model) {
    Get.toNamed(Routes.NEWSDETAIL, arguments: {'article_id': model.articleId!});
  }

  Future cancelFavor(NewModel model) async {
    CommonModel result = await DioManager().request<CommonModel>(
        DioManager.POST, Api.cancelFavorUrl,
        params: {'art_id': model.articleId!});
    if (result.res!) {
      list.remove(model);
    } else {
      EasyLoading.showToast('操作失败',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
