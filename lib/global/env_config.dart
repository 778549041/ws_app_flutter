// 环境配置
import 'package:flutter/foundation.dart';

class EnvConfig {
  ///注意debug模式和release模式切换时需要修改,默认为debug测试模式
  //APP基础配置(接口域名，第三方平台key)
  //接口地址域名
  final String serviceUrl;
  //七牛云域名
  final String qiniuServiceUrl;
  //七牛云命名空间
  final String qiniuSpaceName;
  //易观方舟key
  final String ygAppKey;
  //live800key
  final String live800Key;
  //live800secret
  final String live800Secret;
  //websocket地址
  final String scoketIP;

  EnvConfig({
    required this.serviceUrl,
    required this.qiniuServiceUrl,
    required this.qiniuSpaceName,
    required this.ygAppKey,
    required this.live800Key,
    required this.live800Secret,
    required this.scoketIP,
  });
}

// 获取的配置信息
class Env {
  // 开发环境
  static final EnvConfig _debugConfig = EnvConfig(
    serviceUrl: 'https://app.ocarplay.com/',
    qiniuServiceUrl: 'https://apps.weiyihui.cn/',
    qiniuSpaceName: 'yangzhou',
    ygAppKey: '8643a2d81f243e20',
    live800Key: 'live800_7mg9mgm6zdrz',
    live800Secret: 'ar8zp6qhfd822ho',
    scoketIP: '119.3.248.18:9502',
  );
  // 发布环境
  static final EnvConfig _releaseConfig = EnvConfig(
    serviceUrl: 'https://wsapp.ghac.cn/',
    qiniuServiceUrl: 'https://wsmedia.ghac.cn/',
    qiniuSpaceName: 'wowstation_app',
    ygAppKey: '255506d98c115f59',
    live800Key: 'live800_acl02myiizan',
    live800Secret: 'aj24dqfpyvleh3g',
    scoketIP: '139.9.80.244:9502',
  );

  static EnvConfig get envConfig => _getEnvConfig();

  // 根据不同环境返回对应的环境配置
  static EnvConfig _getEnvConfig() {
    if (kDebugMode) {
      return _debugConfig;
    } else {
      return _releaseConfig;
    }
  }
}
