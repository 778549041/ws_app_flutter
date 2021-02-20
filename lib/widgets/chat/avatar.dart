import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  String avtarUrl = '';
  double width = 0;
  double height = 0;
  double radius = 0;
  Avatar({avtarUrl, width, height, radius}) {
    this.avtarUrl = avtarUrl;
    this.width = width.toDouble();
    this.height = height.toDouble();
    this.radius = radius.toDouble();
  }

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
                    StackTrace stackTrace) {
                  print("图片渲染失败");
                  return Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xFFededed),
                      ),
                      top: BorderSide(
                        width: 1,
                        color: Color(0xFFededed),
                      ),
                      left: BorderSide(
                        width: 1,
                        color: Color(0xFFededed),
                      ),
                      right: BorderSide(
                        width: 1,
                        color: Color(0xFFededed),
                      ),
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
