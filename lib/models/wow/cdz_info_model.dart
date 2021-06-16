import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class SingleCDZInfoModel {
  bool result;
  SingleCDZInfo list;

  SingleCDZInfoModel({this.result, this.list});

  SingleCDZInfoModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool>(json['result']);
    list = SingleCDZInfo.fromJson(
        asT<Map<String, dynamic>>(json['list'], Map<String, dynamic>()));
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
  int kuaiNum; //快充闲置个数
  int man; //交流慢充数量
  int manNum; //慢充闲置个数
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
    stationID = asT<String>(json['StationID']);
    serviceType = asT<String>(json['ServiceType']);
    stationName = asT<String>(json['StationName']);
    stationLat = asT<String>(json['StationLat']);
    stationLng = asT<String>(json['StationLng']);
    address = asT<String>(json['Address']);
    areaCode = asT<String>(json['AreaCode']);
    busineHours = asT<String>(json['BusineHours']);
    construction = asT<String>(json['Construction']);
    countryCode = asT<String>(json['CountryCode']);
    electricityFee = asT<String>(json['ElectricityFee']);
    equipmentID = asT<String>(json['EquipmentID']);
    equipmentOwnerID = asT<String>(json['EquipmentOwnerID']);
    kuai = asT<int>(json['kuai']);
    kuaiNum = asT<int>(json['kuai_num']);
    man = asT<int>(json['man']);
    manNum = asT<int>(json['man_num']);
    matchCars = asT<String>(json['MatchCars']);
    operatorID = asT<String>(json['OperatorID']);
    parkFee = asT<String>(json['ParkFee']);
    parkInfo = asT<String>(json['ParkInfo']);
    parkNums = asT<String>(json['ParkNums']);
    payment = asT<String>(json['Payment']);
    price = asT<String>(json['price']);
    remark = asT<String>(json['Remark']);
    servicePrice = asT<String>(json['service_price']);
    serviceFee = asT<String>(json['ServiceFee']);
    serviceTel = asT<String>(json['ServiceTel']);
    siteGuide = asT<String>(json['SiteGuide']);
    stationStatus = asT<String>(json['StationStatus']);
    stationTel = asT<String>(json['StationTel']);
    stationType = asT<String>(json['StationType']);
    supportOrder = asT<String>(json['SupportOrder']);
  }
}

class CDZListModel {
  bool result;
  List<CDZInfo> list;
  CDZListModel({this.result, this.list});

  CDZListModel.fromJson(Map<String, dynamic> json) {
    result = asT<bool>(json['result']);
    list = <CDZInfo>[];
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            list.add(CDZInfo.fromJson(asT<Map<String, dynamic>>(element)));
          });
        }
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

  CDZInfo(
      {this.stationID,
      this.stationLng,
      this.stationLat,
      this.stationName,
      this.serviceType});

  CDZInfo.fromJson(Map<String, dynamic> json) {
    stationID = asT<String>(json['StationID']);
    stationLng = asT<String>(json['StationLng']);
    stationLat = asT<String>(json['StationLat']);
    stationName = asT<String>(json['StationName']);
    serviceType = asT<String>(json['ServiceType']);
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
