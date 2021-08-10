import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class CountDownBtn extends StatefulWidget {
  final Function()? getVCode; //获取验证码请求
  final Color bgColor; //背景色,默认透明
  final double width; //宽，默认110
  final double height; //高，默认34
  final Color textColor; //文字颜色，默认白色
  final Color disabledTextColor; //文字颜色，默认白色
  final Color? borderColor; //边框颜色，默认透明
  final Color disabledColor; //禁用时背景色，默认灰色
  final double radius; //圆角，默认17
  final int countDownNum; //倒计时总时间，默认59

  CountDownBtn(
      {Key? key,
      this.getVCode,
      this.bgColor = Colors.transparent,
      this.width = 110,
      this.height = 34,
      this.textColor = Colors.white,
      this.disabledTextColor = Colors.white,
      this.borderColor,
      this.disabledColor = Colors.grey,
      this.radius = 17,
      this.countDownNum = 59});

  @override
  CountDownBtnState createState() => CountDownBtnState();
}

class CountDownBtnState extends State<CountDownBtn> {
  TimerUtil? _timerUtil; //验证码倒计时
  String _btnStr = '获取验证码';
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        minWidth: widget.width,
        height: widget.height,
        textColor: _disabled ? widget.disabledTextColor : widget.textColor,
        color: _disabled ? widget.disabledColor : widget.bgColor,
        shape: widget.borderColor == null
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                side: BorderSide(
                  color: widget.borderColor!,
                  width: 0.5,
                )),
        child: Text(_btnStr, style: TextStyle(fontSize: 15.0)),
        onPressed: () => _disabled ? null : _getVCode());
  }

  Future _getVCode() async {
    bool isSuccess = await widget.getVCode!();
    if (isSuccess) {
      doCountDown();
    }
  }

  //倒计时
  void doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: widget.countDownNum * 1000);
    _timerUtil!.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      int _count = _tick.toInt();
      setState(() {
        _btnStr = '$_count重新获取';
        _disabled = true;
        if (_tick == 0) {
          _disabled = false;
          _btnStr = '获取验证码';
        }
      });
    });
    _timerUtil!.startCountDown();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timerUtil?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(CountDownBtn oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
