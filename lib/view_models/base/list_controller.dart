import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';

abstract class ListController<T> extends BaseController {
  /// 页面数据
  var list = List<T>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    setBusy();
    refresh(init: true);
  }

  // 下拉刷新
  Future refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setIdle();
      }
    } catch (e, s) {
      if (init) list.clear();
      setError(e, s);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}
}