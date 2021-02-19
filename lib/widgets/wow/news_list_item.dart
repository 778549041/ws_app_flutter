import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class NewsListItem extends StatelessWidget {
  final NewModel model;
  NewsListItem({@required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('点击了推荐资讯');
      },
      child: Stack(
        children: <Widget>[
          if (model.isBgClear)
            Positioned(
              top: 22,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
              ),
            ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            color: model.isBgClear ? Colors.transparent : Color(0xFFF3F3F3),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      width: Get.width - 30,
                      height: (Get.width - 30) * 200 / 345,
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Image.asset('assets/images/wow/new_bottom_bg.png'),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      right: 10,
                      child: Text(
                        model.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: Get.width - 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateUtil.formatDateMs(int.parse(model.pubtime) * 1000,
                            format: DateFormats.y_mo_d),
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
                              model.read,
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
                              model.commentCount.toString(),
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
                              title: model.articlePraise.toString(),
                              fontSize: 12,
                              titleColor: Color(0xFF666666),
                              onPressed: () {},
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
