// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osrmtesting/core/theme/theme.dart';

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
    return Row(
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
            customIcon: IconPath.minus),
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
            customIcon: IconPath.plus)
      ],
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
  bool stretch = false,
}) {
  final widget = InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: padding12,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: icon != null
          ? Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(icon.toString(),
                      width: 18,
                      colorFilter: ColorFilter.mode(
                          isLight ? Colors.black : Colors.white,
                          BlendMode.srcIn)),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: isLight ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
            )
          : Text(
              title,
              style: TextStyle(
                  color: isLight ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
    ),
  );
  if (stretch) {
    return Expanded(child: widget);
  }
  return Flexible(
    child: SizedBox(
      width: 148,
      child: widget,
    ),
  );
}

Widget CxCircleBorderBtnSvg(
    {required Function()? onPressed,
    double size = 42,
    String? customIcon,
    Color? color}) {
  final c = color ?? const Color(0xff000000);

  return SizedBox(
    width: size,
    height: size,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        overlayColor: c,
        side: BorderSide(width: 1.5, color: c),
        shape: const CircleBorder(),
      ),
      child: customIcon == null
          ? const Center()
          : SvgPicture.asset(customIcon,
              width: 20, colorFilter: ColorFilter.mode(c, BlendMode.srcIn)),
    ),
  );
}
