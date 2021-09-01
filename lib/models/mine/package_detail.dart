import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class PackageDetailModel {
  PackageData? list;

  PackageDetailModel({this.list});

  PackageDetailModel.fromJson(Map<String, dynamic> json) {
    list = (json['list'] != null && json['list'] != false)
        ? PackageData.fromJson(asT<Map<String, dynamic>>(json['list'])!)
        : null;
  }
}

class PackageData {
  String? FCardBagName;
  List<PackageBag>? card_list;
  String? createtime;
  String? store;

  PackageData({this.FCardBagName, this.card_list, this.createtime, this.store});

  PackageData.fromJson(Map<String, dynamic> json) {
    FCardBagName = asT<String?>(json['FCardBagName']);
    card_list = <PackageBag>[];
    if (json['card_list'] != null && json['card_list'] != false) {
      (json['card_list'] as List).forEach((element) {
        if (element != null) {
          tryCatch(() {
            card_list
                ?.add(PackageBag.fromJson(asT<Map<String, dynamic>>(element)!));
          });
        }
      });
    }
    createtime = asT<String?>(json['createtime']);
    store = asT<String?>(json['store']);
  }
}

class PackageBag {
  String? FBag;
  String? FCode;//二维码串
  String? FEndDate;//结束日期
  String? FLocalLogoPath;//
  String? FNotice;//使用说明
  String? FPutAppID;
  String? FTitle;//项目标题
  String? FUseTime;
  String? Fcard;
  int? card_state;//状态
  String? savepath;

  PackageBag({
    this.FBag,
    this.FCode,
    this.FEndDate,
    this.FLocalLogoPath,
    this.FNotice,
    this.FPutAppID,
    this.FTitle,
    this.FUseTime,
    this.Fcard,
    this.card_state,
    this.savepath,
  });

  PackageBag.fromJson(Map<String, dynamic> json) {
    FBag = asT<String?>(json['FBag']);
    FCode = asT<String?>(json['FCode']);
    FEndDate = asT<String?>(json['FEndDate']);
    FLocalLogoPath = asT<String?>(json['FLocalLogoPath']);
    FNotice = asT<String?>(json['FNotice']);
    FPutAppID = asT<String?>(json['FPutAppID']);
    FTitle = asT<String?>(json['FTitle']);
    FUseTime = asT<String?>(json['FUseTime']);
    Fcard = asT<String?>(json['Fcard']);
    card_state = asT<int?>(json['card_state']);
    savepath = asT<String?>(json['savepath']);
  }
}
