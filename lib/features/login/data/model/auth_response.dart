import 'package:osrmtesting/features/login/domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({
    required super.jwt,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      jwt: json["jwt"],
    );
  }
}
