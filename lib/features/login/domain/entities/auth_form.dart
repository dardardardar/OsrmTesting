import 'package:equatable/equatable.dart';

class AuthFormEntity extends Equatable {
  final String email;
  final String password;

  const AuthFormEntity({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
