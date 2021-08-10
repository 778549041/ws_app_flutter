import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/car/near_store_model.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class StoreInfoView extends StatelessWidget {
  final NearStoreModel info;
  final VoidCallback mapNavCallback;

  StoreInfoView({required this.info, required this.mapNavCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      color: Colors.transparent,
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 22),
            padding: EdgeInsets.only(left: 17, top: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().screenWidth - 126.5,
                  child: Text(
                    info.fShopName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/wow/icon_cd_fast.png',
                        width: 18,
                        height: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          '共${info.block}个',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Image.asset(
                          'assets/images/wow/icon_cd_slow.png',
                          width: 18,
                          height: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          '共${info.slow}个',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/wow/dz_store_phone.png',
                        width: 17,
                        height: 17,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: ScreenUtil.getInstance().screenWidth - 50,
                        child: RichText(
                          text: TextSpan(
                              text: info.fSalesPhone,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: MainAppColor.mainBlueBgColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  //拨号
                                  if (await canLaunch(
                                      'tel:${info.fSalesPhone}')) {
                                    launch('tel:${info.fSalesPhone}');
                                  }
                                }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/wow/icon_cdz_location.png',
                        width: 12,
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: ScreenUtil.getInstance().screenWidth - 50,
                        child: Text(
                          info.fShopAddr!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 27,
            top: 0,
            child: CustomButton(
              width: 77.5,
              height: 77.5,
              imageH: 38.75,
              imageW: 38.75,
              image: 'assets/images/wow/icon_ele_map_nav.png',
              radius: 38.75,
              blurRadius: 6,
              spreadRadius: 4,
              shadowColorA: 20,
              onPressed: mapNavCallback,
            ),
          ),
        ],
      ),
    );
  }
}
