import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ConfigDetailController extends GetxController {
  final int type = Get.arguments['type'];
  var selectTypes = [].obs; //选中的版本列表

  @override
  void onInit() {
    super.onInit();
    selectTypes.add(type);
  }

  void checkboxValueChanged(int index, bool? value) {
    if (value!) {
      if (selectTypes.length == 3) {
      EasyLoading.showToast('最多选择3个',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
      selectTypes.add(index);
    } else {
      selectTypes.remove(index);
    }
    selectTypes.sort();
  }

  //版本
  String convertTypeToVersionString(int index) {
    String content = '';
    if (index == 0) {
      content = '出行版';
    } else if (index == 1) {
      content = '舒适版';
    } else if (index == 2) {
      content = '豪华版';
    } else if (index == 3) {
      content = '湃锐版';
    } else if (index == 4) {
      content = '湃锐豪华版';
    }
    return content;
  }

  //售价
  String convertTypeToVersionPrice(int index) {
    String content = '';
    if (index == 0) {
      content = '15.98万元';
    } else if (index == 1) {
      content = '16.98万元';
    } else if (index == 2) {
      content = '17.98万元';
    } else if (index == 3) {
      content = '17.38万元';
    } else if (index == 4) {
      content = '18.38万元';
    }
    return content;
  }

  //长宽高
  String convertTypeToVersionCKG(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 2) {
      content = '4308x1773x1625';
    }else if (index == 3 || index == 4) {
      content = '4306x1773x1625';
    }
    return content;
  }

  //轮辋尺寸
  String convertTypeToVersionLG(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 2) {
      content = '17×7.5J 熏灰铝合金轮毂';
    }else if (index == 3 || index == 4) {
      content = '17×7.5J 运动切削铝合金轮毂';
    }
    return content;
  }

  //整备质量（kg）
  String convertTypeToVersionZL(int index) {
    String content = '';
    if (index == 0) {
      content = '1547';
    } else if (index == 1) {
      content = '1557';
    } else if (index == 2) {
      content = '1593';
    } else if (index == 3) {
      content = '1559';
    } else if (index == 4) {
      content = '1594';
    }
    return content;
  }

  //高灵敏泊车雷达（后4探头）、侧安全气帘
  String convertTypeToVersionLDAndQL(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 3) {
      content = '—';
    }else if (index == 2 || index == 4) {
      content = '●';
    }
    return content;
  }

  //豪华后视摄像显示系统(广角/标准/俯视三种模式）
  String convertTypeToVersionHSSXT(int index) {
    String content = '';
    if (index == 0) {
      content = '—';
    }else if (index == 1 || index == 2 || index == 3 || index == 4) {
      content = '●';
    }
    return content;
  }


  /////外观
  //羽翼式全LED前大灯（高度可调）、湃锐专属运动内饰（红色缝线+饰件）
  String convertTypeToVersionWG1NS2(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 2) {
      content = '—';
    } else {
      content = '●';
    }
    return content;
  }

  //晶钻式LED前大灯（高度可调）
  String convertTypeToVersionWG2(int index) {
    String content = '';
    if (index == 0 || index == 3 || index == 4) {
      content = '—';
    } else {
      content = '●';
    }
    return content;
  }

  //反射式前大灯（高度可调）、高级织物座椅
  String convertTypeToVersionWG3NS13(int index) {
    String content = '';
    if (index == 0) {
      content = '●';
    } else {
      content = '—';
    }
    return content;
  }

  //LED日间行车灯、自动前大灯
  String convertTypeToVersionWG4WG5(int index) {
    String content = '';
    if (index == 0 || index == 1) {
      content = '—';
    } else {
      content = '●';
    }
    return content;
  }

  //前大灯自动延时熄灭（锁车后）
  String convertTypeToVersionCommonYuan(int index) {
    return '●';
  }

  //电动折叠外后视镜、外后视镜带转向灯、外后视镜加热功能
  String convertTypeToVersionWG8910(int index) {
    String content = '';
    if (index == 0) {
      content = '—';
    } else {
      content = '●';
    }
    return content;
  }

  //豪华全景电动天窗、前排座椅地图袋
  String convertTypeToVersionWG11NS16(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 3) {
      content = '—';
    } else {
      content = '●';
    }
    return content;
  }

  //多级式前挡风玻璃雨刮器
  String convertTypeToVersionWG15(int index) {
    String content = '';
    if (index == 0 || index == 1) {
      content = '●';
    } else {
      content = '●（可调速）';
    } 
    return content;
  }

  //后雾灯
  String convertTypeToVersionWG17(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 2) {
      content = '●';
    } else if (index == 3 || index == 4) {
      content = '●（LED）';
    }
    return content;
  }

  //行车示廓灯
  String convertTypeToVersionWG18(int index) {
    String content = '';
    if (index == 0) {
      content = '●';
    } else {
      content = '●（LED）';
    }
    return content;
  }

  //湃锐专属运动包围、蜂巢式动感前格栅、SPORT运动徽标（尾门）
  String convertTypeToVersionWG212223(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 2) {
      content = '—';
    } else if (index == 3 || index == 4) {
      content = '●';
    }
    return content;
  }

  //////内饰
  //澄净蓝色氛围内饰（蓝色缝线+饰件）
  String convertTypeToVersionNS1(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 2) {
      content = '●';
    } else {
      content = '—';
    }
    return content;
  }

  //多功能方向盘（带音响控制及4向调节）
  String convertTypeToVersionNS7(int index) {
    String content = '';
    if (index == 0) {
      content = '●';
    } else {
      content = '●（真皮）';
    }
    return content;
  }

  //前排遮阳板（带化妆镜）
  String convertTypeToVersionNS9(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 3) {
      content = '●';
    } else {
      content = '●（带照明）';
    }
    return content;
  }

  //车内照明系统
  String convertTypeToVersionNS10(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 3) {
      content = '●';
    } else {
      content = '●（LED）';
    }
    return content;
  }

  //高级皮质座椅
  String convertTypeToVersionNS12(int index) {
    String content = '';
    if (index == 0) {
      content = '—';
    } else if (index == 1 || index == 2) {
      content = '●';
    } else {
      content = '●（黑红双拼）';
    }
    return content;
  }

  //前排阅读灯
  String convertTypeToVersionNS17(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 3) {
      content = '●';
    } else if (index == 2) {
      content = '●（阅读灯）';
    } else if (index == 4) {
      content = '●（LED）';
    }
    return content;
  }
  //高保真扬声器系统
  String convertTypeToVersionSSBL10(int index) {
    String content = '';
    if (index == 0) {
      content = '●（2扬声器）';
    } else if (index == 1 || index == 3) {
      content = '●（4扬声器）';
    } else {
      content = '●（6扬声器）';
    }
    return content;
  }
}
