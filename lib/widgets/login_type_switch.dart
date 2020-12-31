import 'package:flutter/material.dart';

class LoginTypeSwitchWidget extends StatefulWidget {
  final Function(int, String) slideAction;
  final List<String> list;
  final double width;
  final double height;

  LoginTypeSwitchWidget(
      {this.slideAction,
      this.list,
      this.width,
      this.height});
  @override
  LoginTypeSwitchWidgetState createState() => LoginTypeSwitchWidgetState();
}

class LoginTypeSwitchWidgetState extends State<LoginTypeSwitchWidget> {
  ScrollController _controller;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var itemWidth = widget.width / widget.list.length;
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: ListView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.list.length * 100,
        itemExtent: itemWidth,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //滚动到相应位置
              double offset = index * itemWidth;
              setState(() {
                _currentIndex = index;
              });
              _controller.animateTo(offset,
                  duration: Duration(milliseconds: 300), curve: Curves.easeIn);
              widget.slideAction(index % widget.list.length,
                  widget.list[index % widget.list.length]);
            },
            child: Container(
              child: Text(
                widget.list[index % widget.list.length],
                style: TextStyle(color: _currentIndex == index ? Colors.white : Colors.white.withOpacity(0.6), fontSize: 24),
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LoginTypeSwitchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
