import 'package:flutter/material.dart';

class AppStyles {
  static const ButtonStyle accessButtons = ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(100, 40)),
      maximumSize: MaterialStatePropertyAll(Size(100, 40)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)))));
}
