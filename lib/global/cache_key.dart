class CacheKey {
  //静态存储常量key
  static const String SID_KEY = 'SID';
  static const String REGISTRATIONID = 'REGISTRATIONID';
  static const String FIRSTLAUNCH = 'FIRSTLAUNCH';
  static const String REGISTRATIONID_SUCCESS = 'REGISTRATIONID_SUCCESS';
  static const String USER_INFO = 'USER_INFO';

  ///注意debug模式和release模式切换时需要修改,默认为debug测试模式
  //APP基础配置(接口域名，第三方平台key)
  //接口地址域名
  static const String SERVICE_URL_HOST = 'https://app.ocarplay.com/';//https://wsapp.ghac.cn/
  //七牛云域名
  static const String QINIU_SERVICE_HOST = 'https://apps.weiyihui.cn/';//https://wsmedia.ghac.cn/
  //七牛云命名空间
  static const String QINIU_SPACE_NAME = 'yangzhou';//wowstation_app
  //易观方舟key
  static const String YGANALYS_KEY = '8643a2d81f243e20';//255506d98c115f59
  //live800key
  static const String LIVE_800_KEY = 'live800_7mg9mgm6zdrz';//live800_acl02myiizan
  //live800secret
  static const String LIVE_800_SECRET = 'ar8zp6qhfd822ho';//aj24dqfpyvleh3g
  //websocket地址
  static const String SOKCET_IP = '119.3.248.18:9502';//139.9.80.244:9502

  //第三方平台key
  static const String APP_STORE_ID = "1477481597";

  //wechat
  static const String WECHAT_APPKEY = "wx2b557709c7855d73";
  static const String WECHAT_APPSECRET = "02cfcff4e614584ccd2c2ecb15235f09";
  static const String WECHAT_APPDESC = "WOW";
  static const String UNIVERSAL_LINKS = "https://link.ocarplay.com/wowstation/";

  //JGpush jiguang.com
  static const String JPUSH_APPKEY = "8ef8b590f8a19c29cb57f8c3";
  static const String JPUSH_APPSECRET = "a2d2fd15c1b91845df7fe417";

  //ShareSDK mob.com
  static const String SHARESDK_APPKEY = "2bac74f13ef20";
  static const String SHARESDK_APPSECRET = "cd91ff8208eb4a5dae47e8a2ed48de74";

  //sina  新浪分享
  static const String SINA_APPKEY = "2066497986";
  static const String SINA_APPSECRET = "857033032e21eb0af1acd2f92d27562e";
  static const String SINA_REDIRECT_URI =
      "openapi/toauth/callback/toauth_pam_sina/callback";

  //高德key
  static const String AMAP_KEY = "7a1bd67b8d226567eae73e1e9cba3429";

  //七牛云key
  static const String QINIU_ACCESS_KEY =
      "-UD-q2U99pwnAQCTSlA2GQNXqVULvvJCci9MVyO4";
  static const String QINIU_SECRET_KEY =
      "SpteNnMWI2CXuL9TJFPmycxnn_BeTF5B8TgDYyi8";

  //IM 腾讯云
  static const String TIMSDK_APPID = "1400221226"; //替换成您在控制台生成的 sdkAppid
  static const String TIMSDK_CERID = "12742"; //证书id

  //bugly key
  static const String BUGLY_KEY = "18870e2ba8";

  //DMP统计接口
  static const String DMPUPLOADURL = "http://52.82.34.126:8080/app";
}
