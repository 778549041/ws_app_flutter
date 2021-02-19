import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/mine/msg_center_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class MsgCenterPage extends GetView<MsgCenterController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '消息中心',
      child: CustomScrollView(
        slivers: [
          SliverStickyHeader(
            header: Container(
              color: Colors.white,
              height: 190.0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  _buildHeaderRow(
                    0,
                    Badge(
                      showBadge: false,
                      elevation: 0,
                      shape: BadgeShape.circle,
                      padding: EdgeInsets.all(7),
                      badgeContent: Text(
                        '',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: MainAppColor.seperatorLineColor,
                  ),
                  _buildHeaderRow(
                    1,
                    Badge(
                      elevation: 0,
                      shape: BadgeShape.circle,
                      padding: EdgeInsets.all(7),
                      badgeContent: Text(
                        '9',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: MainAppColor.seperatorLineColor,
                  ),
                  Container(
                    height: 38,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '全部会话',
                      style: TextStyle(color: Color(0xFF1B7DF4), fontSize: 14),
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: MainAppColor.seperatorLineColor,
                  ),
                ],
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text('0'),
                  ),
                  title: Text('List tile #$i'),
                ),
                childCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(int index, Widget content) {
    String _image, _title;
    if (index == 0) {
      _image = 'assets/images/mine/mine_msg_active.png';
      _title = '互动消息';
    } else if (index == 1) {
      _image = 'assets/images/mine/mine_msg_system.png';
      _title = '系统消息';
    }
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  _image,
                  width: 26,
                  height: 24,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  _title,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            content,
          ],
        ),
      ),
    );
  }
}
