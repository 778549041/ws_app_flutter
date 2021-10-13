import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/env_config.dart';
import 'package:ws_app_flutter/global/html_urls.dart';
import 'package:ws_app_flutter/models/circle/circle_hot_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';

class CircleHeaderHot extends StatelessWidget {
  final List<CircleHotData> list;

  CircleHeaderHot({required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '热门榜',
            style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          StaggeredGridView.countBuilder(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              return _buildGridItem(index);
            },
            itemCount: list.length + 1,
          )
        ],
      ),
    );
  }

  Widget _buildGridItem(int index) {
    if (index == list.length) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.toNamed(Routes.CIRCLEHOTORE);
        },
        child: Container(
          height: 30,
          padding: const EdgeInsets.only(left: 27),
          alignment: AlignmentDirectional.centerStart,
          child: Image.asset(
            'assets/images/circle/hot_more_hot.png',
            width: 76,
            height: 14,
            scale: 2,
          ),
        ),
      );
    }
    CircleHotData item = list[index];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (item.type == 1) {
          String _url = '';
          if (item.is_custom!) {
            _url = item.url!;
          } else {
            _url = Env.envConfig.serviceUrl +
                HtmlUrls.ActivityDetailsPage +
                '?is_online=${item.is_online!}&is_vote=${item.is_vote!}&activity_id=${item.huodong_id!}';
          }
          Get.toNamed(Routes.WEBVIEW, arguments: {'url': _url, 'hasNav': true});
        } else if (item.type == 2) {
          Get.toNamed(Routes.NEWSDETAIL,
              arguments: {'article_id': item.article_id!});
        } else if (item.type == 3) {
          Get.toNamed(Routes.CIRCLTOPICLIST,
              arguments: {'topcid': item.topic_id!});
        }
      },
      child: Container(
        height: 30,
        child: Row(
          children: <Widget>[
            Image.asset(
              item.typeImgName!,
              width: 22,
              height: 12,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                item.title!,
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
