import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/wow/news_comment_model.dart';
import 'package:ws_app_flutter/view_models/wow/news_detail_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class NewsDetailPage extends GetView<NewsDetailController> {
  final String articleId =
      Get.arguments == null ? null : Get.arguments['article_id'];
  final String cateStr =
      Get.arguments == null ? null : Get.arguments['cateStr'];

  @override
  Widget build(BuildContext context) {
    controller.articleId.value = articleId;
    return BasePage(
      title: '资讯',
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
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 5),
                          child: Obx(() => Text(
                                controller.newsDetailModel.value.article.title,
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
                                              .article.pubtime) *
                                          1000,
                                      format: DateFormats.h_m),
                                  style: TextStyle(
                                      color: MainAppColor.secondaryTextColor,
                                      fontSize: 12),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  '${controller.newsDetailModel.value.article.read}人浏览',
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
                                  .newsDetailModel.value.article.bodys.content,
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
          // MsgInput(conversition.userID,1),
        ],
      ),
    );
  }

  Widget _buildCommentRow(NewsCommentModel model) {
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
                      onTap: () {
                        //TODO
                      },
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
                                      onPressed: () {
                                        //TODO
                                      },
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
                        //TODO
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
                  child: Text(
                    model.content,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                CustomButton(
                  backgroundColor: Colors.transparent,
                  width: 50,
                  height: 30,
                  titleColor: Color(0xFF999999),
                  image: 'assets/images/wow/new_list_praise.png',
                  imageH: 15,
                  imageW: 20,
                  fontSize: 11,
                  onPressed: () {
                    //TODO
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
