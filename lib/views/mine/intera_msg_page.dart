import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/mine/intera_msg_model.dart';
import 'package:ws_app_flutter/view_models/mine/intera_msg_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class InteraMsgPage extends GetView<InteraMsgController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '互动消息',
      child: SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        onRefresh: () => controller.refresh(),
        onLoading: () => controller.loadMore(),
        child: CustomScrollView(
          slivers: [
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _buildMsgRow(index);
                }, childCount: controller.list.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMsgRow(int index) {
    InteraModel model = controller.list[index];
    late String? content;
    if (model.type == 'friends') {
      if (model.inv == 1) {
        //别人加自己为好友
        content = '请求添加您为好友';
      } else {
        //自己加别人为好友
        content = '请求添加对方为好友';
      }
    } else if (model.type == 'content_comment_praise') {
      content = '点赞了您的资讯评论';
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                RoundAvatar(
                  height: 60,
                  borderWidth: 3,
                  imageUrl: model.avatar,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.name ?? '无昵称'),
                      Text(
                        content!,
                        style: TextStyle(
                            color: MainAppColor.secondaryTextColor,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                _buildRightWidget(model),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: MainAppColor.seperatorLineColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightWidget(InteraModel model) {
    if (model.type == 'content_comment_praise') {
      return CustomButton(
        title: '查看',
        titleColor: Color(0xFFBD1051),
        fontSize: 13,
        width: 50,
        height: 30,
        radius: 5,
        borderWidth: 1,
        borderColor: Color(0xFFBD1051),
        onPressed: () {},
      );
    } else if (model.type == 'friends') {
      if (model.inv == 1) {
        //别人加自己为好友
        if (model.status == 1) {
          //等待验证
          return Column(
            children: <Widget>[
              CustomButton(
                title: '同意',
                titleColor: Color(0xFF4245E5),
                fontSize: 13,
                width: 50,
                height: 30,
                radius: 5,
                borderWidth: 1,
                borderColor: Color(0xFF4245E5),
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                title: '拒绝',
                titleColor: MainAppColor.secondaryTextColor,
                fontSize: 13,
                width: 50,
                height: 30,
                radius: 5,
                borderWidth: 1,
                borderColor: MainAppColor.secondaryTextColor,
                onPressed: () {},
              ),
            ],
          );
        } else {
          //已同意
          return Text(
            '已同意',
            style: TextStyle(color: Colors.blueAccent, fontSize: 14),
          );
        }
      } else if (model.inv == 2) {
        //自己加别人为好友
        if (model.status == 1) {
          //等待验证
          return Text(
            '等待验证',
            style: TextStyle(color: Colors.blueAccent, fontSize: 14),
          );
        } else {
          //已同意
          return Text(
            '已添加',
            style: TextStyle(color: Colors.blue, fontSize: 14),
          );
        }
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
