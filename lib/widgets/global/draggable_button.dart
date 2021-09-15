library draggable_floating_button;

import 'package:flutter/material.dart';

const BoxConstraints _kSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

const BoxConstraints _kMiniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

/*
const BoxConstraints _kExtendedSizeConstraints = BoxConstraints(
  minHeight: 48.0,
  maxHeight: 48.0,
);
*/

const Offset _kDefaultOffset = Offset(0, 0);

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}

class DraggableButton extends StatefulWidget {
  DraggableButton({
    Key? key,
    this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation = 6.0,
    this.highlightElevation = 12.0,
    required this.onPressed,
    this.mini = false,
    this.shape = const CircleBorder(),
    this.clipBehavior = Clip.none,
    this.materialTapTargetSize,
    this.isExtended = false,
    required this.appContext,
    this.appBarHeight = 0,
    this.bottomBarHeight = 0,
    this.data = 'dfab',
    this.offset = _kDefaultOffset,
  })  : _sizeConstraints = mini ? _kMiniSizeConstraints : _kSizeConstraints,
        super(key: key);

  final Widget? child;

  final String? tooltip;

  final Color? foregroundColor;

  final Color? backgroundColor;

  final Object heroTag;

  final VoidCallback onPressed;

  final double elevation;

  final double highlightElevation;

  final bool mini;

  final ShapeBorder shape;

  final Clip clipBehavior;

  final bool isExtended;

  final MaterialTapTargetSize? materialTapTargetSize;

  final BuildContext appContext;

  final double appBarHeight;

  final double bottomBarHeight;

  final Offset offset;

  final BoxConstraints _sizeConstraints;

  final String data;

  @override
  State<StatefulWidget> createState() => _DraggableButtonState();
}

class _DraggableButtonState extends State<DraggableButton>
    with TickerProviderStateMixin {
  //帧布局顶部距离
  double _top = 0;
  //帧布局左侧距离
  double _left = 0;
  //动画控制器
  late AnimationController _controller;
  //动画
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _top = widget.offset.dy;
    _left = widget.offset.dx;
    //这里初始化动画类
    _controller =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    _animation = Tween(begin: _left, end: _left).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    FloatingActionButton _floatingActionButton = new FloatingActionButton(
        key: widget.key,
        child: widget.child,
        tooltip: widget.tooltip,
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        heroTag: widget.heroTag,
        elevation: widget.elevation,
        highlightElevation: widget.highlightElevation,
        onPressed: widget.onPressed,
        shape: widget.shape,
        isExtended: widget.isExtended,
        materialTapTargetSize: widget.materialTapTargetSize,
        clipBehavior: widget.clipBehavior,
        mini: widget.mini);

    return Positioned(
      left: _left,
      top: _top,
      child: Draggable(
        data: widget.data,
        child: _floatingActionButton,
        feedback: _floatingActionButton,
        childWhenDragging: Container(),
        onDragUpdate: (DragUpdateDetails? details) {
          setState(() {
            _left += details!.delta.dx;
            _top += details.delta.dy;
          });
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          setState(() {
            var dy = offset.dy -
                widget.appBarHeight -
                MediaQuery.of(widget.appContext).padding.top;
            var dx = offset.dx;

            var maxDy = MediaQuery.of(widget.appContext).size.height -
                MediaQuery.of(widget.appContext).padding.bottom -
                widget.appBarHeight -
                widget.bottomBarHeight -
                MediaQuery.of(widget.appContext).padding.top -
                widget._sizeConstraints.maxHeight;

            if (dy < 0) {
              dy = 0;
            } else if (dy > maxDy) {
              dy = maxDy;
            }
            if (dx < 0 ||
                (dx + widget._sizeConstraints.maxWidth / 2) <
                    MediaQuery.of(widget.appContext).size.width / 2) {
              dx = 0;
            } else if ((dx + widget._sizeConstraints.maxWidth) >
                    MediaQuery.of(widget.appContext).size.width ||
                (dx + widget._sizeConstraints.maxWidth / 2) >
                    MediaQuery.of(widget.appContext).size.width / 2) {
              dx = MediaQuery.of(widget.appContext).size.width -
                  widget._sizeConstraints.maxWidth;
            }
            _top = dy;
            //这里由于根据需要偏移的距离需要重新设置动画执行时长，那么之前的动画控制器就先销毁再创建。
            _controller.dispose();
            _controller = AnimationController(
                duration: Duration(milliseconds: 250), vsync: this);
            //这里对监听 animation 执行过程进行监听，重新绘制悬浮组件位置
            _animation = Tween(begin: _left, end: dx).animate(_controller);
            _animation.addListener(() {
              _left = _animation.value.toDouble();
              setState(() {});
            });
            _controller.forward();
          });
        },
      ),
    );
  }
}
