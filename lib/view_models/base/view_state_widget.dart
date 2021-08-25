import 'package:flutter/material.dart';
import 'package:ws_app_flutter/view_models/base/view_state.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

///加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

///页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String? message;
  final String? image;
  final String? buttonText;
  final VoidCallback? onPressed;

  ViewStateEmptyWidget(
      {Key? key, this.onPressed, this.image, this.message, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          image!,
          width: 200,
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Text(message ?? '',
              style: TextStyle(color: Color(0xFF4245E5), fontSize: 18)),
        ),
        if (buttonText != null)
          CustomButton(
            width: 140,
            height: 40,
            radius: 20,
            title: buttonText,
            backgroundColor: Color(0xFF4245E5),
            titleColor: Colors.white,
            onPressed: onPressed,
          ),
      ],
    );
  }
}

///基础Widget
class ViewStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback onPressed;

  ViewStateWidget(
      {Key? key,
      this.image,
      this.title,
      this.message,
      this.buttonText,
      required this.onPressed,
      this.buttonTextData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle =
        Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey);
    var messageStyle = titleStyle.copyWith(
        color: titleStyle.color!.withOpacity(0.7), fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        image ??
            Icon(
              IconData(0xe600, fontFamily: 'iconfont'),
              size: 80,
              color: Colors.grey[500],
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? "加载失败",
                style: titleStyle,
              ),
              Text(message ?? '', style: messageStyle),
            ],
          ),
        ),
        if (buttonText != null)
          ViewStateButton(
            onPressed: onPressed,
            child: buttonText,
            textData: buttonTextData,
          )
      ],
    );
  }
}

///ErrorWidget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback onPressed;

  ViewStateErrorWidget(
      {Key? key,
      required this.error,
      required this.onPressed,
      this.image,
      this.title,
      this.message,
      this.buttonText,
      this.buttonTextData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.message;
    String defaultTextData = "重试";
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = Transform.translate(
          offset: Offset(-50, 0),
          child: const Icon(
            IconData(0xe678, fontFamily: 'iconfont'),
            size: 100,
            color: Colors.grey,
          ),
        );
        defaultTitle = "加载失败，请检查您的网络状况";
        break;

      case ViewStateErrorType.defaultError:
        defaultImage = const Icon(
          IconData(0xe600, fontFamily: 'iconfont'),
          size: 100,
          color: Colors.grey,
        );
        defaultTitle = "加载失败";
        break;

      case ViewStateErrorType.unauthorizedError:
        return Container();
    }
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonText: buttonText,
      buttonTextData: buttonTextData ?? defaultTextData,
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback onPressed;

  ViewStateUnAuthWidget(
      {Key? key,
      required this.onPressed,
      this.image,
      this.message,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(),
      title: message ?? "您还未登录",
      buttonText: buttonText,
      buttonTextData: "登录",
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        'assets/images/ic_login_logo.png',
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

///公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? textData;

  ViewStateButton({required this.onPressed, this.child, this.textData})
      : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      child: child ??
          Text(
            textData ?? "重试",
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}
