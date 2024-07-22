import 'package:flutter/widgets.dart';

const primaryColor = Color(0xff49BF61);
const completeColor = Color(0xff008000);
const pendingColor = Color(0xffADAD00);
const failedColor = Color(0xffAB0000);
const disabledColor = Color(0xFF808080);

const padding4 = EdgeInsets.all(4);
const padding8 = EdgeInsets.all(8);
const padding12 = EdgeInsets.all(12);
const padding16 = EdgeInsets.all(16);
const padding24 = EdgeInsets.all(24);

const text12 = TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis);
const text10 = TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis);
const text14 = TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis);
const text16 = TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis);
const text18 = TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis);

class IconPath {
  static const _base = 'assets/icons/';
  static const info = "${_base}info.svg";
  static const tree = "${_base}tree.svg";
  static const plus = "${_base}plus.svg";
  static const minus = "${_base}minus.svg";
  static const edit = "${_base}rebase_edit.svg";
}

const text10b = TextStyle(
    fontSize: 10, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600);
const text12b = TextStyle(
    fontSize: 12, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600);
const text14b = TextStyle(
    fontSize: 14, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600);
const text16b = TextStyle(
    fontSize: 16, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600);
const text18b = TextStyle(
    fontSize: 18, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600);

const spacer4w = SizedBox(
  width: 4,
);
const spacer4h = SizedBox(
  height: 4,
);
const spacer8w = SizedBox(
  width: 8,
);
const spacer8h = SizedBox(
  height: 8,
);
const spacer12w = SizedBox(
  width: 12,
);
const spacer12h = SizedBox(
  height: 12,
);
const spacer16w = SizedBox(
  width: 16,
);
const spacer16h = SizedBox(
  height: 16,
);
