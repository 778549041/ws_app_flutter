import 'package:flustars/flustars.dart';

///单例模式
class Singleton {
  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static final Singleton _instance = Singleton._internal();

  //提供了一个工厂方法来获取该类的实例
  factory Singleton() {
    return _instance;
  }
  
  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  Singleton._internal() {
    // 初始化
    init();
  }

  void init() {
    LogUtil.d("这里初始化");
  }
}
