import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/review_comment_list_model.dart';
import 'package:ws_app_flutter/view_models/circle/comment_review_controller.dart';
import 'package:ws_app_flutter/views/global/gallery_photo_browser.dart';
import 'package:ws_app_flutter/views/global/video_play_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CommentReviewItem extends StatelessWidget {
  final ReviewCommentModel model;

  CommentReviewItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            color: Color(0xFFECECEC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeadRow(),
                SizedBox(
                  height: 10,
                ),
                _buildContentBody(),
              ],
            ),
          ),
          _buildComment(),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: MainAppColor.seperatorLineColor,
            height: 1.0,
          ),
          _buildBtnRow(),
        ],
      ),
    );
  }

  //顶部头像、昵称部分
  Widget _buildHeadRow() {
    String _nickName = model.circleInfo!.nickname!;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }
    return Row(
      children: <Widget>[
        RoundAvatar(
          imageUrl: model.circleInfo?.avatar,
          height: 40,
        ),
        SizedBox(
          width: 14,
        ),
        Expanded(
          child: Text(
            _nickName,
            style: TextStyle(color: Color(0xFF1B7DF4), fontSize: 15),
          ),
        ),
        Text(
          model.circleInfo!.pubtime!.substring(0, 10),
          style:
              TextStyle(color: MainAppColor.secondaryTextColor, fontSize: 12),
        ),
      ],
    );
  }

  //圈子内容部分
  Widget _buildContentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (model.circleInfo?.content != null &&
            model.circleInfo!.content!.length > 0)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: RichText(
              maxLines: 5,
              text: TextSpan(
                  text: model.circleInfo?.topicTitle != null
                      ? model.circleInfo!.topicTitle!
                      : '',
                  style: TextStyle(
                    color: Color(0xFF2673FB),
                    fontSize: 13,
                  ),
                  // recognizer: TapGestureRecognizer()
                  //   ..onTap = () {
                  //     LogUtil.d('点击话题');
                  //     Get.toNamed(Routes.CIRCLTOPICLIST,
                  //         arguments: {'topcid': model.topicId!});
                  //   },
                  children: [
                    TextSpan(
                      text: model.circleInfo?.content != null
                          ? model.circleInfo!.content!
                          : '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: model.circleInfo?.params?.name != null
                          ? model.circleInfo!.params!.name
                          : '',
                      style: TextStyle(
                        color: Color(0xFF2673FB),
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () {
                      //     LogUtil.d('点击跳转链接');
                      //     CommonUtil.serviceControlPushPage(
                      //         type: model.params!.type,
                      //         detailId: model.params!.detailId,
                      //         url: model.params!.url,
                      //         hasNav: false);
                      //   },
                    ),
                  ]),
            ),
          ),
        //图片宫格
        if (model.circleInfo!.type == '1')
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.circleInfo!.fileList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (model.circleInfo!.fileList!.length > 1) ? 2 : 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        () => GalleryPhotoPage(
                              heroName: (model
                                      .circleInfo!.fileList![index].savepath! +
                                  'commentReviewPage'),
                              galleryItems: model.circleInfo!.fileList!,
                              initialIndex: index,
                              backgroundDecoration:
                                  const BoxDecoration(color: Colors.black),
                            ),
                        transition: Transition.fadeIn);
                  },
                  child: Hero(
                    tag: (model.circleInfo!.fileList![index].savepath! +
                        'commentReviewPage'),
                    child: CachedNetworkImage(
                      imageUrl: model.circleInfo!.fileList![index].savepath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        //视频
        if (model.circleInfo!.type == '2')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(
                    () => VideoPalyPage(
                          videoUrl: model.circleInfo!.fileList![0].savepath!,
                        ),
                    transition: Transition.fadeIn);
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl:
                        '${model.circleInfo!.fileList![0].savepath!}?vframe/jpg/offset/0',
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

  //评论
  Widget _buildComment() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 27),
      child: RichText(
        text: TextSpan(children: <InlineSpan>[
          TextSpan(
            text: model.replyData!.plName,
            style: TextStyle(color: MainAppColor.mainBlueBgColor, fontSize: 11),
          ),
          TextSpan(
            text: model.replyData?.replyName == null ? ' 评论' : ' 回复',
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
          if (model.replyData?.replyName != null)
            TextSpan(
              text: model.replyData!.replyName,
              style:
                  TextStyle(color: MainAppColor.mainBlueBgColor, fontSize: 11),
            ),
          TextSpan(
            text: '：${model.replyData!.content}',
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        ]),
      ),
    );
  }

  Widget _buildBtnRow() {
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
                Get.find<CommentReviewController>().reviewAction(2, model),
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
                Get.find<CommentReviewController>().reviewAction(3, model),
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
                Get.find<CommentReviewController>().reviewAction(1, model),
          ),
        ],
      ),
    );
  }
}
