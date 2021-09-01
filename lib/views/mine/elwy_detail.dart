import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/package_detail.dart';
import 'package:ws_app_flutter/view_models/mine/elwy_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class ElwyDetail extends GetView<ElwyDetailController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '套餐详情',
      bgColor: MainAppColor.mainSilverColor,
      child: Obx(
        () => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildItem(index);
                },
                childCount: controller.model.value.list?.card_list == null
                    ? 0
                    : controller.model.value.list!.card_list!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            controller.model.value.list?.FCardBagName == null
                ? ''
                : controller.model.value.list!.FCardBagName!,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '兑换时间：${controller.model.value.list?.createtime == null ? '' : controller.model.value.list!.createtime!}',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '特约店：${controller.model.value.list?.store == null ? '' : controller.model.value.list!.store!}',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    PackageBag bag = controller.model.value.list!.card_list![index];
    return GestureDetector(
      onTap: () {
        if (bag.card_state! != 0) {
          Get.dialog(_buildQRDialog(bag.FCode!), barrierDismissible: false);
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: bag.card_state == 0
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: <Widget>[
            NetImageWidget(
              imageUrl: bag.FLocalLogoPath,
              width: 85,
              height: 85,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bag.FTitle!,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    bag.FNotice!,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (bag.card_state == 1)
                    Text(
                      '有效期至：${bag.FEndDate!}',
                      style: TextStyle(fontSize: 12),
                    ),
                ],
              ),
            ),
            if (bag.card_state == 1)
              Image.asset(
                'assets/images/mine/package_qr.png',
                width: 25,
                height: 25,
              ),
            if (bag.card_state == 0)
              Text(
                '已核销',
                style: TextStyle(
                    fontSize: 12, color: MainAppColor.secondaryTextColor),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRDialog(String qrStr) {
    return AnimatedPadding(
      padding: MediaQuery.of(Get.context!).viewInsets +
          EdgeInsets.symmetric(horizontal: 15.0, vertical: 24.0),
      duration: Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: Get.context!,
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 400,
              width: Get.width - 30,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CustomButton(
                      width: 30,
                      height: 30,
                      imageH: 15,
                      imageW: 15,
                      radius: 7.5,
                      image: 'assets/images/common/icon_close.png',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      QrImage(
                        data: qrStr,
                        version: QrVersions.auto,
                        size: 200,
                        gapless: false,
                        embeddedImage:
                            AssetImage('assets/images/mine/package_qr.png'),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(40, 40),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          qrStr,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
