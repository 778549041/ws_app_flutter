import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/wow/recommend_controller.dart';

class CircleListItem extends GetView<RecommendController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      color: Color(0xFFF3F3F3),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[],
          ),
          RichText(
            text: TextSpan(text: '', children: []),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Hero(
                        tag: '',
                        child: CachedNetworkImage(
                          imageUrl: '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
