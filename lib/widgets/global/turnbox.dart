import 'package:flutter/material.dart';

class TurnBox extends StatefulWidget {
  final double turns;
  final int speed;
  final Widget child;

  TurnBox(
      {Key key,
      this.turns = .0, //旋转的“圈”数,一圈为360度，如0.25圈即90度
      this.speed = 200, //过渡动画执行的总时长
      this.child})
      : super(key: key);

  @override
  TurnBoxState createState() => TurnBoxState();
}

class TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed ?? 200),
          curve: Curves.easeOut);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
