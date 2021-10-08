import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/view_models/mine/circle_tag_manage_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CircleTagManagePage extends GetView<CircleTagManageController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '标签管理',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMyTags(),
            Divider(
              color: MainAppColor.seperatorLineColor,
              height: 0.5,
            ),
            _buildAllTags(),
          ],
        ),
      ),
    );
  }

  Widget _buildMyTags() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '我的标签',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                '长按管理标签',
                style: TextStyle(
                    fontSize: 12, color: MainAppColor.secondaryTextColor),
              ),
            ),
            CustomButton(
              width: 40,
              height: 20,
              title: '编辑',
              titleColor: Colors.orange,
              fontSize: 12,
              borderColor: Colors.orange,
              borderWidth: 0.5,
              radius: 5,
              onPressed: () {
                //TODO
              },
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Obx(
            () => ReorderableWrap(
              spacing: 12,
              runSpacing: 20,
              needsLongPressDraggable: true,
              onReorder: (int oldIndex, int newIndex) {},
              buildDraggableFeedback: (BuildContext context,
                  BoxConstraints constraints, Widget child) {
                return Transform(
                  transform: new Matrix4.rotationZ(0),
                  alignment: FractionalOffset.topLeft,
                  child: Material(
                    child:
                        ConstrainedBox(constraints: constraints, child: child),
                    elevation: 6.0,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                );
              },
              children: List.generate(controller.myTags.length, (index) {
                CircleTagModel model = controller.myTags[index];
                return ReorderableWidget(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 5),
                        width: (Get.width - 106) / 4,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF1B7DF4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          model.title!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Offstage(
                          offstage: false,
                          child: CustomButton(
                            backgroundColor: Colors.transparent,
                            image:
                                'assets/images/circle/circle_delete_image.png',
                            imageH: 17,
                            imageW: 17,
                            onPressed: () {
                              //TODO
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  reorderable: true,
                  key: Key(model.title!),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAllTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '全部标签',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Obx(
            () => Wrap(
              spacing: 12,
              runSpacing: 20,
              children: List.generate(controller.allTags.length, (index) {
                CircleTagModel model = controller.allTags[index];
                return GestureDetector(
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    width: (Get.width - 86) / 4,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 0.5, color: MainAppColor.seperatorLineColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: AutoSizeText(
                      '+' + model.title!,
                      minFontSize: 6,
                      style: TextStyle(fontSize: 15),
                      maxLines: 1,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
