import 'package:flutter/material.dart';

class AdvanceMsgList {
  String? name;
  Icon? icon;
  Function? onPressed = () {};
  AdvanceMsgList({name, icon, onPressed}) {
    this.name = name;
    this.icon = icon;
    this.onPressed = onPressed;
  }
}
