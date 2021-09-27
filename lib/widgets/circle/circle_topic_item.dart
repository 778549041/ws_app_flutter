import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_topic_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/circle/topic_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_topic_follow_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class CircleTopicItem extends StatelessWidget {
  final TopicModel model; //数据
  final int type; //类型,0全部话题,1我的创建话题,2我的申请话题,3我的关注话题,4动态发布选择话题

  CircleTopicItem(this.model, this.type);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (type == 4) {
          Get.find<TopicController>().selectTopic(model);
        } else {
          Get.toNamed(Routes.CIRCLTOPICLIST,
              arguments: {'topcid': model.topicId!});
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                NetImageWidget(
                  imageUrl: model.imageUrl!,
                  width: 110,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.title!,
                        style: TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '动态${model.join!}',
                            style: TextStyle(
                                fontSize: 12,
                                color: MainAppColor.secondaryTextColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '关注${model.follow_num!}',
                            style: TextStyle(
                                fontSize: 12,
                                color: MainAppColor.secondaryTextColor),
                          ),
                        ],
                      ),
                      Text(
                        model.pubtime != null
                            ? model.pubtime!.substring(0, 10)
                            : model.create_time != null
                                ? model.create_time!.substring(0, 10)
                                : '',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFFD3D1D1)),
                      ),
                    ],
                  ),
                ),
                _buildRightItem(),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color(0xFFD6D6D6),
              height: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightItem() {
    if (type == 0) {
      return !(model.hot! || model.isNew!)
          ? Container()
          : Image.asset(
              model.tagImg!,
              width: 35,
              height: 20,
            );
    } else if (type == 1) {
      String examine = '';
      Color color = Color(0xFFFFA258);
      if (model.examine == 0) {
        examine = '待审核';
      } else if (model.examine == 1) {
        examine = '审核通过';
        color = Color(0xFF3EAE20);
      } else if (model.examine == 2) {
        examine = '被驳回';
        color = Color(0xFFE50808);
      }
      return Text(
        examine,
        style: TextStyle(fontSize: 13, color: color),
      );
    } else if (type == 2) {
      String examine = '';
      Color color = Color(0xFFFFA258);
      if (model.examine == 0) {
        examine = '待审核加入';
      } else if (model.examine == 1) {
        examine = '已加入';
        color = Color(0xFF3EAE20);
      } else if (model.examine == 2) {
        examine = '被拒绝';
        color = Color(0xFFE50808);
      }
      return Row(
        children: <Widget>[
          Offstage(
            offstage: model.status != 2,
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              child: Image.asset(
                'assets/images/circle/topic_refuse.png',
                width: 20,
                height: 20,
              ),
            ),
          ),
          Text(
            examine,
            style: TextStyle(fontSize: 13, color: color),
          ),
        ],
      );
    } else if (type == 3) {
      return CustomButton(
        width: 63,
        height: 23,
        image: 'assets/images/circle/cancel_follow.png',
        onPressed: () =>
            Get.find<MineTopicFollowController>().cancelFollow(model),
      );
    } else if (type == 4) {
      return model.selected!
          ? Image.asset(
              'assets/images/circle/topic_selected.png',
              width: 20,
              height: 20,
            )
          : Container();
    }
    return Container();
  }
}
