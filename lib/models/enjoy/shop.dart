class ShopListModel {
  List<ShopModel> dataList;
  Pager pager;

  ShopListModel()
      : dataList = <ShopModel>[],
        pager = Pager();

  ShopListModel.fromJson(Map<String, dynamic> json) {
    dataList = <ShopModel>[];
    if (json['data_list'] != null) {
      (json['data_list'] as List).forEach((element) {
        dataList.add(ShopModel.fromJson(element));
      });
    }
    pager = json['pager'] != null ? Pager.fromJson(json['pager']) : Pager();
  }
}

class ShopModel {
  String deduction;
  String integral;
  String name;
  String image;
  Product product;
  bool typeVip;

  ShopModel(
      {this.deduction = '',
      this.integral = '',
      this.name = '',
      this.image = '',
      this.typeVip = false})
      : product = Product();

  ShopModel.fromJson(Map<String, dynamic> json) {
    deduction = json['deduction'];
    integral = json['integral'];
    name = json['name'];
    image = json['image'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : Product();
    typeVip = json['type_vip'] == 'true';
  }
}

class Product {
  String productId;

  Product({this.productId = ''});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
  }
}

class Pager {
  int current;
  int total;

  Pager({this.current = 0, this.total = 0});

  Pager.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    total = json['total'];
  }
}
