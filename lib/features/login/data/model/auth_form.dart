import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';

class AuthFormModel extends AuthFormEntity {
  const AuthFormModel({
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  factory AuthFormModel.formEntity(AuthFormEntity e) {
    return AuthFormModel(
      email: e.email,
      password: e.password,
    );
  }
}
