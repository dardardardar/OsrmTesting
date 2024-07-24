import 'package:flutter/material.dart';

class IconPath {
  static const _base = 'assets/icons/';
  static const info = "${_base}info.svg";
  static const tree = "${_base}tree.svg";
  static const plus = "${_base}plus.svg";
  static const minus = "${_base}minus.svg";
  static const edit = "${_base}rebase_edit.svg";
}

const primaryColor = Color(0xff49BF61);
const completeColor = Color(0xff008000);
const secondaryColor = Color(0xFF1B4CC8);
const pendingColor = Color(0xffADAD00);
const failedColor = Color(0xffAB0000);
const disabledColor = Color(0xFF808080);
const surfaceBackground = Color(0xFFFaFaFa);
const borderColor = Color(0xFFF3F3F3);
const colorSchemes = ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: secondaryColor,
    onSecondary: Colors.white,
    error: failedColor,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceTint: Colors.white);
