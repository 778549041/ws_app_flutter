import 'package:flutter/material.dart';
import 'package:ws_app_flutter/widgets/global/base_alert_container.dart';

class BaseDialog extends StatelessWidget {
  BaseDialog({
    Key? key,
    this.title,
    this.content,
    this.leftText: "取消",
    this.rightText: "确认",
    this.onCancel,
    this.onConfirm,
    this.hiddenCancel: false,
  }) : super(key: key);

  final String? title;
  final Widget? content;
  final String leftText;
  final String rightText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final bool hiddenCancel;

  @override
  Widget build(BuildContext context) {
    Widget dialogTitle = Offstage(
      offstage: title == null || title == '' ? true : false,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          title == null ? "" : title!,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );

    Widget bottomButton = Row(
      children: <Widget>[
        hiddenCancel
            ? Container()
            : _DialogButton(
                text: leftText,
                textColor: Color(0xFF999999),
                onPressed: () {
                  Navigator.pop(context);
                  if (onCancel != null) {
                    onCancel!();
                  }
                },
              ),
        SizedBox(
          height: 48.0,
          width: 0.6,
          child: VerticalDivider(),
        ),
        _DialogButton(
          text: rightText,
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pop(context);
            if (onConfirm != null) {
              onConfirm!();
            }
          },
        ),
      ],
    );

    Widget body = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 24),
        dialogTitle,
        content == null ? Container() : Flexible(child: content!),
        SizedBox(height: 8),
        Divider(height: 1),
        bottomButton,
      ],
    );

    return BaseAlertContainer(
      Container(
        width: 270,
        child: body,
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  _DialogButton({
    Key? key,
    this.text: '',
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48.0,
        child: FlatButton(
          child: Text(
            text,
            style: TextStyle(fontSize: 18.0),
          ),
          textColor: textColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
