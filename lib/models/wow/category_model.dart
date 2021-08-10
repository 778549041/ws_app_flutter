import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class CategoryListModel {
  List<CategoryModel>? list;

  CategoryListModel() : list = <CategoryModel>[];

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    list = <CategoryModel>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list?.add(
                CategoryModel.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
  }
}

class CategoryModel {
  String? nodeName;
  String? nodeId;
  String? image;

  CategoryModel({this.nodeName = '', this.nodeId = '', this.image = ''});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    nodeName = asT<String>(json['node_name'], '');
    nodeId = asT<String>(json['node_id'], '');
    image = asT<String>(json['image'], '');
  }
}
