import 'package:flutter/material.dart';
import 'package:ws_app_flutter/models/circle/topic_apply_join_model.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class MemberReviewItem extends StatelessWidget {
  final TopicApplyJoinModel model; //数据
  final int type; //类型,0我的审核,1我的成员

  MemberReviewItem(this.model, this.type);

  @override
  Widget build(BuildContext context) {
    String _nickName = model.memberInfo!.nickname!;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (model.memberInfo!.isSales == 1) {
      _accountType = '特约店销售顾问';
    } else if (model.memberInfo?.userType == 2) {
      _accountType = '认证车主';
    } else if (model.memberInfo?.userType == 3) {
      _accountType = '普通用户';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              RoundAvatar(
                imageUrl: model.memberInfo?.avatar,
                height: 70,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Offstage(
                    offstage: model.memberInfo?.userType != 2,
                    child: Image.asset(
                      'assets/images/mine/vip_tag.png',
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _nickName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFF2673FB), fontSize: 15),
                ),
                Text(
                  _accountType,
                  style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                ),
                if (model.status == 0)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      '申请加入话题',
                      style: TextStyle(color: Color(0xFF1B7DF4), fontSize: 15),
                    ),
                  ),
              ],
            ),
          ),
          _buildRightItem(),
        ],
      ),
    );
  }

  Widget _buildRightItem() {
    if (type == 1) {
      return Container();
    }
    if (model.status == 0) {
      return Column(
        children: <Widget>[
          CustomButton(
            width: 66,
            height: 23,
            title: '通过',
            titleColor: Colors.white,
            fontSize: 12,
            radius: 11.5,
            backgroundColor: Color(0xFF1B7DF4),
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            width: 66,
            height: 23,
            title: '拒绝',
            fontSize: 12,
            titleColor: Colors.white,
            radius: 11.5,
            backgroundColor: Color(0xFFD03126),
            onPressed: () {},
          ),
        ],
      );
    }
    String status = '';
    Color color = Colors.white;
    if (model.status == 1) {
      status = '已通过';
      color = Color(0xFF3EAE20);
    } else if (status == 2) {
      status = '已拒绝';
      color = Color(0xFFE50808);
    }
    return Text(
      status,
      style: TextStyle(color: color, fontSize: 15),
    );
  }
}
