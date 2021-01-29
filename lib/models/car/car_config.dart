class CarConfigListModel {
  List<CarConfigModel> data;

  CarConfigListModel() : data = List<CarConfigModel>();

  CarConfigListModel.fromJson(Map<String, dynamic> json) {
    data = List<CarConfigModel>();
    if (json['data'] != null) {
      (json['data'] as List).forEach((element) {
        data.add(CarConfigModel.fromJson(element));
      });
    }
  }
}

class CarConfigModel {
  String conf;
  String price;
  String version;
  String imageName;

  CarConfigModel({this.conf = '', this.price = '', this.version = '',this.imageName});

  CarConfigModel.fromJson(Map<String, dynamic> json) {
    conf = json['conf'] ?? '';
    price = json['price'] ?? '';
    version = json['version'] ?? '';
    if (conf == "出行版") {
        imageName = "assets/images/car/config_ve_plus_cx.png";
    } else if (conf == "舒适版") {
        imageName = "assets/images/car/config_ve_plus_ss.png";
    } else if (conf == "豪华版") {
        imageName = "assets/images/car/config_ve_plus_hh.png";
    } else if (conf == "湃锐版") {
        imageName = "assets/images/car/config_ves_plus_pr.png";
    } else if (conf == "湃锐豪华版") {
        imageName = "assets/images/car/config_ves_plus_prhh.png";
    }
  }
}