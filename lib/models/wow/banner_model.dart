import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class BannerModel {
  CarouselHead? carouselHead;
  List<HeadLine>? headlines;

  BannerModel()
      : carouselHead = CarouselHead(),
        headlines = <HeadLine>[];

  BannerModel.fromJson(Map<String, dynamic> json) {
    carouselHead = CarouselHead.fromJson(asT<Map<String, dynamic>>(
        json['carousel_head'], Map<String, dynamic>())!);
    headlines = <HeadLine>[];
    if (json['headlines'] != null) {
      (json['headlines'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            headlines?.add(HeadLine.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class HeadLine {
  String? articleId;
  String? title;

  HeadLine({this.articleId = '', this.title = ''});

  HeadLine.fromJson(Map<String, dynamic> json) {
    articleId = asT<String>(json['article_id'], '');
    title = asT<String>(json['title'], '');
  }
}

class CarouselHead {
  Banner? banner;

  CarouselHead() : banner = Banner();

  CarouselHead.fromJson(Map<String, dynamic> json) {
    banner = Banner.fromJson(
        asT<Map<String, dynamic>>(json['banner'], Map<String, dynamic>())!);
  }
}

class Banner {
  String? carouselId;
  String? carouselType;
  String? createtime;
  String? figureType;
  String? lastModify;
  String? opId;
  String? opName;
  String? screen;
  String? showType;
  String? status;
  List<BannerItem>? items;

  Banner(
      {this.carouselId = '',
      this.carouselType = '',
      this.createtime = '',
      this.figureType = '',
      this.lastModify = '',
      this.opId = '',
      this.opName = '',
      this.screen = '',
      this.showType = '',
      this.status = ''})
      : items = <BannerItem>[];

  Banner.fromJson(Map<String, dynamic> json) {
    carouselId = asT<String>(json['carousel_id'], '');
    carouselType = asT<String>(json['carousel_type'], '');
    createtime = asT<String>(json['createtime'], '');
    figureType = asT<String>(json['figure_type'], '');
    lastModify = asT<String>(json['last_modify'], '');
    opId = asT<String>(json['op_id'], '');
    opName = asT<String>(json['op_name'], '');
    screen = asT<String>(json['screen'], '');
    showType = asT<String>(json['show_type'], '');
    status = asT<String>(json['status'], '');
    items = <BannerItem>[];
    if (json['items'] != null) {
      (json['items'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            items?.add(BannerItem.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class BannerItem {
  String? imageUrl;
  String? link;
  BannerParams? params;
  String? isHeader;
  String? title;
  String? pOrder;
  String? name;

  BannerItem(
      {this.imageUrl = '',
      this.link = '',
      this.isHeader = '',
      this.title = '',
      this.pOrder = '',
      this.name = ''})
      : params = BannerParams();

  BannerItem.fromJson(Map<String, dynamic> json) {
    imageUrl = asT<String>(json['image_url'], '');
    link = asT<String>(json['link'], '');
    params = BannerParams.fromJson(
        asT<Map<String, dynamic>>(json['params'], Map<String, dynamic>())!);
    isHeader = asT<String>(json['is_header'], '');
    title = asT<String>(json['title'], '');
    pOrder = asT<String>(json['p_order'], '');
    name = asT<String>(json['name'], '');
  }
}

class BannerParams {
  String? type; //跳转方式
  String? url; //h5跳转链接
  String? detailId; //跳转原生页面携带参数

  BannerParams({this.type = '', this.url = '', this.detailId = ''});

  BannerParams.fromJson(Map<String, dynamic> json) {
    type = asT<String>(json['type'], '');
    url = asT<String>(json['url'], '');
    detailId = asT<String>(json['detail_id'], '');
  }
}
