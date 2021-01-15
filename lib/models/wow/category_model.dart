class CategoryListModel {
  List<CategoryModel> list;

  CategoryListModel() : list = List<CategoryModel>();

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    list = List<CategoryModel>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(CategoryModel.fromJson(element));
      });
    }
  }
}

class CategoryModel {
  String nodeName;
  String nodeId;
  String image;

  CategoryModel({this.nodeName = '', this.nodeId = '', this.image = ''});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    nodeName = json['node_name'] ?? '';
    nodeId = json['node_id'] ?? '';
    image = json['image'] ?? '';
  }
}
