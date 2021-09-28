import 'package:flutter/material.dart';
import 'package:ws_app_flutter/models/circle/topic_apply_join_model.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
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
                Column(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _nickName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xFF2673FB), fontSize: 15),
                    )),
                    Text(
                      _accountType,
                      style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
