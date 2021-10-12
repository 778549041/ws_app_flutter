import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/models/common/common_member.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class FAQAnswerListItem extends StatelessWidget {
  final AnswerModel model;

  FAQAnswerListItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeadRow(model.member_info!),
          Container(
            margin: const EdgeInsets.only(left: 50, top: 10, bottom: 10),
            child: Text(
              model.content!,
              style: TextStyle(fontSize: 15),
            ),
          ),
          _buildBottomRow(),
        ],
      ),
    );
  }

  //头像、昵称部分
  Widget _buildHeadRow(CommonMemberModel memberModel) {
    String _nickName = memberModel.nickname!;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (memberModel.isOfficial!) {
      if (memberModel.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else {
        _accountType = '官方账号';
      }
    } else {
      if (memberModel.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else if (memberModel.userType == 2) {
        _accountType = '认证车主';
      } else if (memberModel.userType == 3) {
        _accountType = '普通用户';
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              //头像
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.USERPROFILE,
                      arguments: {'user_id': memberModel.memberId!});
                },
                child: Stack(
                  children: <Widget>[
                    RoundAvatar(
                      imageUrl: memberModel.avatar,
                      height: 40,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Offstage(
                          offstage: memberModel.userType != 2,
                          child: Image.asset(
                            'assets/images/mine/vip_tag.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          )),
                    )
                  ],
                ),
              ),
              //昵称和账号类型
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: Text(
                            _nickName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFF2673FB), fontSize: 15),
                          )),
                          //销售员或者勋章标签
                          if (memberModel.showTag!)
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: MedalWidget(
                                medalBtnImage: memberModel.medalOrSaleImageName,
                                medalToastImage:
                                    memberModel.medalOrSaleDescImageName,
                                isSales: memberModel.isSales == 1,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              _accountType,
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: 12),
                            ),
                          ),
                          if (model.is_accept!)
                            Image.asset(
                                'assets/images/circle/faq_answer_accept.png'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //删除按钮,如果是自己的回答并且当前回答未被采纳
              if (model.is_oneself! && !model.is_accept!)
                CustomButton(
                  backgroundColor: Colors.transparent,
                  width: 50,
                  height: 23,
                  title: '删除',
                  titleColor: Color(0xFF999999),
                  image: 'assets/images/wow/news_detail_delete_comment.png',
                  imageH: 15,
                  imageW: 20,
                  fontSize: 11,
                  onPressed: () {
                    Get.dialog(
                      BaseDialog(
                        content: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text('是否确认删除回答',
                              style: TextStyle(fontSize: 16.0)),
                        ),
                        onConfirm: () => deleteAnswer(),
                      ),
                      barrierDismissible: false,
                    );
                  },
                ),
              //如果当前提问是自己的提问并且该提问还未采纳任何回答，则采纳按钮显示
              if (model.questionIsSelf! && !model.questionHasAccept!)
                CustomButton(
                  backgroundColor: Colors.transparent,
                  width: 63,
                  height: 23,
                  image: 'assets/images/circle/faq_accept.png',
                  imageH: 23,
                  imageW: 63,
                  onPressed: () {
                    //TODO
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  //点赞部分
  Widget _buildBottomRow() {
    return Container(
      margin: const EdgeInsets.only(left: 50),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              LikeButton(
                isLiked: model.is_praise!,
                size: 15,
                circleColor: CircleColor(
                    start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
                likeBuilder: (bool isLiked) {
                  return Image.asset(
                    isLiked
                        ? 'assets/images/wow/news_detail_praise_yes.png'
                        : 'assets/images/wow/new_list_praise.png',
                  );
                },
                likeCount: int.parse(model.praise!),
                countBuilder: (int? count, bool isLiked, String text) {
                  return Text(
                    text,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                  );
                },
                onTap: (isLiked) => praiseForAnswer(isLiked),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: MainAppColor.seperatorLineColor,
            height: 0.5,
          )
        ],
      ),
    );
  }

  //删除回答
  void deleteAnswer() async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.deleteAnswerUrl,
        params: {'answers_id': model.id!});
    if (res.result! && res.code! == '200') {
      //TODO
    } else {
      EasyLoading.showToast(res.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //采纳回答
  void acceptAnswer() async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.acceptAnswerUrl,
        params: {'answers_id': model.id!});
    if (res.result! && res.code! == '200') {
      //TODO
    } else {
      EasyLoading.showToast(res.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //回答点赞
  Future<bool> praiseForAnswer(bool isLiked) async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.answerPraiseUrl,
        params: {'answers_id': model.id!});
    if (res.result! && res.code! == '200') {
      return !isLiked;
    } else {
      EasyLoading.showToast(res.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
      return isLiked;
    }
  }
}
