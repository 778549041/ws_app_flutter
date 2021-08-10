import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SwitchLoadingView extends StatelessWidget {
  final double? width; //宽
  final double? height; //高
  final bool selected; //是否选中
  final String? unselectedText; //未选中文本
  final String? selectedText; //选中文本
  final TextStyle textStyle;
  final Color? bgColor; //背景色
  final Color? loadingColor; //loading颜色
  final Color disabledColor; //禁用时背景色
  final bool loading; //是否加载
  final bool disabled; //是否可点击
  final VoidCallback? callback; //事件回调

  SwitchLoadingView({
    this.width,
    this.height,
    this.selected = false,
    this.unselectedText,
    this.selectedText,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 11),
    this.bgColor,
    this.loadingColor,
    this.disabledColor = const Color(0xFFCCCCCC),
    this.loading = false,
    this.disabled = false,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : callback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height! / 2),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              padding: EdgeInsets.only(left: height!),
              decoration: BoxDecoration(
                color: disabled ? disabledColor : bgColor,
                borderRadius: BorderRadius.circular(height! / 2),
              ),
              child: Text(
                unselectedText!,
                style: textStyle,
              ),
            ),
            AnimatedPositioned(
              left: selected ? 0 : height! - width!,
              duration: Duration(milliseconds: 200),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: disabled ? disabledColor : bgColor,
                  borderRadius: BorderRadius.circular(height! / 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: width! - height!,
                      height: height,
                      child: Text(
                        selectedText!,
                        style: textStyle,
                      ),
                    ),
                    Container(
                      width: height,
                      height: height,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: height! - 2,
                            height: height! - 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular((height! - 2) / 2),
                            ),
                          ),
                          Offstage(
                            offstage: !loading,
                            child: SpinKitCircle(
                              color: loadingColor,
                              size: height! - 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
