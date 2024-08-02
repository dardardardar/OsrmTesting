import 'package:flutter/material.dart';
import 'package:osrmtesting/core/theme/custom_theme.dart';
import 'package:osrmtesting/core/theme/theme.dart';
import 'package:osrmtesting/core/utils/functions.dart';
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

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
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
                      fontSize: 50, fontWeight: FontWeight.w700),
                ),
                spacer16h,
                CxTextFormField(
                    label: 'Email',
                    placeholder: 'Email terdaftar',
                    validator: (value) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'Email yang diisi tidak valid!';
                      } else if (value.isEmpty) {
                        return 'Email tidak boleh kosong!';
                      } else {
                        return null;
                      }
                    },
                    controller: _emailCtrl),
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
                    controller: _passCtrl),
                spacer16h,
                spacer16h,
                CxTextButton(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (context) {
                          return ModalForgotPassword();
                        },
                      );
                    },
                    text: 'Lupa Kata Sandi?',
                    style: text14b),
                spacer16h,
                CxMainButton(
                  title: 'Masuk',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
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

class ModalForgotPassword extends StatefulWidget {
  const ModalForgotPassword({super.key});

  @override
  State<ModalForgotPassword> createState() => _ModalForgotPasswordState();
}

class _ModalForgotPasswordState extends State<ModalForgotPassword> {
  final TextEditingController _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: padding16,
          child: Column(
            children: [
              Padding(
                padding: padding8,
                child: Text(
                  forgotPassTitle,
                  style: text18b.copyWith(fontSize: 24),
                ),
              ),
              spacer16h,
              spacer16h,
              Text(
                forgotPassDetail,
                style: text14.copyWith(overflow: TextOverflow.visible),
              ),
              spacer8h,
              CxTextFormField(
                  placeholder: 'Email terdaftar',
                  validator: (value) {
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!)) {
                      return 'Email yang diisi tidak valid!';
                    } else if (value.isEmpty) {
                      return 'Email tidak boleh kosong!';
                    } else {
                      return null;
                    }
                  },
                  controller: _emailCtrl),
              SizedBox(
                height: context.width / 2,
              ),
              CxMainButton(
                onTap: () {},
                title: 'Reset Password',
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const forgotPassTitle = 'Lupa kata sandi anda?';
const forgotPassDetail =
    'Silahkan masukkan email anda. Anda akan menerima link reset password pada inbox email anda';
