import 'package:html/dom.dart' as dom;
import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/wow/news_comment_model.dart';
import 'package:ws_app_flutter/view_models/wow/news_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class NewsDetailPage extends StatefulWidget {
  @override
  NewsDetailPageState createState() => NewsDetailPageState();
}

class NewsDetailPageState extends State<NewsDetailPage>
    with WidgetsBindingObserver {
  final NewsDetailController controller = Get.find<NewsDetailController>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '资讯',
      rightItems: <Widget>[
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
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 5),
                          child: Obx(() => Text(
                                controller.newsDetailModel.value.article!.title!,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Obx(
                                () => Text(
                                  DateUtil.formatDateMs(
                                      int.parse(controller.newsDetailModel.value
                                              .article!.pubtime!) *
                                          1000,
                                      format: DateFormats.h_m),
                                  style: TextStyle(
                                      color: MainAppColor.secondaryTextColor,
                                      fontSize: 12),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  '${controller.newsDetailModel.value.article?.read}人浏览',
                                  style: TextStyle(
                                      color: MainAppColor.secondaryTextColor,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Obx(
                            () => Html(
                              data: controller
                                  .newsDetailModel.value.article!.bodys!.content!,
                              onImageError: (exception, stackTrace) {},
                              onImageTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                                LogUtil.d(url);
                              },
                              onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                                LogUtil.d(url);
                              },
                            ),
                          ),
                        ),
                        Divider(
                          color: MainAppColor.seperatorLineColor,
                          height: 0.5,
                          indent: 15,
                          endIndent: 15,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        NewsCommentModel model = controller.list[index];
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
                        controller.newsDetailModel.value.article!.praiseStatus!,
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
                    likeCount:
                        controller.newsDetailModel.value.article!.articlePraise!,
                    countBuilder: (int? count, bool isLiked, String text) {
                      return Text(
                        text,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      );
                    },
                    onTap: (isLiked) =>
                        controller.praiseForArticleOrNot(isLiked),
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
                    title:
                        controller.newsDetailModel.value.article!.commentCount!,
                    fontSize: 12,
                    onPressed: () => controller.clickArticleCommentBtn(),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Obx(
                  () => LikeButton(
                    isLiked:
                        controller.newsDetailModel.value.article!.collectStatus!,
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
                            ? 'assets/images/wow/news_detail_favor_yes.png'
                            : 'assets/images/wow/news_detail_favor.png',
                      );
                    },
                    likeCount: int.parse(
                        controller.newsDetailModel.value.article!.collection!),
                    countBuilder: (int? count, bool isLiked, String text) {
                      return Text(
                        text,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      );
                    },
                    onTap: (isLiked) =>
                        controller.collectForArticleOrNot(isLiked),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCommentRow(NewsCommentModel model) {
    String _nickName = model.nickname!;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (model.memberInfo!.isSales == 1) {
      _accountType = '特约店销售顾问';
    } else if (model.isOfficial!) {
      _accountType = '官方账号';
    } else if (model.isVehicle!) {
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
                      onTap: () => controller.clickAvatar(model),
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
                                offstage: !model.isVehicle!,
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
                                      color: model.isOfficial!
                                          ? Color(0xFF2673FB)
                                          : Colors.black,
                                      fontSize: 15),
                                )),
                                //销售员或者勋章标签
                                if (model.memberInfo!.showTag!)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: MedalWidget(
                                      medalBtnImage:
                                          model.memberInfo!.medalOrSaleImageName!,
                                      medalToastImage: model
                                          .memberInfo!.medalOrSaleDescImageName!,
                                      isSales: model.memberInfo!.isSales == 1,
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
                    model.pubdate!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
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
                  likeCount: int.parse(model.praiseNum!),
                  countBuilder: (int? count, bool isLiked, String text) {
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
                ReplyModel replyModel = model.replyData![index];
                return GestureDetector(
                  onTap: () => controller.clickReplyComment(model, replyModel),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: RichText(
                      text: TextSpan(children: <InlineSpan>[
                        if (replyModel.isOfficial!)
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
              itemCount: model.replyData!.length,
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  ///应用尺寸改变时回调，例如旋转
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (MediaQuery.of(Get.context!).viewInsets.bottom == 0) {
        //关闭键盘
        LogUtil.d('关闭键盘');
        controller.placeholder.value = '我来说下~';
      } else {
        //显示键盘
        LogUtil.d('显示键盘');
      }
    });
  }

  @override
  void didUpdateWidget(NewsDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
