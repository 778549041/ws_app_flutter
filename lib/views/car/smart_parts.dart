import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SmartPartsPage extends StatelessWidget {
  final List<String> titles = [
    'GPS防盗智能警报系统',
    '行车记录仪（高级版）',
    '车载冷暖杯架',
    '后排双USB接口'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'SMART智能篇',
              style: TextStyle(color: Color(0xFFFCA807), fontSize: 18),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'WOW！高能',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 44),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                '智能科技让出行变得简单，让旅途变得有趣。搭载高端科技的纯正用品，用先进智慧为你快速解决出行中的各种问题，让你从容掌控，驾享随心',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          SliverStaggeredGrid.countBuilder(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 15,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              return _buildGridItem(index);
            },
            itemCount: titles.length,
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/car/smart_parts_$index.png'),
        SizedBox(
          height: 5,
        ),
        Text(
          titles[index],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}
