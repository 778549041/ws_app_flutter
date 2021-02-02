import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/mine/pwd_manage_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class PwdManagePage extends GetView<PwdManageController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '管理密码',
      rightActions: [],
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: 3,
          itemBuilder: (context, index) {
            String _item = controller.data[index];
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => controller.listItemClick(index),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 59,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _item,
                            style: TextStyle(fontSize: 15),
                          ),
                          Image.asset(
                            'assets/images/mine/mine_right_arrow.png',
                            width: 7.5,
                            height: 11,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      height: 0.5,
                      color: Color(0xFFD6D6D6),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
