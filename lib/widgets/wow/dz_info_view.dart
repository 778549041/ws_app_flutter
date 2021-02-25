import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:ws_app_flutter/models/wow/cdz_info_model.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class DZInfoView extends StatelessWidget {
  final SingleCDZInfo info;
  final VoidCallback jumpListCallback;
  final VoidCallback mapNavCallback;

  DZInfoView({this.info, this.jumpListCallback, this.mapNavCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: jumpListCallback != null ? jumpListCallback : null,
      child: Container(
        width: ScreenUtil.getInstance().screenWidth,
        color: Colors.transparent,
        height: 233,
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
                      info.stationName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: ScreenUtil.getInstance().screenWidth - 126.5,
                    child: Text(
                      '营业时间:${info.busineHours}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
                            '共${info.kuai}个',
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
                            '共${info.man}个',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Image.asset(
                            _getOperatorImage(info),
                            width: 12,
                            height: 13.5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            _getOperatorName(info),
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: '充电价格:',
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                text: info.price,
                                style: TextStyle(
                                  color: Color(0xFF0045D0),
                                  fontSize: 11.0,
                                ),
                              ),
                              TextSpan(
                                text: '元/度',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: RichText(
                            text: TextSpan(
                              text: '服务费:',
                              style:
                                  TextStyle(fontSize: 13.0, color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(
                                  text: info.servicePrice,
                                  style: TextStyle(
                                    color: Color(0xFF0045D0),
                                    fontSize: 11.0,
                                  ),
                                ),
                                TextSpan(
                                  text: '元/度',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
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
                            info.address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
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
                          'assets/images/wow/icon_park_car.png',
                          width: 12,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          width: ScreenUtil.getInstance().screenWidth - 50,
                          child: Text(
                            (info.parkFee != null && info.parkFee.length > 0)
                                ? info.parkFee
                                : '无',
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
                onPressed: mapNavCallback != null ? mapNavCallback : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getOperatorName(SingleCDZInfo info) {
    String operatorName = '';
    if (info.serviceType == '1') {
      operatorName = '特来电充电';
    } else if (info.serviceType == '2') {
      operatorName = '国翰充电';
    } else if (info.serviceType == '3') {
      operatorName = '星星充电';
    }
    return operatorName;
  }

  String _getOperatorImage(SingleCDZInfo info) {
    String operatorImage = '';
    if (info.serviceType == '1') {
      operatorImage = 'assets/images/wow/icon_tld_dz.png';
    } else if (info.serviceType == '2') {
      operatorImage = 'assets/images/wow/icon_gh_dz.png';
    } else if (info.serviceType == '3') {
      operatorImage = 'assets/images/wow/icon_xx_dz.png';
    }
    return operatorImage;
  }
}
