import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class SplashModel {
  String? result;
  SplashData? data;

  SplashModel({this.result, this.data});

  SplashModel.fromJson(Map<String, dynamic> json) {
    result = asT<String?>(json['result']);
    data = (json['data'] != null && json['data'] != false)
        ? SplashData.fromJson(asT<Map<String, dynamic>>(json['data'])!)
        : null;
  }
}

class SplashData {
  String? termsType;
  String? showType;
  String? createtime;
  String? appType;
  String? lastModify;
  String? size;
  String? logoId;
  String? pOrder;
  String? imageId;
  String? url;
  String? desc;
  String? status;

  SplashData(
      {this.termsType,
      this.showType,
      this.createtime,
      this.appType,
      this.lastModify,
      this.size,
      this.logoId,
      this.pOrder,
      this.imageId,
      this.url,
      this.desc,
      this.status});

  SplashData.fromJson(Map<String, dynamic> json) {
    termsType = asT<String?>(json['terms_type']);
    showType = asT<String?>(json['show_type']);
    createtime = asT<String?>(json['createtime']);
    appType = asT<String?>(json['app_type']);
    lastModify = asT<String?>(json['last_modify']);
    size = asT<String?>(json['size']);
    logoId = asT<String?>(json['logo_id']);
    pOrder = asT<String?>(json['p_order']);
    imageId = asT<String?>(json['image_id']);
    url = asT<String?>(json['url']);
    desc = asT<String?>(json['desc']);
    status = asT<String?>(json['status']);
  }
}
