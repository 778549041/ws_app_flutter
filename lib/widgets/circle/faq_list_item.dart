import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
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

class FAQListItem extends StatelessWidget {
  final FAQModel model;
  final bool isDetail;

  FAQListItem({required this.model, this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeadRow(model.member_info!, false),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              model.content!,
              style: TextStyle(fontSize: 15),
            ),
          ),
          _buildBottomRow(),
          if (!isDetail) _buildAnswerItem(),
        ],
      ),
    );
  }

  //头像、昵称部分
  Widget _buildHeadRow(CommonMemberModel memberModel, bool isAnswer) {
    String _nickName = memberModel.nickname!;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (memberModel.isSales == 1) {
      _accountType = '特约店销售顾问';
    } else if (memberModel.userType == 2) {
      _accountType = '认证车主';
    } else if (memberModel.userType == 3) {
      _accountType = '普通用户';
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
                          if (isAnswer && model.answers_accept!)
                            Image.asset(
                                'assets/images/circle/faq_answer_accept.png')
                          else if (model.is_hots != null && model.is_hots!)
                            Image.asset('assets/images/circle/faq_hot.png'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //删除按钮,如果不是回答的头部且问题是自己提的并且没有采纳过任何回答
              if (!isAnswer && model.is_oneself! && !model.answers_accept!)
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
                          child: Text('是否确认删除提问',
                              style: TextStyle(fontSize: 16.0)),
                        ),
                        onConfirm: () => deleteQuestion(),
                      ),
                      barrierDismissible: false,
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  //发布时间、点赞量部分
  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          model.pubtime!.substring(0, 10),
          style: TextStyle(
            color: Color(0xFF666666),
            fontSize: 12,
          ),
        ),
        LikeButton(
          isLiked: model.is_praise!,
          size: 15,
          circleColor:
              CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
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
          onTap: (isLiked) => praiseForQuestion(isLiked),
        ),
      ],
    );
  }

  //回答部分
  Widget _buildAnswerItem() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          if (model.answers_info != null)
            Container(
              color: Color(0xFFECECEC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeadRow(model.answers_info!.member_info!, true),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, top: 10, right: 15),
                    child: Text(
                      model.answers_info!.content!,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
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
                          countBuilder:
                              (int? count, bool isLiked, String text) {
                            return Text(
                              text,
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 12),
                            );
                          },
                          onTap: (isLiked) => praiseForAnswer(isLiked),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.FAQDETAILPAGE,
                  arguments: {'question_id': model.id!});
            },
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color(0xFFECECEC),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '当前有${model.answers == null ? 0 : model.answers!}个回答',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Image.asset(
                    'assets/images/enjoy/enjoy_right_arrow.png',
                    width: 9,
                    height: 15,
                    color: Color(0xFF1B7DF4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //删除提问
  void deleteQuestion() async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.deleteQuestionUrl,
        params: {'question_id': model.id!});
    if (res.result! && res.code! == '200') {
    } else {
      EasyLoading.showToast(res.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  //问题点赞
  Future<bool> praiseForQuestion(bool isLiked) async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.questionPraiseUrl,
        params: {'question_id': model.id!});
    if (res.result! && res.code! == '200') {
      return !isLiked;
    } else {
      EasyLoading.showToast(res.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
      return isLiked;
    }
  }

  //回答点赞
  Future<bool> praiseForAnswer(bool isLiked) async {
    CommonModel res = await DioManager().request<CommonModel>(
        DioManager.POST, Api.answerPraiseUrl,
        params: {'answers_id': model.answers_info!.id!});
    if (res.result! && res.code! == '200') {
      return !isLiked;
    } else {
      EasyLoading.showToast(res.message!,
          toastPosition: EasyLoadingToastPosition.bottom);
      return isLiked;
    }
  }
}
