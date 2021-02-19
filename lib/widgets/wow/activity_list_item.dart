import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/wow/activity_model.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ActivityListItem extends StatelessWidget {
  final ActivityModel model;
  ActivityListItem({@required this.model});

  @override
  Widget build(BuildContext context) {
    var _mingE = '';
    var _addrImage = '';
    var _time = '';
    var _timeColor = Colors.transparent;

    if (model.limit == '-1') {
      _mingE = '名额:不限';
    } else {
      _mingE = '名额:${model.apply}/${model.limit}';
    }

    DateTime _endTime =
        DateUtil.getDateTimeByMs(int.parse(model.toTime) * 1000);
    DateTime _beginTime =
        DateUtil.getDateTimeByMs(int.parse(model.fromTime) * 1000);
    DateTime _nowTime = DateTime.now();

    if (_beginTime.difference(_nowTime).inDays > 0) {
      //未开始
      _timeColor = Color(0xFFBD1051);
      _addrImage = 'assets/images/wow/active_addr_red.png';
      _time = '未开始';
    } else if (_nowTime.difference(_endTime).inDays > 0) {
      //已结束
      _timeColor = Color(0xFFADADAD);
      _addrImage = 'assets/images/wow/active_addr_grey.png';
      _time = '已结束';
    } else {
      //进行中
      _timeColor = Color(0xFF1C7AF4);
      _addrImage = 'assets/images/wow/active_addr_blue.png';
      _time = '进行中';
    }

    return GestureDetector(
      onTap: () {
        print('点击了活动');
      },
      child: Stack(
        children: <Widget>[
          // if (model.isBgClear)
          //   Positioned(
          //     top: 22,
          //     left: 0,
          //     right: 0,
          //     bottom: 0,
          //     child: Container(
          //       decoration: BoxDecoration(
          //           color: Color(0xFFF3F3F3),
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(10),
          //               topRight: Radius.circular(10))),
          //     ),
          //   ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            color: model.isBgClear ? Colors.transparent : Color(0xFFF3F3F3),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: (model.imgUrl.split('?')).first,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              model.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          if (model.limit != '0')
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                _mingE,
                                style: TextStyle(
                                    color: Color(0xFFADADAD), fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (model.auth == 'car')
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/wow/icon_car_owner.png',
                          width: 62.5,
                          height: 62.5,
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  width: Get.width - 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            _time,
                            style: TextStyle(
                              color: _timeColor,
                              fontSize: 12,
                            ),
                          ),
                          if (model.store.address.length > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    _addrImage,
                                    width: 11,
                                    height: 13,
                                  ),
                                  Text(
                                    model.store.address,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: _timeColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: CustomButton(
                          backgroundColor: Color(0xFF4345E5),
                          width: 65,
                          height: 21,
                          title: '查看详情',
                          radius: 10.5,
                          fontSize: 11,
                          titleColor: Colors.white,
                          onPressed: () {},
                        ),
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
