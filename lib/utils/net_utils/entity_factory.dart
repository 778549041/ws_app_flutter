import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/login_model.dart';
import 'package:ws_app_flutter/models/login/third_login_model.dart';
import 'package:ws_app_flutter/models/login/user_info.dart';
import 'package:ws_app_flutter/models/splash/splash_model.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (json == null) {
      return null;
    } else if (T.toString() == "SplashModel") {// 可以在这里加入任何需要并且可以转换的类型，例如下面
     return SplashModel.fromJson(json) as T;
   } else if (T.toString() == "UserInfo") {
     return UserInfo.fromJson(json) as T;
   } else if (T.toString() == 'CommonModel') {
     return CommonModel.fromJson(json) as T;
   } else if (T.toString() == 'LoginModel') {
     return LoginModel.fromJson(json) as T;
   } else if (T.toString() == 'ThirdLoginModel') {
     return ThirdLoginModel.fromJson(json) as T;
   }
   else {
      return json as T;
    }
  }
}