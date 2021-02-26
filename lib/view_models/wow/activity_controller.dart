import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class ActivityController extends RefreshListController<ActivityModel> {
  var condition = 'all'.obs;

  @override
  void onInit() {
    pageSize = 9;
    super.onInit();
  }

  @override
  Future<List<ActivityModel>> loadData({int pageNum}) async {
    ActivityListModel _model = await DioManager().request<ActivityListModel>(
        DioManager.GET,
        'index.php/m/huodong-$pageNum-10-${condition.value}.html?key=');
    return _model.list;
  }

  //条件筛选列表数据
  Future requestData(int pageNum, String condition) async {
    ActivityListModel _model = await DioManager().request<ActivityListModel>(
        DioManager.GET,
        'index.php/m/huodong-$pageNum-10-$condition.html?key=');
    if (_model.list.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(_model.list);
        list.clear();
        list.addAll(_model.list);
        refreshController.refreshCompleted();
        // 小于分页的数量,禁止上拉加载更多
        if (_model.list.length < pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        setIdle();
      }
      return _model.list;
  }

  //活动搜索
  void clickSearch() {
    Get.toNamed(Routes.ACTIVITYSEARCH);
  }
}
