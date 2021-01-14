import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/wow/moment_model.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';
import 'package:ws_app_flutter/views/global/gallery_photo_browser.dart';
import 'package:ws_app_flutter/views/global/video_play_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class CircleListItem extends GetView<RecommendController> {
  final int index;

  CircleListItem({@required this.index});

  @override
  Widget build(BuildContext context) {
    MomentModel _moment = controller.momentListModel.value.list[index];
    String _nickName = _moment.nickname;
    if (_nickName.length > 11) {
      _nickName = _nickName.substring(0, 11);
    }

    String _accountType = '';
    if (_moment.classify == '1') {
      if (_moment.memberInfo.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else {
        _accountType = '官方账号';
      }
    } else {
      if (_moment.memberInfo.isSales == 1) {
        _accountType = '特约店销售顾问';
      } else if (_moment.userType == 2) {
        _accountType = '认证车主';
      } else if (_moment.userType == 3) {
        _accountType = '普通用户';
      }
    }

    return GestureDetector(
      onTap: () {
        print('点击了推荐圈子的第$index个单元格');
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        color: Color(0xFFF3F3F3),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                //顶部行
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //头像
                        GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: <Widget>[
                                RoundAvatar(
                                  imageUrl: _moment.avatar,
                                  height: 40,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Offstage(
                                      offstage: _moment.userType != 2,
                                      child: Image.asset(
                                        'assets/images/mine/vip_tag.png',
                                        width: 18,
                                        height: 18,
                                        fit: BoxFit.cover,
                                      )),
                                )
                              ],
                            )),
                        //昵称和账号类型
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _nickName,
                                style: TextStyle(
                                    color: Color(0xFF2673FB), fontSize: 15),
                              ),
                              Text(
                                _accountType,
                                style: TextStyle(
                                    color: Color(0xFF999999), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        //销售员或者勋章标签
                        if (_moment.memberInfo.showTag)
                          CustomButton(
                            backgroundColor: Colors.transparent,
                            width: 30,
                            height: 30,
                            image: _moment.memberInfo.medalOrSaleImageName,
                            onPressed: () {},
                          ),
                      ],
                    ),
                    //顶部按钮行
                    if (_moment.classify != '1')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          if (_moment.friendsRelation != 2 ||
                              !_moment.isSelf) //加好友按钮
                            CustomButton(
                              backgroundColor: Colors.transparent,
                              width: 73,
                              height: 23,
                              borderColor: Color(0xFF999999),
                              title: '加好友',
                              titleColor: Color(0xFF999999),
                              fontSize: 11,
                              borderWidth: 0.5,
                              radius: 11.5,
                              onPressed: () {},
                            ),
                          if (_moment.isSelf) //删除按钮
                            CustomButton(
                              backgroundColor: Colors.transparent,
                              width: 40,
                              height: 23,
                              borderColor: Color(0xFF999999),
                              title: '删除',
                              titleColor: Color(0xFF999999),
                              fontSize: 11,
                              borderWidth: 0.5,
                              radius: 11.5,
                              onPressed: () {},
                            ),
                          if (!_moment.isSelf && GetPlatform.isIOS) //举报按钮
                            CustomButton(
                              backgroundColor: Colors.transparent,
                              width: 73,
                              height: 23,
                              borderColor: Color(0xFF999999),
                              title: '举报/屏蔽',
                              titleColor: Color(0xFF999999),
                              fontSize: 11,
                              borderWidth: 0.5,
                              radius: 11.5,
                              onPressed: () {},
                            ),
                        ],
                      ),
                  ],
                ),
                //圈子文本内容
                if (_moment.topicTitle.length +
                        _moment.content.length +
                        _moment.params.name.length >
                    0)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                      maxLines: 5,
                      text: TextSpan(
                          text: _moment.topicTitle,
                          style: TextStyle(
                            color: Color(0xFF2673FB),
                            fontSize: 15,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('点击话题');
                            },
                          children: [
                            TextSpan(
                              text: _moment.content,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                                text: _moment.params.name,
                                style: TextStyle(
                                  color: Color(0xFF2673FB),
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('点击跳转链接');
                                  }),
                          ]),
                    ),
                  ),
                //图片宫格
                if (_moment.type == '1')
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _moment.fileList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (_moment.fileList.length > 1) ? 2 : 1,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                GalleryPhotoPage(
                                  galleryItems: _moment.fileList,
                                  initialIndex: index,
                                  backgroundDecoration:
                                      const BoxDecoration(color: Colors.black),
                                ),
                                transition: Transition.fadeIn);
                          },
                          child: Hero(
                            tag: _moment.fileList[index].savepath,
                            child: CachedNetworkImage(
                              imageUrl: _moment.fileList[index].savepath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                //视频
                if (_moment.type == '2')
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                            VideoPalyPage(
                              videoUrl: _moment.fileList[0].savepath,
                            ),
                            transition: Transition.fadeIn);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl:
                                '${_moment.fileList[0].savepath}?vframe/jpg/offset/0',
                            fit: BoxFit.cover,
                          ),
                          Image.asset('assets/images/circle/circle_play.png',
                              width: 100, height: 100, fit: BoxFit.fill),
                        ],
                      ),
                    ),
                  ),
                //底部时间和浏览量等
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _moment.pubtime.substring(0, 10),
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
                              _moment.visitsNum,
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 12),
                            ),
                          ),
                          Image.asset(
                            'assets/images/wow/icon_comment.png',
                            width: 19,
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              _moment.comment,
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: CustomButton(
                              backgroundColor: Colors.transparent,
                              width: 50,
                              height: 30,
                              image: 'assets/images/wow/new_list_praise.png',
                              imageW: 13.5,
                              imageH: 12,
                              imagePosition:
                                  XJImagePosition.XJImagePositionLeft,
                              title: _moment.praise,
                              fontSize: 12,
                              titleColor: Color(0xFF666666),
                              onPressed: () {},
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            //优质圈子标签
            if (_moment.isGood == 'true')
              Positioned(
                right: 10,
                top: 50,
                child:
                    Image.asset('assets/images/circle/icon_high_quality.png'),
              ),
          ],
        ),
      ),
    );
  }
}
