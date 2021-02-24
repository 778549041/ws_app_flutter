class SingleCDZInfoModel {
  bool result;
  SingleCDZInfo list;

  SingleCDZInfoModel({this.result, this.list});

  SingleCDZInfoModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    list = json['list'] != null ? SingleCDZInfo.fromJson(json['list']) : null;
  }
}

class SingleCDZInfo {
  String stationID; //充电站id
  String operatorID; //运营商ID
  String equipmentID; //设备编码
  String equipmentOwnerID; //设备所属方ID
  String stationName; //充电站名称
  String countryCode; //充电站国家代码
  String areaCode; //充电站省市辖区编码
  String stationTel; //站点电话
  String serviceTel; //服务电话
  String
      stationType; //站点类型 1:公共 50:个人 100:公交(专用) 101:环卫(专用) 102:物流(专用) 103:出租车(专用) 255:其他
  String stationStatus; //站点状态 0:未知 1:建设中 5:关闭下线 6:维护中 50:正常使用
  String stationLng; //经度
  String stationLat; //纬度
  String address; //充电站地址
  String matchCars; //使用车型描述
  String parkNums; //车位数量->可停放进行充电的车位总数
  String electricityFee; //充电电费率
  String serviceFee; //服务费
  String parkFee; //停车费
  String parkInfo; //车位楼层及数量描述
  String siteGuide; //站点引导
  String
      construction; //建设场所1：居民区2：公共机构3：企事业单位5：工业园区 6：交通枢纽7：大型文体设施8：城市绿地9：大型建筑配建停车场10：路边停车位11：城际高速服务区255：其他
  String busineHours; //营业时间
  String price; //当前时间充电费
  String servicePrice; //当前时间服务费
  String supportOrder; //是否支持预约 0:不支持 1:支持
  String payment; //支付方式
  String remark; //备注
  int kuai; //直流快充数量
  int man; //交流慢充数量
  String serviceType; //服务商(1:特来电,2:国翰,3:星星)

  SingleCDZInfo(
      {this.stationID,
      this.serviceType,
      this.stationName,
      this.stationLat,
      this.stationLng,
      this.address,
      this.areaCode,
      this.busineHours,
      this.construction,
      this.countryCode,
      this.electricityFee,
      this.equipmentID,
      this.equipmentOwnerID,
      this.kuai,
      this.man,
      this.matchCars,
      this.operatorID,
      this.parkFee,
      this.parkInfo,
      this.parkNums,
      this.payment,
      this.price,
      this.remark,
      this.servicePrice,
      this.serviceFee,
      this.serviceTel,
      this.siteGuide,
      this.stationStatus,
      this.stationTel,
      this.stationType,
      this.supportOrder});

  SingleCDZInfo.fromJson(Map<String, dynamic> json) {
    stationID = json['StationID'];
    serviceType = json['ServiceType'];
    stationName = json['StationName'];
    stationLat = json['StationLat'];
    stationLng = json['StationLng'];
    address = json['Address'];
    areaCode = json['AreaCode'];
    busineHours = json['BusineHours'];
    construction = json['Construction'];
    countryCode = json['CountryCode'];
    electricityFee = json['ElectricityFee'];
    equipmentID = json['EquipmentID'];
    equipmentOwnerID = json['EquipmentOwnerID'];
    kuai = json['kuai'];
    man = json['man'];
    matchCars = json['MatchCars'];
    operatorID = json['OperatorID'];
    parkFee = json['ParkFee'];
    parkInfo = json['ParkInfo'];
    parkNums = json['ParkNums'];
    payment = json['Payment'];
    price = json['price'];
    remark = json['Remark'];
    servicePrice = json['service_price'];
    serviceFee = json['ServiceFee'];
    serviceTel = json['ServiceTel'];
    siteGuide = json['SiteGuide'];
    stationStatus = json['StationStatus'];
    stationTel = json['StationTel'];
    stationType = json['StationType'];
    supportOrder = json['SupportOrder'];
  }
}


class CDZListModel {
  bool result;
  List<CDZInfo> list;
  CDZListModel({this.result,this.list});

  CDZListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['list'] != null) {
      list = List<CDZInfo>();
      (json['list'] as List).forEach((element) {
        list.add(CDZInfo.fromJson(element));
      });
    }
  }
}

class CDZInfo {
  String stationID;
  String stationLng;
  String stationLat;
  String stationName;
  String serviceType;

  CDZInfo({this.stationID,this.stationLng,this.stationLat,this.stationName,this.serviceType});

  CDZInfo.fromJson(Map<String, dynamic> json) {
    stationID = json['StationID'];
    stationLng = json['StationLng'];
    stationLat = json['StationLat'];
    stationName = json['StationName'];
    serviceType = json['ServiceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StationID'] = this.stationID;
    data['StationLng'] = this.stationLng;
    data['StationLat'] = this.stationLat;
    data['StationName'] = this.stationName;
    data['ServiceType'] = this.serviceType;
    return data;
  }
}