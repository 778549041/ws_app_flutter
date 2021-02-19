import 'package:ws_app_flutter/models/car/car_config.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/enjoy/futc.dart';
import 'package:ws_app_flutter/models/enjoy/shop.dart';
import 'package:ws_app_flutter/models/login/bind_model.dart';
import 'package:ws_app_flutter/models/login/certify_model.dart';
import 'package:ws_app_flutter/models/login/im_info_model.dart';
import 'package:ws_app_flutter/models/login/intre_model.dart';
import 'package:ws_app_flutter/models/login/login_model.dart';
import 'package:ws_app_flutter/models/login/msg_model.dart';
import 'package:ws_app_flutter/models/login/third_login_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/models/mine/favor.dart';
import 'package:ws_app_flutter/models/mine/shop_list_model.dart';
import 'package:ws_app_flutter/models/splash/splash_model.dart';
import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/models/wow/banner_model.dart';
import 'package:ws_app_flutter/models/wow/car_data_model.dart';
import 'package:ws_app_flutter/models/wow/category_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/models/wow/text_banner.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
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
   } else if (T.toString() == 'ShopListModel') {
     return ShopListModel.fromJson(json) as T;
   } else if (T.toString() == 'FavorModel') {
     return FavorModel.fromJson(json) as T;
   } else if (T.toString() == 'ShopAddressListModel') {
     return ShopAddressListModel.fromJson(json) as T;
   } else if (T.toString() == 'IMInfoModel') {
     return IMInfoModel.fromJson(json) as T;
   } else if (T.toString() == 'MsgModel') {
     return MsgModel.fromJson(json) as T;
   } 
   else {
      return json as T;
    }
  }
}