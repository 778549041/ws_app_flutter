import 'package:flutter/material.dart';

class MomentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 60,
                  color: Colors.red,
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
