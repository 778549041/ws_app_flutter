import 'package:flutter/material.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class CartAddReduceWidget extends StatefulWidget {
  final int count;
  final Function(int) onCountChanged;

  CartAddReduceWidget({this.count = 1, required this.onCountChanged});

  @override
  CartAddReduceWidgetState createState() => CartAddReduceWidgetState();
}

class CartAddReduceWidgetState extends State<CartAddReduceWidget> {
  int _currentCount = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[_reduceBtn(), _countArea(), _addBtn()],
    );
  }

  //减少按钮
  Widget _reduceBtn() {
    return CustomButton(
      clickInterval: 0,
      width: 30,
      height: 30,
      borderColor: Colors.black12,
      borderWidth: 0.5,
      title: '-',
      titleColor: Colors.black45,
      onPressed: () {
        if (_currentCount > 1) {
          setState(() {
            _currentCount--;
          });
          widget.onCountChanged(_currentCount);
        }
      },
    );
  }

  //加号
  Widget _addBtn() {
    return CustomButton(
      clickInterval: 0,
      width: 30,
      height: 30,
      borderColor: Colors.black12,
      borderWidth: 0.5,
      title: '+',
      titleColor: Colors.black45,
      onPressed: () {
        setState(() {
          _currentCount++;
        });
        widget.onCountChanged(_currentCount);
      },
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: 30, //爬两个数字的这里显示不下就宽一点70
      height: 30, //高度和加减号保持一样的高度
      alignment: Alignment.center, //上下左右居中
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black12, width: 0.5),
          bottom: BorderSide(color: Colors.black12, width: 0.5),
        ),
      ),

      child: Text(
        _currentCount.toString(),
        style: TextStyle(color: Colors.black45, fontSize: 12),
      ), //先默认设置为1 因为后续是动态的获取数字
    );
  }

  @override
  void initState() {
    _currentCount = widget.count;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(CartAddReduceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
