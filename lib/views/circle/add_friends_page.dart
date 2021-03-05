import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/circle/add_friend_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class AddFriendPage extends GetView<AddFriendsController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '添加好友',
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 35,
                    child: TextField(
                      controller: controller.textEditingController,
                      focusNode: controller.focusNode,
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: MainAppColor.secondaryTextColor,
                                  width: 0.5)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8)),
                      onChanged: (value) {
                        controller.searchKey = value;
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    //TODO
                  },
                  child: Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFF1B7DF4),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/circle/icon_search_white.png',
                          width: 17,
                          height: 17,
                        ),
                        Text(
                          '搜索',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        height: 50,
                        color: Colors.red,
                      );
                    }, childCount: 10),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
