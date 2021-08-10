import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class TextBannerListModel {
  List<TextBannerModel>? data;

  TextBannerListModel() : data = <TextBannerModel>[];

  TextBannerListModel.fromJson(Map<String, dynamic> json) {
    data = <TextBannerModel>[];
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            data!.add(
                TextBannerModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class TextBannerModel {
  String? id;
  String? status;
  String? type;
  String? memberLv;
  String? content;
  String? url;
  String? createtime;
  String? updatetime;
  String? isHeader;
  TextBannerParams? params;

  TextBannerModel(
      {this.id = '',
      this.status = '',
      this.type = '',
      this.memberLv = '',
      this.content = '',
      this.url = '',
      this.createtime = '',
      this.updatetime = '',
      this.isHeader = ''})
      : params = TextBannerParams();

  TextBannerModel.fromJson(Map<String, dynamic> json) {
    id = asT<String>(json['id'], '');
    status = asT<String>(json['status'], '');
    type = asT<String>(json['type'], '');
    memberLv = asT<String>(json['member_lv'], '');
    content = asT<String>(json['content'], '');
    url = asT<String>(json['url'], '');
    createtime = asT<String>(json['createtime'], '');
    updatetime = asT<String>(json['updatetime'], '');
    isHeader = asT<String>(json['is_header'], '');
    params = TextBannerParams.fromJson(
        asT<Map<String, dynamic>>(json['params'], Map<String, dynamic>())!);
  }
}

class TextBannerParams {
  String? type;
  String? detailId;

  TextBannerParams({this.type = '', this.detailId = ''});

  TextBannerParams.fromJson(Map<String, dynamic> json) {
    type = asT<String>(json['type'], '');
    detailId = asT<String>(json['detail_id'], '');
  }
}
