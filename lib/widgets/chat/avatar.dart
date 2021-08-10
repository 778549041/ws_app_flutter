import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avtarUrl;
  final double width;
  final double height;
  final double radius;

  Avatar({
    this.avtarUrl = '',
    this.width = 0,
    this.height = 0,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: width,
        height: height,
        child: avtarUrl.indexOf('http') > -1
            ? Image.network(
                avtarUrl,
                width: width,
                height: height,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  print("图片渲染失败");
                  return Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Color(0xFFededed),
                    )),
                  );
                },
              )
            : Image(
                image: AssetImage(avtarUrl),
                width: width,
                height: height,
              ),
      ),
    );
  }
}
