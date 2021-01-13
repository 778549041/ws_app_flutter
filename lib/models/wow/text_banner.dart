class TextBannerListModel {
  List<TextBannerModel> data;

  TextBannerListModel() : data = List<TextBannerModel>();

  TextBannerListModel.fromJson(Map<String, dynamic> json) {
    data = List<TextBannerModel>();
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        data.add(TextBannerModel.fromJson(element));
      });
    }
  }
}

class TextBannerModel {
  String id;
  String status;
  String type;
  String memberLv;
  String content;
  String url;
  String createtime;
  String updatetime;
  String isHeader;
  TextBannerParams params;

  TextBannerModel(
      {this.id = '',
      this.status = '',
      this.type = '',
      this.memberLv = '',
      this.content = '',
      this.url = '',
      this.createtime = '',
      this.updatetime = '',
      this.isHeader = ''}) : params = TextBannerParams();

  TextBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    status = json['status'] ?? '';
    type = json['type'] ?? '';
    memberLv = json['member_lv'] ?? '';
    content = json['content'] ?? '';
    url = json['url'] ?? '';
    createtime = json['createtime'] ?? '';
    updatetime = json['updatetime'] ?? '';
    isHeader = json['is_header'] ?? '';
    params = json['params'] != null
        ? TextBannerParams.fromJson(json['params'])
        : TextBannerParams();
  }
}

class TextBannerParams {
  String type;
  String detailId;

  TextBannerParams({this.type = '', this.detailId = ''});

  TextBannerParams.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? '';
    detailId = json['detail_id'] ?? '';
  }
}
