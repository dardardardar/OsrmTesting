import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  final String jwt;

  const AuthResponseEntity({
    required this.jwt,
  });

  @override
  List<Object?> get props => [jwt];
}
