class SplashModel {
  String result;
  SplashData data;

  SplashModel({this.result, this.data});
  SplashModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = (json['data'] != null) ? SplashData.fromJson(json['data']) : null;
  }
}

class SplashData {
  String termsType;
  String showType;
  String createtime;
  String appType;
  String lastModify;
  String size;
  String logoId;
  String pOrder;
  String imageId;
  String url;
  String desc;
  String status;

  SplashData(
      {this.termsType = '',
      this.showType = '',
      this.createtime = '',
      this.appType = '',
      this.lastModify = '',
      this.size = '',
      this.logoId = '',
      this.pOrder = '',
      this.imageId = '',
      this.url = '',
      this.desc = '',
      this.status = ''});

  SplashData.fromJson(Map<String, dynamic> json) {
    termsType = json['terms_type'];
    showType = json['show_type'];
    createtime = json['createtime'];
    appType = json['app_type'];
    lastModify = json['last_modify'];
    size = json['size'];
    logoId = json['logo_id'];
    pOrder = json['p_order'];
    imageId = json['image_id'];
    url = json['url'];
    desc = json['desc'];
    status = json['status'];
  }
}
