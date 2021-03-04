import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/moment_comment_model.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/circle_action_util.dart';
import 'package:ws_app_flutter/utils/common/common_util.dart';
import 'package:ws_app_flutter/view_models/circle/circle_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/views/global/gallery_photo_browser.dart';
import 'package:ws_app_flutter/views/global/video_play_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CircleDetailPage extends GetView<CircleDetailController> {
  final String circleId =
      Get.arguments == null ? null : Get.arguments['circle_id']; //圈子id
  final String commentId = Get.arguments == null
      ? null
      : Get.arguments['commentId'] ?? ''; //需要置顶的评论id

  @override
  Widget build(BuildContext context) {
    controller.circleId.value = circleId;
    controller.commentId.value = commentId;
    return BasePage(
      title: '圈子正文',
      rightActions: <Widget>[
        CustomButton(
          backgroundColor: Colors.transparent,
          image: 'assets/images/wow/icon_share.png',
          imageW: 30,
          imageH: 30,
          onPressed: () => controller.share(),
        ),
        SizedBox(
          width: 10,
        )
      ],
      child: Column(
        children: [
          Expanded(
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: false,
              onRefresh: () => controller.refresh(),
              enablePullUp: true,
              onLoading: () => controller.loadMore(),
              child: CustomScrollView(
                slivers: [
                  Obx(
                    () => SliverToBoxAdapter(
                      child: _buildDetailContent(),
                    ),
                  ),
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        MomentCommentModel model = controller.list[index];
                        return _buildCommentRow(model);
                      }, childCount: controller.list.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 55,
            padding: const EdgeInsets.only(left: 15, right: 15),
            color: Color(0xFFECECEC),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 40,
                    child: Obx(
                      () => TextField(
                        controller: controller.textEditingController,
                        focusNode: controller.focusNode,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFF999999), width: 0.5)),
                            hintText: controller.placeholder.value,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8)),
                        onSubmitted: (value) => controller.sendComment(value),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Obx(
                  () => LikeButton(
                    isLiked:
                        controller.momentDetailModel.value.list.praiseStatus,
                    size: 15,
                    countPostion: CountPostion.bottom,
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
                            : 'assets/images/wow/news_detail_praise.png',
                      );
                    },
                    likeCount: int.parse(
                        controller.momentDetailModel.value.list.praise),
                    countBuilder: (int count, bool isLiked, String text) {
                      return Text(
                        text,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      );
                    },
                    onTap: (isLiked) => CircleActionUtil().clickLikeButton(
                        isLiked, controller.momentDetailModel.value.list),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Obx(
                  () => CustomButton(
                    backgroundColor: Colors.transparent,
                    height: 32,
                    image: 'assets/images/wow/news_detail_comment.png',
                    imageH: 15,
                    imageW: 17,
                    imagePosition: XJImagePosition.XJImagePositionTop,
                    title: controller.momentDetailModel.value.list.comment,
                    fontSize: 12,
                    onPressed: () => controller.clickArticleCommentBtn(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailContent() {
    MomentModel model = controller.momentDetailModel.value.list;
    String _nickName = model.nickname;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (model.classify == '1') {
      if (model.memberInfo.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else {
        _accountType = '官方账号';
      }
    } else {
      if (model.memberInfo.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else if (model.userType == 2) {
        _accountType = '认证车主';
      } else if (model.userType == 3) {
        _accountType = '普通用户';
      }
    }

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //顶部行
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        //头像
                        GestureDetector(
                          onTap: () => controller.clickAvatar(model.memberId),
                          child: Stack(
                            children: <Widget>[
                              RoundAvatar(
                                imageUrl: model.avatar,
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
                                    Flexible(
                                        child: Text(
                                      _nickName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF2673FB),
                                          fontSize: 15),
                                    )),
                                    //销售员或者勋章标签
                                    if (model.memberInfo.showTag)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: CustomButton(
                                          backgroundColor: Colors.transparent,
                                          width: 30,
                                          height: 30,
                                          image: model
                                              .memberInfo.medalOrSaleImageName,
                                          onPressed: () =>
                                              CircleActionUtil().clickMedal(),
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  _accountType,
                                  style: TextStyle(
                                      color: Color(0xFF999999), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //顶部按钮行
                  if (model.classify != '1')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //加好友按钮
                        Offstage(
                          offstage: model.friendsRelation == 2 || model.isSelf,
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
                        //举报按钮
                        Offstage(
                          offstage: model.isSelf || !GetPlatform.isIOS,
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
              //圈子文本内容
              if (model.topicTitle.length +
                      model.content.length +
                      model.params.name.length >
                  0)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RichText(
                    text: TextSpan(
                        text: model.topicTitle,
                        style: TextStyle(
                          color: Color(0xFF2673FB),
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.CIRCLTOPICLIST,
                                arguments: {'topcid': model.topicId});
                          },
                        children: [
                          TextSpan(
                            text: model.content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                              text: model.params.name,
                              style: TextStyle(
                                color: Color(0xFF2673FB),
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  CommonUtil.serviceControlPushPage();
                                }),
                        ]),
                  ),
                ),
              //图片宫格
              if (model.type == '1')
                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.fileList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (model.fileList.length > 1) ? 2 : 1,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                              GalleryPhotoPage(
                                heroName: (model.fileList[index].savepath +
                                    'circleDetailPage'),
                                galleryItems: model.fileList,
                                initialIndex: index,
                                backgroundDecoration:
                                    const BoxDecoration(color: Colors.black),
                              ),
                              transition: Transition.fadeIn);
                        },
                        child: Hero(
                          tag: (model.fileList[index].savepath +
                              'circleDetailPage'),
                          child: CachedNetworkImage(
                            imageUrl: model.fileList[index].savepath,
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
                          VideoPalyPage(
                            videoUrl: model.fileList[0].savepath,
                          ),
                          transition: Transition.fadeIn);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl:
                              '${model.fileList[0].savepath}?vframe/jpg/offset/0',
                          fit: BoxFit.cover,
                        ),
                        Image.asset('assets/images/circle/circle_play.png',
                            width: 100, height: 100, fit: BoxFit.fill),
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: MainAppColor.seperatorLineColor,
                height: 0.5,
              ),
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
    );
  }

  Widget _buildCommentRow(MomentCommentModel model) {
    String _nickName = model.nickname;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (model.memberInfo.isSales == 1) {
      _accountType = '特约店销售顾问';
    } else if (model.isOfficial) {
      _accountType = '官方账号';
    } else if (model.isVehicle) {
      _accountType = '认证车主';
    } else {
      _accountType = '普通用户';
    }
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //顶部行
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    //头像
                    GestureDetector(
                      onTap: () => controller.clickAvatar(model.userId),
                      child: Stack(
                        children: <Widget>[
                          RoundAvatar(
                            imageUrl: model.avatar,
                            height: 40,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Offstage(
                                offstage: !model.isVehicle,
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
                                      color: model.isOfficial
                                          ? Color(0xFF2673FB)
                                          : Colors.black,
                                      fontSize: 15),
                                )),
                                //销售员或者勋章标签
                                if (model.memberInfo.showTag)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: CustomButton(
                                      backgroundColor: Colors.transparent,
                                      width: 30,
                                      height: 30,
                                      image:
                                          model.memberInfo.medalOrSaleImageName,
                                      onPressed: () => controller.clickMedal(),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              _accountType,
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //顶部按钮行
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //时间
                  Text(
                    model.pubdate,
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                  //删除按钮
                  Offstage(
                    offstage: !model.isSelf,
                    child: CustomButton(
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
                                child: Text('是否确认删除评论',
                                    style: TextStyle(fontSize: 16.0)),
                              ),
                              onConfirm: () => controller.deleteComment(model),
                            ),
                            barrierDismissible: false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          //评论内容
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Expanded(
                    child: RichText(
                  text: TextSpan(
                      text: model.content,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => controller.clickComment(model)),
                )),
                LikeButton(
                  isLiked: false,
                  size: 15,
                  countPostion: CountPostion.bottom,
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
                          : 'assets/images/wow/news_detail_praise.png',
                    );
                  },
                  likeCount: int.parse(model.praiseNum),
                  countBuilder: (int count, bool isLiked, String text) {
                    return Text(
                      text,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    );
                  },
                  onTap: (isLiked) =>
                      controller.praiseForCommentOrNot(isLiked, model),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 50),
            color: Color(0xFFECECEC),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                MomentCommentReplyModel replyModel = model.replyData[index];
                return GestureDetector(
                  onTap: () => controller.clickReplyComment(model, replyModel),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: RichText(
                      text: TextSpan(children: <InlineSpan>[
                        if (replyModel.isOfficial)
                          WidgetSpan(
                            child: Image.asset(
                                'assets/images/wow/ve_offical_tag.png'),
                          ),
                        TextSpan(
                          text: replyModel.plName,
                          style: TextStyle(
                              color: MainAppColor.mainBlueBgColor,
                              fontSize: 11),
                        ),
                        TextSpan(
                          text: '回复',
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        ),
                        TextSpan(
                          text: replyModel.replyName,
                          style: TextStyle(
                              color: MainAppColor.mainBlueBgColor,
                              fontSize: 11),
                        ),
                        TextSpan(
                          text: '：${replyModel.content}',
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        ),
                      ]),
                    ),
                  ),
                );
              },
              itemCount: model.replyData.length,
            ),
          ),
          // Offstage(
          //   offstage: model.replyData.length <= 2,
          //   child: Container(
          //     margin: const EdgeInsets.only(top: 10, left: 50),
          //     child: CustomButton(
          //       backgroundColor: Colors.transparent,
          //       width: 40,
          //       title: '全文',
          //       titleColor: MainAppColor.mainBlueBgColor,
          //       onPressed: () {
          //         //TODO
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
