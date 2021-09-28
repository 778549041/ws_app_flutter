import 'package:ws_app_flutter/models/car/battery_model.dart';
import 'package:ws_app_flutter/models/car/car_config.dart';
import 'package:ws_app_flutter/models/car/car_status_model.dart';
import 'package:ws_app_flutter/models/car/control_cmd_model.dart';
import 'package:ws_app_flutter/models/car/mileage_model.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/models/circle/circle_hot_model.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/circle/friend_circle_img_model.dart';
import 'package:ws_app_flutter/models/circle/friend_model.dart';
import 'package:ws_app_flutter/models/circle/moment_comment_model.dart';
import 'package:ws_app_flutter/models/circle/topic_apply_join_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/common/img_model.dart';
import 'package:ws_app_flutter/models/enjoy/cj_url_model.dart';
import 'package:ws_app_flutter/models/enjoy/futc.dart';
import 'package:ws_app_flutter/models/enjoy/gallery_mall_model.dart';
import 'package:ws_app_flutter/models/enjoy/product_detail_model.dart';
import 'package:ws_app_flutter/models/login/address_model.dart';
import 'package:ws_app_flutter/models/login/bind_model.dart';
import 'package:ws_app_flutter/models/login/certify_model.dart';
import 'package:ws_app_flutter/models/login/im_info_model.dart';
import 'package:ws_app_flutter/models/login/intre_model.dart';
import 'package:ws_app_flutter/models/login/login_model.dart';
import 'package:ws_app_flutter/models/login/msg_model.dart';
import 'package:ws_app_flutter/models/login/store_model.dart';
import 'package:ws_app_flutter/models/login/third_login_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/models/mine/common_question_model.dart';
import 'package:ws_app_flutter/models/mine/exchange_package_detail_model.dart';
import 'package:ws_app_flutter/models/mine/exchange_package_list_model.dart';
import 'package:ws_app_flutter/models/mine/favor.dart';
import 'package:ws_app_flutter/models/mine/integral_model.dart';
import 'package:ws_app_flutter/models/mine/intera_msg_model.dart';
import 'package:ws_app_flutter/models/mine/order_list_model.dart';
import 'package:ws_app_flutter/models/mine/pac_list_model.dart';
import 'package:ws_app_flutter/models/mine/package_detail.dart';
import 'package:ws_app_flutter/models/mine/report_list_model.dart';
import 'package:ws_app_flutter/models/mine/shop_list_model.dart';
import 'package:ws_app_flutter/models/mine/sign_data.dart';
import 'package:ws_app_flutter/models/mine/system_msg_model.dart';
import 'package:ws_app_flutter/models/mine/win_list_model.dart';
import 'package:ws_app_flutter/models/splash/splash_model.dart';
import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/models/wow/banner_model.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/models/wow/category_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/models/wow/cdz_info_model.dart';
import 'package:ws_app_flutter/models/wow/charge_pile_model.dart';
import 'package:ws_app_flutter/models/wow/news_comment_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/models/wow/news_tag_model.dart';
import 'package:ws_app_flutter/models/wow/text_banner.dart';

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (json == null) {
      return null;
    } else if (T.toString() == "SplashModel") {// 可以在这里加入任何需要并且可以转换的类型，例如下面
     return SplashModel.fromJson(json) as T;
   } else if (T.toString() == "UserInfo") {
     return UserInfo.fromJson(json) as T;
   } else if (T.toString() == 'CommonModel') {
     return CommonModel.fromJson(json) as T;
   } else if (T.toString() == 'LoginModel') {
     return LoginModel.fromJson(json) as T;
   } else if (T.toString() == 'ThirdLoginModel') {
     return ThirdLoginModel.fromJson(json) as T;
   } else if (T.toString() == 'BindModel') {
     return BindModel.fromJson(json) as T;
   } else if (T.toString() == 'AppleBindModel') {
     return AppleBindModel.fromJson(json) as T;
   } else if (T.toString() == 'IntresModel') {
     return IntresModel.fromJson(json) as T;
   } else if (T.toString() == 'CertifyModel') {
     return CertifyModel.fromJson(json) as T;
   } else if (T.toString() == 'CarDataModel') {
     return CarDataModel.fromJson(json) as T;
   } else if (T.toString() == 'BannerModel') {
     return BannerModel.fromJson(json) as T;
   } else if (T.toString() == 'TextBannerListModel') {
     return TextBannerListModel.fromJson(json) as T;
   } else if (T.toString() == 'MomentListModel') {
     return MomentListModel.fromJson(json) as T;
   } else if (T.toString() == 'SingleMomentModel') {
     return SingleMomentModel.fromJson(json) as T;
   } else if (T.toString() == 'NewsListModel') {
     return NewsListModel.fromJson(json) as T;
   } else if (T.toString() == 'NewsDetailModel') {
     return NewsDetailModel.fromJson(json) as T;
   } else if (T.toString() == 'ActivityListModel') {
     return ActivityListModel.fromJson(json) as T;
   } else if (T.toString() == 'RecommendActivityListModel') {
     return RecommendActivityListModel.fromJson(json) as T;
   } else if (T.toString() == 'CategoryListModel') {
     return CategoryListModel.fromJson(json) as T;
   } else if (T.toString() == 'TopicListModel') {
     return TopicListModel.fromJson(json) as T;
   } else if (T.toString() == 'SingleTopicodel') {
     return SingleTopicodel.fromJson(json) as T;
   } else if (T.toString() == 'NearStoreListModel') {
     return NearStoreListModel.fromJson(json) as T;
   } else if (T.toString() == 'CarConfigListModel') {
     return CarConfigListModel.fromJson(json) as T;
   } else if (T.toString() == 'FUTCModel') {
     return FUTCModel.fromJson(json) as T;
   } else if (T.toString() == 'GalleryMallModel') {
     return GalleryMallModel.fromJson(json) as T;
   } else if (T.toString() == 'FavorModel') {
     return FavorModel.fromJson(json) as T;
   } else if (T.toString() == 'ShopAddressListModel') {
     return ShopAddressListModel.fromJson(json) as T;
   } else if (T.toString() == 'IMInfoModel') {
     return IMInfoModel.fromJson(json) as T;
   } else if (T.toString() == 'MsgModel') {
     return MsgModel.fromJson(json) as T;
   } else if (T.toString() == 'AddressListModel') {
     return AddressListModel.fromJson(json) as T;
   } else if (T.toString() == 'StoreListModel') {
     return StoreListModel.fromJson(json) as T;
   } else if (T.toString() == 'SingleCDZInfoModel') {
     return SingleCDZInfoModel.fromJson(json) as T;
   } else if (T.toString() == 'CDZListModel') {
     return CDZListModel.fromJson(json) as T;
   } else if (T.toString() == 'ChargePileListModel') {
     return ChargePileListModel.fromJson(json) as T;
   } else if (T.toString() == 'CJUrlModel') {
     return CJUrlModel.fromJson(json) as T;
   } else if (T.toString() == 'NewsTagListModel') {
     return NewsTagListModel.fromJson(json) as T;
   } else if (T.toString() == 'NewsCommentListModel') {
     return NewsCommentListModel.fromJson(json) as T;
   } else if (T.toString() == 'MomentCommentListModel') {
     return MomentCommentListModel.fromJson(json) as T;
   } else if (T.toString() == 'FriendModel') {
     return FriendModel.fromJson(json) as T;
   } else if (T.toString() == 'FriendCircleImgListModel') {
     return FriendCircleImgListModel.fromJson(json) as T;
   } else if (T.toString() == 'AddFriendListModel') {
     return AddFriendListModel.fromJson(json) as T;
   } else if (T.toString() == 'FriendListModel') {
     return FriendListModel.fromJson(json) as T;
   } else if (T.toString() == 'CarStatusModel') {
     return CarStatusModel.fromJson(json) as T;
   } else if (T.toString() == 'ControlCmdModel') {
     return ControlCmdModel.fromJson(json) as T;
   } else if (T.toString() == 'SignData') {
     return SignData.fromJson(json) as T;
   } else if (T.toString() == 'SignEventResult') {
     return SignEventResult.fromJson(json) as T;
   } else if (T.toString() == 'CommonQuModel') {
     return CommonQuModel.fromJson(json) as T;
   } else if (T.toString() == 'SystemMsgModel') {
     return SystemMsgModel.fromJson(json) as T;
   } else if (T.toString() == 'OrderListModel') {
     return OrderListModel.fromJson(json) as T;
   } else if (T.toString() == 'ImgListModel') {
     return ImgListModel.fromJson(json) as T;
   } else if (T.toString() == 'InteraMsgModel') {
     return InteraMsgModel.fromJson(json) as T;
   } else if (T.toString() == 'IntegralModel') {
     return IntegralModel.fromJson(json) as T;
   } else if (T.toString() == 'WinListModel') {
     return WinListModel.fromJson(json) as T;
   } else if (T.toString() == 'ReportListModel') {
     return ReportListModel.fromJson(json) as T;
   } else if (T.toString() == 'PackageListModel') {
     return PackageListModel.fromJson(json) as T;
   } else if (T.toString() == 'PackageDetailModel') {
     return PackageDetailModel.fromJson(json) as T;
   } else if (T.toString() == 'ReportDetailModel') {
     return ReportDetailModel.fromJson(json) as T;
   } else if (T.toString() == 'ExchangePackageListModel') {
     return ExchangePackageListModel.fromJson(json) as T;
   } else if (T.toString() == 'ExchangePackageDetailModel') {
     return ExchangePackageDetailModel.fromJson(json) as T;
   } else if (T.toString() == 'ProductDetailModel') {
     return ProductDetailModel.fromJson(json) as T;
   } else if (T.toString() == 'MileageListModel') {
     return MileageListModel.fromJson(json) as T;
   } else if (T.toString() == 'BatteryModel') {
     return BatteryModel.fromJson(json) as T;
   } else if (T.toString() == 'CircleHotModel') {
     return CircleHotModel.fromJson(json) as T;
   } else if (T.toString() == 'CircleTagListModel') {
     return CircleTagListModel.fromJson(json) as T;
   } else if (T.toString() == 'TopicApplyJoinListModel') {
     return TopicApplyJoinListModel.fromJson(json) as T;
   }
   else {
      return json as T;
    }
  }
}