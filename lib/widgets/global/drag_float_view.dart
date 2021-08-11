import 'package:flutter/material.dart';

class DragFloatView extends StatefulWidget {
  final Widget child;
  DragFloatView({required this.child});

  @override
  DragFloatViewState createState() => DragFloatViewState();
}

class DragFloatViewState extends State<DragFloatView>
    with SingleTickerProviderStateMixin {
  //帧布局顶部距离
  double _top = 0;
  //帧布局左侧距离
  double _left = 0;
  //悬浮组件宽度，这里设置为宽高一直，因此height并没有声明
  double _width = 50;
  //记录屏幕或者父类组件宽度，用来判断拖拽听指挥后回归左右边缘判断
  double _parentWidth = 0;
  bool _isInitData = false;
  //悬浮组件透明度
  double _opacity = 0.3;
  //动画控制器
  late AnimationController _controller;
  //动画
  late Animation<double> _animation;
  //这里的浮动组件声明成了属性，目的就是防止多次刷新当此组件内部有一些单独的逻辑的情况下。
  late Widget _contentWidget;

  @override
  Widget build(BuildContext context) {
    //对于必要属性只进行一次计算
    if (_isInitData == false) {
      _top = MediaQuery.of(context).size.height - 200;
      _left = 15;
      _parentWidth = MediaQuery.of(context).size.width;
      _isInitData = true;
    }
    return new Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        widget.child,
        Positioned(
          top: _top,
          left: _left,
          child: new Opacity(child: _contentWidget, opacity: _opacity),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _contentWidget = new GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        _left += details.delta.dx;
        _top += details.delta.dy;
        _changePosition();
      },
      onPanEnd: (DragEndDetails details) {
        _changePosition();
        //判断悬浮组件左右回归操作
        _animateMoveBackAction();
      },
      onPanCancel: () {
        //当取消手势时进行边缘判断
        _changePosition();
      },
      onPanStart: (DragStartDetails details) {
        //开始拖拽时将悬浮框透明度设置为1.0
        setState(() {
          _opacity = 1.0;
        });
      },
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_width / 2.0)),
          color: Colors.red,
        ),
        width: _width,
        height: _width,
      ),
    );

    //这里初始化动画类
    _controller =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    _animation = Tween(begin: _left, end: _left).animate(_controller);
  }

  //位置边界判断
  void _changePosition() {
    if (_left < 0) {
      _left = 0;
    }

    if (_left >= MediaQuery.of(context).size.width - _width) {
      _left = MediaQuery.of(context).size.width - _width;
    }

    if (_top < 0) {
      _top = 0;
    }

    if (_top >= MediaQuery.of(context).size.height - _width) {
      _top = MediaQuery.of(context).size.height - _width;
    }
    //刷新界面
    setState(() {});
  }

  //中轴线回弹动画
  void _animateMoveBackAction() {
    double centerX = _left + _width / 2.0;
    double toPositionX = 0;
    double needMoveLength = 0;
    if (centerX <= _parentWidth / 2.0) {
      needMoveLength = _left;
    } else {
      needMoveLength = (_parentWidth - _left - _width);
    }
    double precent = (needMoveLength / (_parentWidth / 2.0));
    int time = (600 * precent).ceil();
    if (centerX <= _parentWidth / 2.0) {
      //回到左边缘
      toPositionX = 0;
    } else {
      //回到右边缘
      toPositionX = _parentWidth - _width;
    }
    //这里由于根据需要偏移的距离需要重新设置动画执行时长，那么之前的动画控制器就先销毁再创建。
    _controller.dispose();
    _controller = AnimationController(
        duration: Duration(milliseconds: time), vsync: this);
    //这里对监听 animation 执行过程进行监听，重新绘制悬浮组件位置
    _animation =
        Tween(begin: _left, end: toPositionX * 1.0).animate(_controller);
    _animation.addListener(() {
      _left = _animation.value.toDouble();
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(microseconds: 200), () {
          setState(() {
            _opacity = 0.3;
          });
        });
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DragFloatView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
