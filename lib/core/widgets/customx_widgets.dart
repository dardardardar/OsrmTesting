// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osrmtesting/core/theme/theme.dart';

class CxIcons {
  static const _base = 'assets/icons/';
  static String info = "${_base}info.svg";
  static String tree = "${_base}tree.svg";
  static String plus = "${_base}plus.svg";
  static String minus = "${_base}minus.svg";
  static String edit = "${_base}rebase_edit.svg";
}

class CxInputQty extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final Function(int) onQtyChanged;
  final Color? color;

  const CxInputQty(
      {super.key,
      this.initialValue = 0,
      this.minValue = 0,
      this.maxValue = 2147483647,
      this.color,
      required this.onQtyChanged});

  @override
  State<StatefulWidget> createState() {
    return _CxInputQty();
  }
}

class _CxInputQty extends State<CxInputQty> {
  TextEditingController controller = TextEditingController();
  int value = 0;

  _count({bool? increase}) {
    if (increase != null && increase) {
      if (value < widget.maxValue) {
        setState(() {
          value++;
        });
      }
    } else {
      if (value > widget.minValue) {
        setState(() {
          value--;
        });
      }
    }
    controller.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CxCircleBorderBtnSvg(
              onPressed: value <= 0
                  ? () {}
                  : () {
                      _count();
                      widget.onQtyChanged(value);
                    },
              color: widget.color ?? Theme.of(context).primaryColor,
              customIcon: CxIcons.minus),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 72),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  value = int.tryParse(val) ?? 0;
                  widget.onQtyChanged(value);
                });
              },
              controller: controller,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '0',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          ),
          CxCircleBorderBtnSvg(
              onPressed: () {
                _count(increase: true);
                widget.onQtyChanged(value);
              },
              color: widget.color ?? Theme.of(context).primaryColor,
              customIcon: CxIcons.plus)
        ],
      ),
    );
  }
}

Widget CxMainButtonSvg(
  BuildContext context, {
  Function()? onTap,
  required String title,
  String? icon,
  Color? color,
  bool isLight = false,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding12,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(icon.toString(),
                      colorFilter: ColorFilter.mode(
                          isLight ? Colors.black : Colors.white,
                          BlendMode.srcIn)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: isLight ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            : Text(
                title,
                style: TextStyle(
                    color: isLight ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600),
              ),
      ),
    ),
  );
}

Widget CxCircleBorderBtnSvg(
    {required Function()? onPressed,
    double width = 48,
    String? customIcon,
    Color? color}) {
  final c = color ?? const Color(0xff000000);

  return SizedBox(
    width: width,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          overlayColor: c,
          side: BorderSide(width: 1.5, color: c),
          shape: const CircleBorder(),
          padding: padding12),
      child: customIcon == null
          ? const Center()
          : SvgPicture.asset(customIcon,
              colorFilter: ColorFilter.mode(c, BlendMode.srcIn)),
    ),
  );
}
