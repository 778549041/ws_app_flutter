import 'package:get/get.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/circle/circle_tab_controller.dart';
import 'package:ws_app_flutter/view_models/circle/faq_tab_controller.dart';

class CircleController extends GetxController {
  int tabIndex = 0; //当前tab，默认圈子tab

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<CircleTabController>(() => CircleTabController());
    Get.lazyPut<FAQTabController>(() => FAQTabController());
  }

  void tabIndexChanged(int index) {
    tabIndex = index;
  }

  //按钮事件
  void buttonAction(int index) {
    if (index == 1000) {
      //圈子搜索
      Get.toNamed(Routes.CIRCLESEARCH);
    } else if (index == 1001) {
      //添加好友
      Get.toNamed(Routes.ADDFRIEND);
    } else if (index == 1002) {
      //发布
      if (tabIndex == 0) {
        //发布动态
        Get.toNamed(Routes.CIRCLPUBLISH);
      } else if (tabIndex == 1) {
        //发布问题
        //TODO
        print('发布问题，待完成');
      }
    }
  }
}
