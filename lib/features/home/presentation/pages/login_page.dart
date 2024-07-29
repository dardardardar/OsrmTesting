import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:osrmtesting/core/theme/custom_theme.dart';
import 'package:osrmtesting/core/theme/theme.dart';
import 'package:osrmtesting/core/widgets/customx_widgets.dart';
import 'package:osrmtesting/features/home/presentation/pages/home_page.dart';

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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CxStackContainer(
          child: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.brand,
                  style: const TextStyle(
                      fontSize: 56, fontWeight: FontWeight.w700),
                ),
                spacer16h,
                CxTextFormField(
                    label: 'Email',
                    placeholder: 'Email terdaftar',
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: _ctrl),
                spacer16h,
                CxTextFormField(
                    isPassword: true,
                    label: 'Password',
                    placeholder: 'Password',
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: _ctrl),
                spacer16h,
                spacer16h,
                const CxTextButton(text: 'Lupa Kata Sandi?', style: text14b),
                spacer16h,
                CxMainButton(
                  title: 'Masuk',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HarvestPage()));
                    }
                  },
                  color: primaryColor,
                  width: MediaQuery.of(context).size.width,
                ),
                spacer16h,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? '),
                    CxTextButton(text: 'Daftar Sekarang', style: text14b),
                  ],
                ),
                spacer16h,
                spacer16h,
                spacer16h,
                Text('Version 0.1'),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
