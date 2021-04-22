
import 'package:ws_app_flutter/utils/net_utils/entity_factory.dart';

class BaseEntity<T> {
  int code;
  String message;
  String result;
  T data;

  BaseEntity({this.code, this.message,this.result, this.data});

  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    return BaseEntity(
        code: json['errorCode'],
        message: json['errorMsg'],
        result: json['result'],
        data: EntityFactory.generateOBJ<T>(json['data']));
  }
}

class BaseListEntity<T> {
  int code;
  String message;
  List<T> data;

  BaseListEntity({this.code, this.message, this.data});

  factory BaseListEntity.fromJson(Map<String, dynamic> json) {
    List<T> mData = <T>[];
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((element) {
        mData.add(EntityFactory.generateOBJ<T>(element));
      });
    }
    return BaseListEntity(
        code: json['errorCode'], message: json['errorMsg'], data: mData);
  }
}

class ErrorEntity {
  int code;
  String message;
  ErrorEntity({this.code, this.message});
}
