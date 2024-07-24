import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:osrmtesting/core/theme/theme.dart';
import 'package:osrmtesting/core/widgets/customx_widgets.dart';

class LoginPage extends StatefulWidget {
  final String brand;
  const LoginPage({
    super.key,
    required this.brand,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController _ctrl = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stackedContainer(
          context: context,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.brand,
                  style: TextStyle(fontSize: 56, fontWeight: FontWeight.w700),
                ),
              ),
              spacer16h,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFormFieldWithLabel(
                    label: 'Email',
                    placeholder: 'Email terdaftar',
                    controller: _ctrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFormFieldWithLabel(
                    label: 'Password',
                    placeholder: 'Password',
                    controller: _ctrl),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: textButton(text: 'Lupa Kata Sandi?', style: text14b),
              ),
              CxMainButtonSvg(context, title: 'Masuk', stretch: true)
            ],
          )),
    );
  }
}

Widget stackedContainer(
    {required BuildContext context, Color? color, required Widget child}) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              fit: BoxFit.fitWidth,
              'assets/bg/top.png',
              color: color,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              fit: BoxFit.fitWidth,
              'assets/bg/bottom.png',
              color: color,
            ),
          ),
        ],
      ),
      child
    ],
  );
}
