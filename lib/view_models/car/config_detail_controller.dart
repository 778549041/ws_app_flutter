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

  //高灵敏泊车雷达（后4探头）
  String convertTypeToVersionLD(int index) {
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

  //侧安全气帘
  String convertTypeToVersionCAQQL(int index) {
    String content = '';
    if (index == 0 || index == 1 || index == 3) {
      content = '—';
    }else if (index == 2 || index == 4) {
      content = '●';
    }
    return content;
  }
}
