import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class InteriorPartsPage extends StatelessWidget {
  final List<String> titles = [
    'LED流光踏板',
    '足部气氛灯',
    '防水行李厢垫',
    '动感踏板',
    '时尚地毯',
    '便携式电动滑板车',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'INTERIOR内饰篇',
              style: TextStyle(color: Color(0xFFFCA807), fontSize: 18),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'WOW！惬意',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 44),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                '感官上的舒适享受，源于每一处细节的品质沉淀。纯正用品不仅追求精湛的工艺，还注入了人性化设计，为你打造一个惬意而舒适的私享空间。',
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
        Image.asset('assets/images/car/interior_parts_$index.png'),
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
