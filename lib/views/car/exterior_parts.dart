import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExteriorPartsPage extends StatelessWidget {
  final List<String> titles = [
    '车顶行李架',
    '挡泥板\n（普通、时尚黑、高级灰）',
    '门下饰条',
    '侧裙饰条',
    '尾门饰条',
    '后保险杠饰条',
    '车窗饰条',
    '车门雨挡',
    '后视镜饰条'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'EXTERIOR外型篇',
              style: TextStyle(color: Color(0xFFFCA807), fontSize: 18),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'WOW！帅爆',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 44),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                '打破千篇一律，用个性主张颠覆潮流走向。纯正用品为你打造专属的外型装备，满足你的个性需要，所到之处，引发一片WOW声尖叫。',
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
        Image.asset('assets/images/car/exterior_parts_$index.png'),
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