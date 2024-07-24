// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osrmtesting/core/theme/custom_theme.dart';
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
            color: widget.color ?? Colors.black,
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
            color: widget.color ?? Colors.black,
            customIcon: IconPath.plus)
      ],
    );
  }
}

Widget CxMainButton(
  BuildContext context, {
  Function()? onTap,
  required String title,
  String? icon,
  Color? color,
  bool isLight = false,
  bool stretch = false,
}) {
  return MaterialButton(
    onPressed: onTap,
    color: color,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    height: 36,
    padding: EdgeInsets.symmetric(horizontal: 32),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon.toString(),
            width: 18,
            colorFilter: ColorFilter.mode(
                isLight ? Colors.black : Colors.white, BlendMode.srcIn)),
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
  );
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
      height: 60,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ?? Colors.black,
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
    return SizedBox(width: double.infinity, child: widget);
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
    double size = 36,
    String? customIcon,
    Color? color}) {
  return SizedBox(
    width: size,
    height: size,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        overlayColor: color,
        side: BorderSide(width: 1.5, color: color ?? Colors.black),
        shape: const CircleBorder(),
      ),
      child: customIcon == null
          ? const Center()
          : SvgPicture.asset(customIcon,
              width: 18,
              colorFilter:
                  ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn)),
    ),
  );
}

Widget textFormFieldWithLabel({
  required String label,
  required String placeholder,
  String? Function(String?)? validator,
  required TextEditingController controller,
  bool? isPassword,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label),
      spacer8h,
      TextFormField(
        validator: validator,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
            fillColor: surfaceBackground,
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1),
            ),
            border: const OutlineInputBorder(),
            filled: true,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: failedColor, width: 1),
            ),
            hintText: placeholder),
      ),
    ],
  );
}

Widget textButton({Function()? onTap, required String text, TextStyle? style}) {
  return InkWell(
    onTap: onTap,
    child: Text(
      text,
      style: style,
    ),
  );
}
