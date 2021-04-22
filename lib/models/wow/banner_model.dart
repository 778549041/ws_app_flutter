class BannerModel {
  CarouselHead carouselHead;
  List<HeadLine> headlines;

  BannerModel()
      : carouselHead = CarouselHead(),
        headlines = <HeadLine>[];

  BannerModel.fromJson(Map<String, dynamic> json) {
    carouselHead = json['carousel_head'] != null
        ? CarouselHead.fromJson(json['carousel_head'])
        : CarouselHead();
    headlines = <HeadLine>[];
    if (json['headlines'] != null) {
      (json['headlines'] as List).forEach((element) {
        headlines.add(HeadLine.fromJson(element));
      });
    }
  }
}

class HeadLine {
  String articleId;
  String title;

  HeadLine({this.articleId = '', this.title = ''});

  HeadLine.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'] ?? '';
    title = json['title'] ?? '';
  }
}

class CarouselHead {
  Banner banner;

  CarouselHead() : banner = Banner();

  CarouselHead.fromJson(Map<String, dynamic> json) {
    banner =
        json['banner'] != null ? Banner.fromJson(json['banner']) : Banner();
  }
}

class Banner {
  String carouselId;
  String carouselType;
  String createtime;
  String figureType;
  String lastModify;
  String opId;
  String opName;
  String screen;
  String showType;
  String status;
  List<BannerItem> items;

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
      this.status = ''}) : items = <BannerItem>[];

  Banner.fromJson(Map<String, dynamic> json) {
    carouselId = json['carousel_id'] ?? '';
    carouselType = json['carousel_type'] ?? '';
    createtime = json['createtime'] ?? '';
    figureType = json['figure_type'] ?? '';
    lastModify = json['last_modify'] ?? '';
    opId = json['op_id'] ?? '';
    opName = json['op_name'] ?? '';
    screen = json['screen'] ?? '';
    showType = json['show_type'] ?? '';
    status = json['status'] ?? '';
    items = <BannerItem>[];
    if (json['items'] != null) {
      (json['items'] as List).forEach((element) {
        items.add(BannerItem.fromJson(element));
      });
    }
  }
}

class BannerItem {
  String imageUrl;
  String link;
  BannerParams params;
  String isHeader;
  String title;
  String pOrder;
  String name;

  BannerItem(
      {this.imageUrl = '',
      this.link = '',
      this.isHeader = '',
      this.title = '',
      this.pOrder = '',
      this.name = ''}) : params = BannerParams();

  BannerItem.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'] ?? '';
    link = json['link'] ?? '';
    params =
        json['params'] != null ? BannerParams.fromJson(json['params']) : BannerParams();
    isHeader = json['is_header'] ?? '';
    title = json['title'] ?? '';
    pOrder = json['p_order'] ?? '';
    name = json['name'] ?? '';
  }
}

class BannerParams {
  String type; //跳转方式
  String url; //h5跳转链接
  String detailId; //跳转原生页面携带参数

  BannerParams({this.type = '', this.url = '', this.detailId = ''});

  BannerParams.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? '';
    url = json['url'] ?? '';
    detailId = json['detail_id'] ?? '';
  }
}
