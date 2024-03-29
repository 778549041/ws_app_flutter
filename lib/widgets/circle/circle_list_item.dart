import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/circle_action_util.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/view_models/circle/moment_review_controller.dart';
import 'package:ws_app_flutter/views/global/gallery_photo_browser.dart';
import 'package:ws_app_flutter/views/global/video_play_page.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CircleListItem extends StatelessWidget {
  final MomentModel model;
  final String pageName;
  final bool? enabledClick;

  CircleListItem(
      {required this.model, required this.pageName, this.enabledClick = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (enabledClick!) {
          LogUtil.d('点击了圈子');
          Get.toNamed(Routes.CIRCLEDETAIL,
              arguments: {'circle_id': model.circleId});
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //顶部行
                _buildHeadRow(),
                //圈子文本内容
                _buildContentBody(),
                //底部时间和浏览量等
                _buildBottomRow(),
              ],
            ),
            //优质圈子标签
            if (model.isGood == 'true')
              Positioned(
                right: 10,
                top: 30,
                child: Image.asset(
                  'assets/images/circle/icon_high_quality.png',
                  width: 43,
                  height: 43,
                ),
              ),
          ],
        ),
      ),
    );
  }

  //头像、昵称部分
  Widget _buildHeadRow() {
    String _nickName = model.nickname!;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (model.classify == '1') {
      if (model.memberInfo!.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else {
        _accountType = '官方账号';
      }
    } else {
      if (model.memberInfo!.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else if (model.userType == 2) {
        _accountType = '认证车主';
      } else if (model.userType == 3) {
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
                      arguments: {'user_id': model.memberId});
                },
                child: Stack(
                  children: <Widget>[
                    RoundAvatar(
                      imageUrl: model.avatar!,
                      height: 40,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Offstage(
                          offstage: model.userType != 2,
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
                          Expanded(
                              child: Text(
                            _nickName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFF2673FB), fontSize: 15),
                          )),
                          //销售员或者勋章标签
                          if (model.memberInfo!.showTag!)
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: MedalWidget(
                                medalBtnImage:
                                    model.memberInfo!.medalOrSaleImageName,
                                medalToastImage:
                                    model.memberInfo!.medalOrSaleDescImageName,
                                isSales: model.memberInfo!.isSales == 1,
                              ),
                            ),
                          //顶部按钮行
                          if (model.classify != '1')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                //加好友按钮
                                Offstage(
                                  offstage: model.friendsRelation == 2 ||
                                      model.isSelf!,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: CustomButton(
                                      backgroundColor: Colors.transparent,
                                      width: 73,
                                      height: 23,
                                      borderColor: Color(0xFF999999),
                                      title: '加好友',
                                      titleColor: Color(0xFF999999),
                                      fontSize: 11,
                                      borderWidth: 0.5,
                                      radius: 11.5,
                                      onPressed: () =>
                                          CircleActionUtil().addFriend(model),
                                    ),
                                  ),
                                ),
                                //删除按钮
                                Offstage(
                                  offstage: !model.isSelf!,
                                  child: CustomButton(
                                    backgroundColor: Colors.transparent,
                                    width: 50,
                                    height: 23,
                                    title: '删除',
                                    titleColor: Color(0xFF999999),
                                    image:
                                        'assets/images/wow/news_detail_delete_comment.png',
                                    imageH: 15,
                                    imageW: 20,
                                    fontSize: 11,
                                    onPressed: () {
                                      Get.dialog(
                                          BaseDialog(
                                            content: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 8.0),
                                              child: Text('是否确认删除动态',
                                                  style: TextStyle(
                                                      fontSize: 16.0)),
                                            ),
                                            onConfirm: () => CircleActionUtil()
                                                .deleteMoment(model),
                                          ),
                                          barrierDismissible: false);
                                    },
                                  ),
                                ),
                                if (GetPlatform.isIOS)
                                  //举报按钮
                                  Offstage(
                                    offstage: model.isSelf!,
                                    child: CustomButton(
                                      backgroundColor: Colors.transparent,
                                      width: 73,
                                      height: 23,
                                      borderColor: Color(0xFF999999),
                                      title: '举报/屏蔽',
                                      titleColor: Color(0xFF999999),
                                      fontSize: 11,
                                      borderWidth: 0.5,
                                      radius: 11.5,
                                      onPressed: () {
                                        Get.toNamed(Routes.REPORT);
                                      },
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                      Text(
                        _accountType,
                        style:
                            TextStyle(color: Color(0xFF999999), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //圈子内容部分
  Widget _buildContentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (model.topicTitle!.length +
                model.content!.length +
                model.params!.name!.length >
            0)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: RichText(
              maxLines: 5,
              text: TextSpan(
                  text: model.topicTitle != null ? model.topicTitle! : '',
                  style: TextStyle(
                    color: Color(0xFF2673FB),
                    fontSize: 15,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      LogUtil.d('点击话题');
                      Get.toNamed(Routes.CIRCLTOPICLIST,
                          arguments: {'topcid': model.topicId!});
                    },
                  children: [
                    TextSpan(
                      text: model.content != null ? model.content! : '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                        text: model.params?.name != null
                            ? model.params!.name
                            : '',
                        style: TextStyle(
                          color: Color(0xFF2673FB),
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            LogUtil.d('点击跳转链接');
                            CommonUtil.serviceControlPushPage(
                                type: model.params!.type,
                                detailId: model.params!.detailId,
                                url: model.params!.url,
                                hasNav: false);
                          }),
                  ]),
            ),
          ),
        //图片宫格
        if (model.type == '1')
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.fileList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (model.fileList!.length > 1) ? 2 : 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        () => GalleryPhotoPage(
                              heroName:
                                  (model.fileList![index].savepath! + pageName),
                              galleryItems: model.fileList!,
                              initialIndex: index,
                              backgroundDecoration:
                                  const BoxDecoration(color: Colors.black),
                            ),
                        transition: Transition.fadeIn);
                  },
                  child: Hero(
                    tag: (model.fileList![index].savepath! + pageName),
                    child: CachedNetworkImage(
                      imageUrl: model.fileList![index].savepath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        //视频
        if (model.type == '2')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(
                    () => VideoPalyPage(
                          videoUrl: model.fileList![0].savepath!,
                        ),
                    transition: Transition.fadeIn);
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl:
                        '${model.fileList![0].savepath!}?vframe/jpg/offset/0',
                    fit: BoxFit.cover,
                  ),
                  Image.asset('assets/images/circle/circle_play.png',
                      width: 100, height: 100, fit: BoxFit.fill),
                ],
              ),
            ),
          )
      ],
    );
  }

  //发布时间、浏览量、评论量、点赞量部分
  Widget _buildBottomRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            model.pubtime!.substring(0, 10),
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset(
                'assets/images/wow/browse_eye.png',
                width: 14.5,
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  model.visitsNum!,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                ),
              ),
              Image.asset(
                'assets/images/wow/icon_comment.png',
                width: 19,
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  model.comment!,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                ),
              ),
              LikeButton(
                isLiked: model.praiseStatus,
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
                onTap: (isLiked) =>
                    CircleActionUtil().clickLikeButton(isLiked, model),
              ),
            ],
          )
        ],
      ),
    );
  }

  //审核、置顶、加优质部分
  Widget _buildReviewRow() {
    //TODO
    return Container();
  }

  Widget _buildReviewBtnRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: <Widget>[
          CustomButton(
            width: (Get.width - 90) / 3,
            height: 30,
            radius: 15,
            borderWidth: 0.5,
            borderColor: Color(0xFFE50808),
            title: '审核不通过',
            titleColor: Color(0xFFE50808),
            fontSize: 15,
            onPressed: () =>
                Get.find<MomentReviewController>().reviewAction(3, model),
          ),
          SizedBox(
            width: 30,
          ),
          CustomButton(
            width: (Get.width - 90) / 3,
            height: 30,
            radius: 15,
            borderWidth: 0.5,
            borderColor: Colors.black,
            title: '仅自己可见',
            titleColor: Colors.black,
            fontSize: 15,
            onPressed: () =>
                Get.find<MomentReviewController>().reviewAction(2, model),
          ),
          SizedBox(
            width: 30,
          ),
          CustomButton(
            width: (Get.width - 90) / 3,
            height: 30,
            radius: 15,
            borderWidth: 0.5,
            borderColor: Color(0xFF3EAE20),
            title: '审核通过',
            titleColor: Color(0xFF3EAE20),
            fontSize: 15,
            onPressed: () =>
                Get.find<MomentReviewController>().reviewAction(1, model),
          ),
        ],
      ),
    );
  }
}
