import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/wow/charge_pile_model.dart';
import 'package:ws_app_flutter/view_models/wow/ele_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class EleListPage extends GetView<EleListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Obx(
        () => CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              ChargePileInfo info = controller.list[index];
              return Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Text(
                        info.connectorName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        info.connectorID!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/wow/icon_parking.png',
                            width: 44,
                            height: 18,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              (info.parkNo != null && info.parkNo!.length > 0)
                                  ? info.parkNo!
                                  : '无',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color.fromRGBO(38, 178, 198, 1),
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: info.power,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromRGBO(0, 69, 208, 1),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'KW | ',
                              style: TextStyle(
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontSize: 16.0,
                              ),
                            ),
                            TextSpan(
                              text: info.voltageLowerLimits,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromRGBO(0, 69, 208, 1),
                              ),
                            ),
                            TextSpan(
                              text: 'v - ',
                              style: TextStyle(
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontSize: 16.0,
                              ),
                            ),
                            TextSpan(
                              text: info.voltageUpperLimits,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromRGBO(0, 69, 208, 1),
                              ),
                            ),
                            TextSpan(
                              text: 'v',
                              style: TextStyle(
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontSize: 16.0,
                              ),
                            ),
                            TextSpan(
                              text: '(${info.current}v)',
                              style: TextStyle(
                                color: Color.fromRGBO(173, 173, 173, 1),
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        _getDesc(info.connectorType!),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, bottom: 0, left: 0, right: 0),
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }, childCount: controller.list.length))
          ],
        ),
      ),
    );
  }

  String _getDesc(String type) {
    String desc = '';
    if (type == '1') {
      desc = "家用插座（模式2）";
    } else if (type == '2') {
      desc = "交流接口插座（模式3，连接方式B ）";
    } else if (type == '3') {
      desc = "交流接口插头（带枪线，模式3，连接方式C）";
    } else if (type == '4') {
      desc = "直流接口枪头（带枪线，模式4）";
    } else if (type == '5') {
      desc = "无线充电座";
    } else if (type == '6') {
      desc = "其他";
    }
    return desc;
  }
}
