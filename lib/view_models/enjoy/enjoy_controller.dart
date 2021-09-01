import 'package:flutter/material.dart';
import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/enjoy/cj_url_model.dart';
import 'package:ws_app_flutter/models/enjoy/futc.dart';
import 'package:ws_app_flutter/models/enjoy/shop.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class EnjoyController extends RefreshListController<ShopModel> {
  var futcModel = FUTCModel().obs;

  @override
  void onInit() {
    pageSize = 12;
    super.onInit();
  }

  @override
  Future<List<ShopModel>?> loadData({int pageNum = 1}) async {
    if (pageNum == 1) {
      await _requestKVData();
    }

    return await _requestMallData(pageNum);
  }

  //服务套餐KV图片
  Future _requestKVData() async {
    futcModel.value = await DioManager().request<FUTCModel>(
        DioManager.POST, Api.enjoyFWTCKVImageUrl,
        params: {"type": "1"});
  }

  //商城数据
  Future _requestMallData(int pageNum) async {
    ShopListModel _model = await DioManager().request<ShopListModel>(
        DioManager.GET, Api.enjoyMallListUrl,
        queryParamters: {"page": pageNum});
    return _model.dataList;
  }

  Future buttonAction(int index) async {
    if (index == 1000) {
      //点击头像
      Get.toNamed(Routes.MINEINFO);
    } else if (index == 1002) {
      //点击积分
      Get.toNamed(Routes.INTEGRALPAGE);
    } else if (index == 1003) {
      //积分规则
      Get.toNamed(Routes.INTEGRALRULE);
    } else if (index == 1004) {
      //换保养
      pushH5Page(args: {
        'url': Env.envConfig.serviceUrl +
            HtmlUrls.PointGalleryPage +
            '?cat_id=6087&source=2',
      });
    } else if (index == 1005) {
      //抽大奖
      CJUrlModel _model = await DioManager()
          .request<CJUrlModel>(DioManager.GET, Api.enjoyCDJUrl);
      String topage = '', urllk = '', actid;
      if (_model.code == 0) {
        if (_model.data?.activityAdventuresUrl != null) {
          topage = "dzp";
          urllk = _model.data!.activityAdventuresUrl!;
        } else if (_model.data?.activityMachineUrl != null) {
          topage = "sgj";
          urllk = _model.data!.activityMachineUrl!;
        } else if (_model.data?.activityScratchUrl != null) {
          topage = "ggk";
          urllk = _model.data!.activityScratchUrl!;
        } else if (_model.data?.activityShakeUrl != null) {
          topage = "yyy";
          urllk = _model.data!.activityShakeUrl!;
        }
        actid = urllk.split('?')[1];
        pushH5Page(args: {
          'url': Env.envConfig.serviceUrl +
              HtmlUrls.LuckyDrawPage +
              topage +
              topage +
              '?$actid',
        });
      } else if (_model.code == 1004) {
        CommonUtil.userNotVechileToast('认证车主才可以参与此活动哦，先去认证成为车主吧！');
      } else {
        Get.dialog(
            BaseDialog(
              title: '提示',
              rightText: '好的',
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(_model.message!, style: TextStyle(fontSize: 16.0)),
              ),
            ),
            barrierDismissible: false);
      }
    } else if (index == 1006) {
      //许心愿
      CommonModel _model = await DioManager()
          .request<CommonModel>(DioManager.GET, Api.enjoyXXYUrl);
      if (_model.result!) {
        pushH5Page(args: {
          'url': Env.envConfig.serviceUrl + HtmlUrls.WishPage,
        });
      } else if (_model.code == '1001') {
        CommonUtil.userNotVechileToast('认证车主才可以参与此活动哦，先去认证成为车主吧！');
      } else {
        Get.dialog(
            BaseDialog(
              title: '提示',
              rightText: '好的',
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(_model.message!, style: TextStyle(fontSize: 16.0)),
              ),
            ),
            barrierDismissible: false);
      }
    } else if (index == 1007) {
      //更多
      pushH5Page(args: {
        'url':
            Env.envConfig.serviceUrl + HtmlUrls.PointGalleryPage + '?source=3',
      });
    }
  }

  Future pushDetailH5(ShopModel model) async {
    pushH5Page(args: {
      'url': Env.envConfig.serviceUrl +
          HtmlUrls.ProductDetailPage +
          '?product_id=${model.product!.productId}&source=1',
    });
  }
}
