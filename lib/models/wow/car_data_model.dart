class CarDataModel {
  String code;
  String message;
  CarData datas;

  CarDataModel({this.code, this.message}) : datas = CarData();

  CarDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    message = json['message'] ?? '';
    datas = json['datas'] != null ? CarData.fromJson(json['datas']) : CarData();
  }
}

class CarData {
  CarHeader rspBody;
  String fcarColor;
  String fcarColorURL;
  String carType;

  CarData({this.fcarColor, this.fcarColorURL, this.carType})
      : rspBody = CarHeader();

  CarData.fromJson(Map<String, dynamic> json) {
    rspBody = json['rspBody'] != null
        ? CarHeader.fromJson(json['rspBody'])
        : CarHeader();
    fcarColor = json['fcarColor'];
    fcarColorURL = json['fcarColorURL'];
    carType = json['carType'];
  }
}

class CarHeader {
  int chargingStatus;
  String soc;
  String rangMileage;

  CarHeader({this.chargingStatus, this.soc, this.rangMileage});

  CarHeader.fromJson(Map<String, dynamic> json) {
    chargingStatus = json['charging_status'];
    soc = json['SOC'];
    rangMileage = json['rang_mileage'];
  }
}
