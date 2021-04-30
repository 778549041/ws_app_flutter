import 'package:flutter/material.dart';

class FlashView extends StatefulWidget {
  final double height;

  FlashView({this.height});

  @override
  FlashViewState createState() => FlashViewState();
}

class FlashViewState extends State<FlashView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: widget.height,
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Positioned(
              top: _animation.value,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/car/car_charge_animate.png'),
            );
          },
        )
      ],
    );
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: (widget.height - 90))
        .animate(_animationController);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FlashView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
