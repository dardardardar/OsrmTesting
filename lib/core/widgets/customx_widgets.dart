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
            onTap: value <= 0
                ? () {}
                : () {
                    _count();
                    widget.onQtyChanged(value);
                  },
            color: widget.color ?? Colors.black,
            icon: IconPath.minus),
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
            onTap: () {
              _count(increase: true);
              widget.onQtyChanged(value);
            },
            color: widget.color ?? Colors.black,
            icon: IconPath.plus)
      ],
    );
  }
}

class CxMainButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String? icon;
  final Color? color;
  final bool isLight;
  final double? width;
  const CxMainButton(
      {super.key,
      this.onTap,
      required this.title,
      this.icon,
      this.color,
      this.isLight = false,
      this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? SvgPicture.asset(icon!,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                        isLight ? Colors.black : Colors.white, BlendMode.srcIn))
                : const Center(),
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
      ),
    );
  }
}

class CxMainButtonSvg extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String? icon;
  final Color? color;
  final bool isLight;
  final bool stretch;
  const CxMainButtonSvg(
      {super.key,
      this.onTap,
      required this.title,
      this.icon,
      this.color,
      this.isLight = false,
      this.stretch = false});

  @override
  Widget build(BuildContext context) {
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
}

class CxCircleBorderBtnSvg extends StatelessWidget {
  final Function()? onTap;
  final double size;
  final String? icon;
  final Color? color;
  const CxCircleBorderBtnSvg(
      {super.key, this.onTap, this.size = 36, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          overlayColor: color,
          side: BorderSide(width: 1.5, color: color ?? Colors.black),
          shape: const CircleBorder(),
        ),
        child: icon == null
            ? const Center()
            : SvgPicture.asset(icon!,
                width: 18,
                colorFilter:
                    ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn)),
      ),
    );
  }
}

class CxTextFormField extends StatefulWidget {
  final String? label;
  final String placeholder;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final Color? background;

  const CxTextFormField(
      {super.key,
      this.label,
      required this.placeholder,
      required this.controller,
      this.validator,
      this.isPassword = false,
      this.background});

  @override
  State<CxTextFormField> createState() => _CxTextFormFieldState();
}

class _CxTextFormFieldState extends State<CxTextFormField> {
  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.label != null ? Text(widget.label!) : const Center(),
        spacer8h,
        TextFormField(
          obscureText: widget.isPassword! && !_passwordVisible ? true : false,
          validator: widget.validator,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
              suffixIcon: widget.isPassword!
                  ? IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )
                  : null,
              fillColor: widget.background ?? surfaceBackground,
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
              hintText: widget.placeholder),
        ),
      ],
    );
  }
}

class CxTextButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final TextStyle? style;
  const CxTextButton({super.key, this.onTap, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class CxStackContainer extends StatelessWidget {
  final Color? color;
  final Widget child;
  final bool hideTopBackground;
  final bool hideBottomBackground;
  final Widget? bottomAppBar;
  const CxStackContainer(
      {super.key,
      this.color,
      required this.child,
      this.hideTopBackground = false,
      this.hideBottomBackground = false,
      this.bottomAppBar});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            hideTopBackground
                ? const Center()
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      fit: BoxFit.fitWidth,
                      'assets/bg/top.png',
                      color: color,
                    ),
                  ),
            const Spacer(),
            hideBottomBackground
                ? const Center()
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      fit: BoxFit.fitWidth,
                      'assets/bg/bottom.png',
                      color: color,
                    ),
                  ),
          ],
        ),
        child,
        bottomAppBar != null
            ? Column(
                children: [const Spacer(), bottomAppBar!],
              )
            : const Center()
      ],
    );
  }
}
