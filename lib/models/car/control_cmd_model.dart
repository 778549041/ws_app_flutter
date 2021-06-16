import 'package:ws_app_flutter/utils/net_utils/json_convert.dart';

class ControlCmdModel {
  String code;
  String message;
  ControlCmdData datas;

  ControlCmdModel({this.code = '0', this.message = ''})
      : datas = ControlCmdData();

  ControlCmdModel.fromJson(Map<String, dynamic> json) {
    code = asT<String>(json['code'], '0');
    message = asT<String>(json['message'], '');
    datas = ControlCmdData.fromJson(
        asT<Map<String, dynamic>>(json['datas'], Map<String, dynamic>()));
  }
}

class ControlCmdData {
  String value; //指令执行结果 0未发送，1已发送，2执行成功，3执行失败，4执行超时
  String command; //指令名称
  int cmdType; //指令类型 1、远程空调 2、开/落锁 3、寻车 4、运行时长设置 5、电量安全值设置
  String loadingTitle; //loading弹框标题

  ControlCmdData({
    this.value = '0',
    this.command = '',
    this.cmdType = 0,
    this.loadingTitle = '',
  });

  ControlCmdData.fromJson(Map<String, dynamic> json) {
    value = asT<String>(json['value'], '0');
    command = asT<String>(json['command'], 'airOpenCommand');
    if (command == 'airOpenCommand') {
      cmdType = 1;
      loadingTitle = '正在开启远程空调';
    } else if (command == 'airCloseCommand') {
      cmdType = 1;
      loadingTitle = '正在关闭远程空调';
    } else if (command == 'airWorkHourCreate') {
      cmdType = 4;
      loadingTitle = '正在设置运行时长';
    } else if (command == 'airSocCreate') {
      cmdType = 5;
      loadingTitle = '正在设置电池SOC';
    } else if (command == 'lockOpenCommand') {
      cmdType = 2;
      loadingTitle = '正在开锁';
    } else if (command == 'lockCloseCommand') {
      cmdType = 2;
      loadingTitle = '正在落锁';
    } else if (command == 'lookCarCommand') {
      cmdType = 3;
      loadingTitle = '正在寻车';
    }
  }
}
