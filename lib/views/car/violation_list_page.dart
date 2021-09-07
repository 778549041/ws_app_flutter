import 'package:flutter/material.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/views/base_page.dart';

class ViolationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '违章查询',
      bgColor: MainAppColor.mainSilverColor,
      child: CustomScrollView(
        slivers: [
          // Obx(
          // () => controller.isEmpty()
          //     ? SliverToBoxAdapter(
          //         child: ViewStateEmptyWidget(
          //           image: 'assets/images/common/empty.png',
          //           message: '空空如也',
          //           buttonText: '重新加载',
          //           onPressed: () => controller.refresh(),
          //         ),
          //       )
          //     :
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildItem(index);
              },
              childCount: 10,
            ),
          ),
          // )
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 10),
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      decoration: BoxDecoration(
        border: Border.all(color: MainAppColor.seperatorLineColor, width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '违章代码：123456',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '违章地址：湖北省武汉市XX路',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '处罚单位：',
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                child: Text(
                  'XX市XX分区交通警察大队',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              text: '违章扣分：',
              style: TextStyle(color: Colors.black, fontSize: 15),
              children: [
                TextSpan(
                  text: '5分',
                  style: TextStyle(color: Color(0xFF4245E5), fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '处罚描述：',
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                child: Text(
                  'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              text: '应缴金额：',
              style: TextStyle(color: Colors.black, fontSize: 15),
              children: [
                TextSpan(
                  text: '200元',
                  style: TextStyle(color: Color(0xFF4245E5), fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Text(
                '2021.09.07',
                style: TextStyle(
                    color: MainAppColor.secondaryTextColor, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
