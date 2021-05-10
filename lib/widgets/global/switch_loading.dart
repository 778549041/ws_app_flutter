import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SwitchLoadingView extends StatefulWidget {
  final double width; //宽
  final double height; //高
  final bool selected; //是否选中
  final String unselectedText; //未选中文本
  final String selectedText; //选中文本
  final TextStyle textStyle;
  final Color bgColor; //背景色
  final Color loadingColor; //loading颜色
  final bool loading; //是否加载
  final bool disabled; //是否可点击
  final ValueChanged<bool> callback; //事件回调

  SwitchLoadingView({
    this.width,
    this.height,
    this.selected = false,
    this.unselectedText,
    this.selectedText,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 11),
    this.bgColor,
    this.loadingColor,
    this.loading = false,
    this.disabled = false,
    this.callback,
  });

  @override
  SwitchLoadingViewState createState() => SwitchLoadingViewState();
}

class SwitchLoadingViewState extends State<SwitchLoadingView> {
  bool selected = false;
  bool loading = false;
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              setState(() {
                selected = !selected;
                loading = true;
                disabled = true;
                if (widget.callback != null) {
                  widget.callback(selected);
                }
              });
              Future.delayed(Duration(seconds: 2)).then((value) {
                setState(() {
                  loading = false;
                  disabled = false;
                });
              });
            },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height / 2),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: widget.width,
              height: widget.height,
              padding: EdgeInsets.only(left: widget.height),
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
              child: Text(
                widget.unselectedText,
                style: widget.textStyle,
              ),
            ),
            AnimatedPositioned(
              left: selected ? 0 : widget.height - widget.width,
              duration: Duration(milliseconds: 200),
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.bgColor,
                  borderRadius: BorderRadius.circular(widget.height / 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: widget.width - widget.height,
                      height: widget.height,
                      child: Text(
                        widget.selectedText,
                        style: widget.textStyle,
                      ),
                    ),
                    Container(
                      width: widget.height,
                      height: widget.height,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: widget.height - 2,
                            height: widget.height - 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  (widget.height - 2) / 2),
                            ),
                          ),
                          Offstage(
                            offstage: !loading,
                            child: SpinKitCircle(
                              color: widget.loadingColor,
                              size: widget.height - 2,
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

  @override
  void initState() {
    selected = widget.selected;
    loading = widget.loading;
    disabled = widget.disabled;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(SwitchLoadingView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies:didChangeDependencies');
    super.didChangeDependencies();
  }
}
