import 'package:flutter/material.dart';

class BaseAlertContainer extends StatelessWidget {
  final Widget child;

  BaseAlertContainer(this.child);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.symmetric(horizontal: 15.0, vertical: 24.0),
      duration: Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(5),
            child: child,
          ),
        ),
      ),
    );
  }
}
