import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_qiniu/flutter_qiniu_config.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

typedef FlutterQiNiuProgress(String key, double percent);

class FlutterQiNiu {
  static const MethodChannel _channel =
      const MethodChannel('plugins.xiaoenai.com/flutter_qiniu');

  static String get platformVersion {
    return '0.0.1';
  }

  static FlutterQiNiuProgress _progress;

  static Future<Map> upload(
      FlutterQiNiuConfig config, FlutterQiNiuProgress progress) async {

    try {
      _progress = progress;
      _channel.setMethodCallHandler(_handler);

      String args = convert.jsonEncode(config.toJson());
      String result = await _channel.invokeMethod('upload', args);
      Map map = convert.jsonDecode(result);

      return Future.value(map);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<dynamic> _handler(MethodCall call) async {
    if (call.method == 'progress') {
      Map args = convert.jsonDecode(call.arguments);
      if (_progress != null) {
        _progress(args['key'], args['percent']);
      }
      return '';
    }
  }
}
