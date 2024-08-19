import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/app/theme/custom_theme.dart';
import 'package:osrmtesting/app/theme/theme.dart';
import 'package:osrmtesting/core/utils/extensions.dart';
import 'package:osrmtesting/core/utils/helpers.dart';
import 'package:osrmtesting/core/widgets/customx_widgets.dart';
import 'package:osrmtesting/features/home/presentation/pages/home_page.dart';
import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_bloc.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_state.dart';
import 'package:osrmtesting/features/login/presentation/blocs/send_auth_data/send_auth_data_bloc.dart';
import 'package:osrmtesting/features/login/presentation/blocs/send_auth_data/send_auth_data_event.dart';
import 'package:osrmtesting/features/login/presentation/blocs/send_auth_data/send_auth_data_state.dart';
import 'package:osrmtesting/features/login/presentation/pages/login_page_data.dart';
import 'package:osrmtesting/get_it_container.dart';

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
  late RemoteAuthBloc bloc;
  String email = '';
  String pass = '';

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<RemoteAuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoteAccountDataBloc, RemoteAccountDataState>(
      listener: (BuildContext context, RemoteAccountDataState state) {
        if (state is RemoteAccountDataDone) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()));
        }
      },
      child: Scaffold(
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
                      inputType: CxInputType.email,
                      label: 'Email',
                      onChanged: (p0) {
                        setState(() {
                          email = p0!;
                        });
                      },
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
                      inputType: CxInputType.password,
                      label: 'Password',
                      onChanged: (p0) {
                        setState(() {
                          pass = p0!;
                        });
                      },
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
                        final formData =
                            AuthFormEntity(email: email, password: pass);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const HomePage()));

                        bloc.add(SendAuthData(formData: formData));
                      }
                    },
                    color: primaryColor,
                    width: MediaQuery.of(context).size.width,
                  ),
                  spacer16h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Belum punya akun? '),
                      CxTextButton(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                        },
                        text: 'Daftar Sekarang',
                        style: text14b,
                      ),
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
      ),
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
          padding: padding16All,
          child: Column(
            children: [
              Padding(
                padding: padding8All,
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
                  inputType: CxInputType.email,
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CxStackContainer(
          hideBottomBackground: true,
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Register',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    CxTextFormField(
                        label: 'Username',
                        placeholder: 'Username',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username tidak boleh kosong!';
                          } else {
                            return null;
                          }
                        },
                        controller: _emailCtrl),
                    spacer16h,
                    CxTextFormField(
                        inputType: CxInputType.email,
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
                        inputType: CxInputType.phone,
                        label: 'Phone',
                        placeholder: 'Phone Number',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'No Telp tidak boleh kosong!';
                          } else {
                            return null;
                          }
                        },
                        controller: _emailCtrl),
                    spacer16h,
                    CxTextFormField(
                        inputType: CxInputType.password,
                        label: 'Password',
                        placeholder: 'Password',
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Password tidak boleh kosong!';
                          }
                          return null;
                        },
                        controller: _passCtrl),
                    spacer16h,
                    CxTextFormField(
                        inputType: CxInputType.password,
                        label: 'Confirm Password',
                        placeholder: 'Confirm Password',
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Confirm Password tidak boleh kosong!';
                          }
                          return null;
                        },
                        controller: _passCtrl),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(hasAccount),
                        spacer4w,
                        CxTextButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          text: 'Login',
                          style: text14b,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    CxMainButton(
                      title: 'Daftar',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        }
                      },
                      color: primaryColor,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
