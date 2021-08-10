import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';

class RecommendActItem extends GetView<RecommendController> {
  final ActivityModel model;
  RecommendActItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.WEBVIEW,
            arguments: {'url': model.url, 'hasNav': model.isHeader == 'true'});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
              child: CachedNetworkImage(
                imageUrl: model.imageUrl!,
                width: 95,
                height: 95,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.introduce!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      (model.fromTime == model.toTime)
                          ? '活动时间：${DateUtil.formatDateMs(int.parse(model.fromTime!) * 1000, format: DateFormats.y_mo_d)}'
                          : '活动时间：${DateUtil.formatDateMs(int.parse(model.fromTime!) * 1000, format: DateFormats.y_mo_d)}~${DateUtil.formatDateMs(int.parse(model.toTime!) * 1000, format: DateFormats.y_mo_d)}',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
