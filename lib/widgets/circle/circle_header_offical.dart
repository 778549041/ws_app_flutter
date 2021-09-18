import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/net_image_widget.dart';

class CircleHeaderOfficial extends StatelessWidget {
  final List<MomentModel> list;

  CircleHeaderOfficial({required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '官方动态',
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              CustomButton(
                width: 34,
                height: 20,
                image: 'assets/images/circle/circle_more.png',
                imageW: 34,
                imageH: 20,
                onPressed: () {
                  Get.toNamed(Routes.SINGLECIRCLELIST,
                      arguments: {'memberId': '0'});
                },
              ),
            ],
          ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length > 2 ? 2 : list.length,
            itemBuilder: (context, idx) {
              return _buildOfficialItem(idx);
            },
          ),
        ],
      ),
    );
  }

  //官方动态item
  Widget _buildOfficialItem(int index) {
    MomentModel item = list[index];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.CIRCLEDETAIL,
            arguments: {'circle_id': item.circleId!});
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            NetImageWidget(
              imageUrl: item.image_url,
              width: 85,
              height: 52,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                item.content!,
                style: TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
