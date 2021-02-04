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

  //检查密码格式
  static bool checkPwd(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp("^([A-Za-z0-9]){6,12}\$").hasMatch(input);
  }

  //检查支付密码格式
  static bool checkPayPwd(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp("([0-9])\1{1}").hasMatch(input);
  }
}
