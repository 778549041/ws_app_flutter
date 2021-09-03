import 'package:get/get.dart';
import 'package:ws_app_flutter/models/enjoy/gallery_mall_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';

class GalleryMallController extends RefreshListController<ShopModel> {
  var cat_id = Get.arguments?['cat_id'];
  var headDataLoadOnce = false; //banner数据和tab数据是否加载过，默认没有
  var carouselData = <CarouselItem>[].obs; //banner数据
  var tabsData = <ScreenCat>[].obs; //tab数据

  @override
  void onInit() {
    super.onInit();
    pageSize = 12;
  }

  @override
  Future<List<ShopModel>?> loadData({int pageNum = 1}) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['page'] = pageNum;
    if (cat_id != null) {
      params['cat_id'] = cat_id;
    }
    GalleryMallModel _model = await DioManager().request<GalleryMallModel>(
        DioManager.GET, Api.enjoyMallListUrl,
        queryParamters: params);
    if (!headDataLoadOnce) {
      //如果没有加载过banner数据和tab数据，则加载
      carouselData.assignAll(_model.carousel!.items!);
      ScreenCat allCat = ScreenCat(cat_name: '全部');
      var catList = [allCat];
      catList.addAll(_model.data_screen!.cat!);
      tabsData.assignAll(catList);
      headDataLoadOnce = true;
    }
    return _model.data_list;
  }

  void tabIndexChanged(int index) {
    ScreenCat cat = tabsData[index];
    cat_id = cat.cat_id;
    refresh();
  }

  void pushDetail(ShopModel model) {
    Get.toNamed(Routes.PRODUCTDETAIL,arguments: {'product_id':model.product!.productId!});
  }
}
