import 'package:flustars/flustars.dart';
import 'package:uuid/uuid.dart';
import 'package:ws_app_flutter/global/cache_key.dart';

class CommonUtil {
  //获取uuid
  static String sid() {
    String sid = SpUtil.getString(CacheKey.SID_KEY);
    if (ObjectUtil.isEmptyString(sid)) {
      sid = Uuid().v1();
      SpUtil.putString(CacheKey.SID_KEY, sid);
    }
    //b55b8c00-85d7-11ea-af6d-09351c0892b3
    return sid;
  }
}